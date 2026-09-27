from django.urls import path

from .views import (
    DocumentListCreateView,
    DocumentDetailView,
    DocumentChunkListView,
)


urlpatterns = [

    path(
        "",
        DocumentListCreateView.as_view(),
        name="document-list-create",
    ),

    path(
        "<int:document_id>/",
        DocumentDetailView.as_view(),
        name="document-detail",
    ),

    path(
        "<int:document_id>/chunks/",
        DocumentChunkListView.as_view(),
        name="document-chunks",
    ),
]