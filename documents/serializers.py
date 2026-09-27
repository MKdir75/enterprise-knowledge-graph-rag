from rest_framework import serializers

from .models import Document, DocumentChunk


class DocumentSerializer(serializers.ModelSerializer):

    uploaded_by = serializers.StringRelatedField(
        read_only=True
    )

    chunk_count = serializers.IntegerField(
        source="chunks.count",
        read_only=True,
    )

    class Meta:

        model = Document

        fields = [
            "id",
            "title",
            "description",
            "document_type",
            "content",
            "department",
            "uploaded_by",
            "is_active",
            "chunk_count",
            "created_at",
            "updated_at",
        ]

        read_only_fields = [
            "id",
            "uploaded_by",
            "created_at",
            "updated_at",
        ]


class DocumentChunkSerializer(
    serializers.ModelSerializer
):

    class Meta:

        model = DocumentChunk

        fields = [
            "id",
            "document",
            "chunk_index",
            "content",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "created_at",
        ]