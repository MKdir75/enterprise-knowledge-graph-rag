from django.conf import settings
from django.db import models


class Document(models.Model):

    class DocumentType(models.TextChoices):
        POLICY = "POLICY", "Policy"
        CONTRACT = "CONTRACT", "Contract"
        REPORT = "REPORT", "Report"
        MANUAL = "MANUAL", "Manual"
        OTHER = "OTHER", "Other"

    title = models.CharField(
        max_length=255
    )

    description = models.TextField(
        blank=True
    )

    document_type = models.CharField(
        max_length=30,
        choices=DocumentType.choices,
        default=DocumentType.OTHER,
    )

    content = models.TextField()

    department = models.CharField(
        max_length=100,
        blank=True,
    )

    uploaded_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="documents",
    )

    is_active = models.BooleanField(
        default=True
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    updated_at = models.DateTimeField(
        auto_now=True
    )

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return self.title


class DocumentChunk(models.Model):

    document = models.ForeignKey(
        Document,
        on_delete=models.CASCADE,
        related_name="chunks",
    )

    chunk_index = models.PositiveIntegerField()

    content = models.TextField()

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    class Meta:
        ordering = ["chunk_index"]

        constraints = [
            models.UniqueConstraint(
                fields=[
                    "document",
                    "chunk_index",
                ],
                name="unique_document_chunk",
            )
        ]

    def __str__(self):
        return (
            f"{self.document.title} "
            f"- chunk {self.chunk_index}"
        )