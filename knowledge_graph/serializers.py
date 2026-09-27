from rest_framework import serializers

from .models import Entity, Relationship


class EntitySerializer(serializers.ModelSerializer):

    class Meta:

        model = Entity

        fields = [
            "id",
            "name",
            "entity_type",
            "description",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "created_at",
        ]


class RelationshipSerializer(
    serializers.ModelSerializer
):

    source_name = serializers.CharField(
        source="source.name",
        read_only=True,
    )

    target_name = serializers.CharField(
        source="target.name",
        read_only=True,
    )

    class Meta:

        model = Relationship

        fields = [
            "id",
            "source",
            "source_name",
            "target",
            "target_name",
            "relation_type",
            "description",
            "source_document",
            "source_chunk",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "created_at",
        ]