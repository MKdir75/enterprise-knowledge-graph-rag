from django.urls import path

from .views import (
    EntityListCreateView,
    EntityDetailView,
    RelationshipListCreateView,
    EntityNeighborhoodView,
)


urlpatterns = [

    path(
        "entities/",
        EntityListCreateView.as_view(),
        name="entity-list-create",
    ),

    path(
        "entities/<int:entity_id>/",
        EntityDetailView.as_view(),
        name="entity-detail",
    ),

    path(
        "entities/<int:entity_id>/neighborhood/",
        EntityNeighborhoodView.as_view(),
        name="entity-neighborhood",
    ),

    path(
        "relationships/",
        RelationshipListCreateView.as_view(),
        name="relationship-list-create",
    ),
]