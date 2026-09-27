from django.db import models

from documents.models import Document, DocumentChunk


class Entity(models.Model):

    class EntityType(models.TextChoices):
        PERSON = "PERSON", "Person"
        ORGANIZATION = "ORGANIZATION", "Organization"
        PROJECT = "PROJECT", "Project"
        PRODUCT = "PRODUCT", "Product"
        TECHNOLOGY = "TECHNOLOGY", "Technology"
        LOCATION = "LOCATION", "Location"
        OTHER = "OTHER", "Other"

    name = models.CharField(
        max_length=255
    )

    entity_type = models.CharField(
        max_length=30,
        choices=EntityType.choices,
    )

    description = models.TextField(
        blank=True
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=[
                    "name",
                    "entity_type",
                ],
                name="unique_entity_type_name",
            )
        ]

    def __str__(self):
        return f"{self.name} ({self.entity_type})"


class Relationship(models.Model):

    source = models.ForeignKey(
        Entity,
        on_delete=models.CASCADE,
        related_name="outgoing_relationships",
    )

    target = models.ForeignKey(
        Entity,
        on_delete=models.CASCADE,
        related_name="incoming_relationships",
    )

    relation_type = models.CharField(
        max_length=100
    )

    description = models.TextField(
        blank=True
    )

    source_document = models.ForeignKey(
        Document,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="relationships",
    )

    source_chunk = models.ForeignKey(
        DocumentChunk,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="relationships",
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    class Meta:

        constraints = [
            models.UniqueConstraint(
                fields=[
                    "source",
                    "target",
                    "relation_type",
                ],
                name="unique_relationship",
            )
        ]

    def __str__(self):
        return (
            f"{self.source.name} "
            f"-[{self.relation_type}]-> "
            f"{self.target.name}"
        )