from django.db import transaction

from documents.models import Document, DocumentChunk

from .chunking import split_text


@transaction.atomic
def ingest_document(document: Document):

    document.chunks.all().delete()

    chunks = split_text(
        document.content
    )

    DocumentChunk.objects.bulk_create(
        [
            DocumentChunk(
                document=document,
                chunk_index=index,
                content=content,
            )
            for index, content in enumerate(chunks)
        ]
    )

    return document.chunks.count()