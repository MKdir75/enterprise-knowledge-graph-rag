from django.db.models import Q

from ..models import Entity, Relationship


def get_accessible_relationships(user):

    if user.role == "ADMIN":

        return (
            Relationship.objects
            .select_related(
                "source",
                "target",
                "source_document",
                "source_chunk",
            )
            .filter(
                source_document__is_active=True
            )
        )

    return (
        Relationship.objects
        .select_related(
            "source",
            "target",
            "source_document",
            "source_chunk",
        )
        .filter(
            source_document__is_active=True,
            source_document__department__iexact=(
                user.department
            ),
        )
    )


def get_entity_neighborhood(
    entity_id,
    depth=1,
    user=None,
):

    relationships = get_accessible_relationships(
        user
    )

    visited_entities = {
        entity_id
    }

    current_entities = {
        entity_id
    }

    collected_relationship_ids = set()

    for _ in range(depth):

        next_entities = set()

        current_relationships = (
            relationships
            .filter(
                Q(
                    source_id__in=current_entities
                )
                |
                Q(
                    target_id__in=current_entities
                )
            )
        )

        for relationship in current_relationships:

            collected_relationship_ids.add(
                relationship.id
            )

            next_entities.add(
                relationship.source_id
            )

            next_entities.add(
                relationship.target_id
            )

        next_entities -= visited_entities

        visited_entities.update(
            next_entities
        )

        current_entities = next_entities

        if not current_entities:
            break

    entities = Entity.objects.filter(
        id__in=visited_entities
    )

    collected_relationships = relationships.filter(
        id__in=collected_relationship_ids
    )

    return {
        "entities": entities,
        "relationships": collected_relationships,
    }