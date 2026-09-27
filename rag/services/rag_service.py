from django.db.models import Q

from documents.models import DocumentChunk
from knowledge_graph.models import Entity, Relationship

from .openai_service import OpenAIService


STOP_WORDS = {
    "what",
    "which",
    "where",
    "when",
    "does",
    "do",
    "did",
    "the",
    "a",
    "an",
    "is",
    "are",
    "was",
    "were",
    "for",
    "to",
    "of",
    "in",
    "on",
    "and",
    "or",
    "with",
    "how",
    "can",
    "could",
    "would",
    "should",
    "this",
    "that",
}


def normalize_words(text):
    """
    Convert text into useful searchable words.
    """

    words = []

    for word in text.lower().split():

        cleaned_word = word.strip(
            ".,!?;:()[]{}\"'"
        )

        if (
            len(cleaned_word) >= 3
            and cleaned_word not in STOP_WORDS
        ):
            words.append(cleaned_word)

    return words


def retrieve_chunks(question, user, limit=5):
    """
    Retrieve authorized chunks and keep only
    sufficiently relevant chunks.
    """

    words = normalize_words(question)

    if not words:
        return []

    query = Q()

    for word in words:
        query |= Q(
            content__icontains=word
        )

    # -------------------------------------------------
    # Authorization
    # -------------------------------------------------

    if user.role == "ADMIN":

        chunks_queryset = (
            DocumentChunk.objects
            .filter(
                query,
                document__is_active=True,
            )
        )

    else:

        chunks_queryset = (
            DocumentChunk.objects
            .filter(
                query,
                document__is_active=True,
                document__department__iexact=(
                    user.department
                ),
            )
        )

    chunks = list(
        chunks_queryset
        .select_related("document")
    )

    # -------------------------------------------------
    # Relevance scoring
    # -------------------------------------------------

    scored_chunks = []

    for chunk in chunks:

        content = chunk.content.lower()

        score = 0

        for word in words:

            occurrences = content.count(word)

            if occurrences > 0:
                score += 1

                # Extra weight for repeated matches
                if occurrences > 1:
                    score += min(
                        occurrences - 1,
                        2,
                    )

        scored_chunks.append(
            (
                score,
                chunk,
            )
        )

    # -------------------------------------------------
    # Sort by relevance
    # -------------------------------------------------

    scored_chunks.sort(
        key=lambda item: item[0],
        reverse=True,
    )

    # -------------------------------------------------
    # Relevance threshold
    # -------------------------------------------------

    MIN_RELEVANCE_SCORE = 2

    relevant_chunks = [
        chunk
        for score, chunk in scored_chunks
        if score >= MIN_RELEVANCE_SCORE
    ]

    return relevant_chunks[:limit]

def retrieve_entities(
    question,
    user,
    limit=10,
):
    """
    Retrieve only graph entities that are connected
    to documents accessible by the current user.
    """

    words = normalize_words(question)

    if not words:
        return []

    query = Q()

    for word in words:

        query |= Q(
            name__icontains=word
        )

    # -------------------------------------------------
    # ADMIN can access all active graph relationships
    # -------------------------------------------------

    if user.role == "ADMIN":

        entities = (
            Entity.objects
            .filter(query)
            .distinct()[:limit]
        )

        return list(entities)

    # -------------------------------------------------
    # Get relationships from user's department
    # -------------------------------------------------

    accessible_relationships = (
        Relationship.objects
        .filter(
            source_document__is_active=True,
            source_document__department__iexact=(
                user.department
            ),
        )
    )

    source_entity_ids = (
        accessible_relationships
        .values_list(
            "source_id",
            flat=True,
        )
    )

    target_entity_ids = (
        accessible_relationships
        .values_list(
            "target_id",
            flat=True,
        )
    )

    accessible_entity_ids = (
        Entity.objects
        .filter(
            Q(id__in=source_entity_ids)
            |
            Q(id__in=target_entity_ids)
        )
        .values_list(
            "id",
            flat=True,
        )
    )

    entities = (
        Entity.objects
        .filter(
            id__in=accessible_entity_ids
        )
        .filter(query)
        .distinct()[:limit]
    )

    return list(entities)


def build_context(
    chunks,
    entities,
    user,
):
    """
    Build the authorized context that will be sent
    to the LLM.
    """

    context_parts = []

    # -------------------------------------------------
    # Document context
    # -------------------------------------------------

    for chunk in chunks:

        context_parts.append(
            f"""
DOCUMENT:
{chunk.document.title}

DEPARTMENT:
{chunk.document.department}

CHUNK:
{chunk.content}
"""
        )

    # -------------------------------------------------
    # Knowledge Graph context
    # -------------------------------------------------

    for entity in entities:

        if user.role == "ADMIN":

            relationships = (
                Relationship.objects
                .filter(
                    Q(source=entity)
                    |
                    Q(target=entity),
                    source_document__is_active=True,
                )
                .select_related(
                    "source",
                    "target",
                )[:10]
            )

        else:

            relationships = (
                Relationship.objects
                .filter(
                    Q(source=entity)
                    |
                    Q(target=entity),
                    source_document__is_active=True,
                    source_document__department__iexact=(
                        user.department
                    ),
                )
                .select_related(
                    "source",
                    "target",
                )[:10]
            )

        context_parts.append(
            f"""
ENTITY:
{entity.name}

ENTITY TYPE:
{entity.entity_type}
"""
        )

        for relationship in relationships:

            context_parts.append(
                (
                    f"{relationship.source.name} "
                    f"--[{relationship.relation_type}]--> "
                    f"{relationship.target.name}"
                )
            )

    return "\n".join(context_parts)


def answer_question(
    question,
    user,
):
    """
    Main RAG pipeline.
    """

    # -------------------------------------------------
    # 1. Retrieve authorized document chunks
    # -------------------------------------------------

    chunks = retrieve_chunks(
        question,
        user,
    )

    # -------------------------------------------------
    # 2. Retrieve authorized graph entities
    # -------------------------------------------------

    entities = retrieve_entities(
        question,
        user,
    )

    # -------------------------------------------------
    # 3. Build authorized context
    # -------------------------------------------------

    context = build_context(
        chunks,
        entities,
        user,
    )

    # -------------------------------------------------
    # 4. Generate answer
    # -------------------------------------------------

    openai_service = OpenAIService()

    answer = openai_service.generate_answer(
        question=question,
        context=context,
    )

    # -------------------------------------------------
    # 5. Build sources
    # -------------------------------------------------

    sources = [
        {
            "document_id": chunk.document.id,
            "document_title": chunk.document.title,
            "chunk_id": chunk.id,
        }
        for chunk in chunks
    ]

    # -------------------------------------------------
    # 6. Return final RAG response
    # -------------------------------------------------

    return {
        "answer": answer,
        "sources": sources,
        "entities": [
            {
                "id": entity.id,
                "name": entity.name,
                "type": entity.entity_type,
            }
            for entity in entities
        ],
    }