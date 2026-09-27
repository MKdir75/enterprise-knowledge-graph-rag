from django.contrib import admin

from .models import Entity, Relationship


@admin.register(Entity)
class EntityAdmin(admin.ModelAdmin):

    list_display = (
        "id",
        "name",
        "entity_type",
        "created_at",
    )

    list_filter = (
        "entity_type",
    )

    search_fields = (
        "name",
        "description",
    )


@admin.register(Relationship)
class RelationshipAdmin(admin.ModelAdmin):

    list_display = (
        "id",
        "source",
        "relation_type",
        "target",
        "source_document",
        "created_at",
    )

    list_filter = (
        "relation_type",
    )

    search_fields = (
        "source__name",
        "target__name",
        "relation_type",
    )