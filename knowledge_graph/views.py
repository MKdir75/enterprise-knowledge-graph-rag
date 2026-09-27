from django.shortcuts import get_object_or_404

from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Entity, Relationship
from .serializers import (
    EntitySerializer,
    RelationshipSerializer,
)
from .services.graph_service import (
    get_entity_neighborhood,
)


class EntityListCreateView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get_accessible_entities(self, request):

        if request.user.role == "ADMIN":
            return Entity.objects.all()

        entity_ids = (
            Relationship.objects
            .filter(
                source_document__is_active=True,
                source_document__department__iexact=(
                    request.user.department
                ),
            )
            .values_list(
                "source_id",
                "target_id",
            )
        )

        source_ids = (
            Relationship.objects
            .filter(
                source_document__is_active=True,
                source_document__department__iexact=(
                    request.user.department
                ),
            )
            .values_list(
                "source_id",
                flat=True,
            )
        )

        target_ids = (
            Relationship.objects
            .filter(
                source_document__is_active=True,
                source_document__department__iexact=(
                    request.user.department
                ),
            )
            .values_list(
                "target_id",
                flat=True,
            )
        )

        return Entity.objects.filter(
            id__in=source_ids
        ).union(
            Entity.objects.filter(
                id__in=target_ids
            )
        )

    def get(self, request):

        entities = self.get_accessible_entities(
            request
        )

        name = request.query_params.get(
            "name"
        )

        if name:
            entities = entities.filter(
                name__icontains=name
            )

        entity_type = request.query_params.get(
            "entity_type"
        )

        if entity_type:
            entities = entities.filter(
                entity_type=entity_type
            )

        serializer = EntitySerializer(
            entities,
            many=True,
        )

        return Response(
            serializer.data
        )

    def post(self, request):

        if request.user.role not in [
            "ADMIN",
            "ANALYST",
        ]:
            return Response(
                {
                    "detail": "Permission denied."
                },
                status=status.HTTP_403_FORBIDDEN,
            )

        serializer = EntitySerializer(
            data=request.data
        )

        serializer.is_valid(
            raise_exception=True
        )

        serializer.save()

        return Response(
            serializer.data,
            status=status.HTTP_201_CREATED,
        )


class EntityDetailView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get(self, request, entity_id):

        if request.user.role == "ADMIN":

            entity = get_object_or_404(
                Entity,
                id=entity_id,
            )

        else:

            entity = get_object_or_404(
                Entity,
                id=entity_id,
                outgoing_relationships__source_document__is_active=True,
                outgoing_relationships__source_document__department__iexact=(
                    request.user.department
                ),
            )

        return Response(
            EntitySerializer(entity).data
        )


class RelationshipListCreateView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get(self, request):

        if request.user.role == "ADMIN":

            relationships = (
                Relationship.objects
                .select_related(
                    "source",
                    "target",
                    "source_document",
                    "source_chunk",
                )
                .all()
            )

        else:

            relationships = (
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
                        request.user.department
                    ),
                )
            )

        serializer = RelationshipSerializer(
            relationships,
            many=True,
        )

        return Response(
            serializer.data
        )

    def post(self, request):

        if request.user.role not in [
            "ADMIN",
            "ANALYST",
        ]:
            return Response(
                {
                    "detail": "Permission denied."
                },
                status=status.HTTP_403_FORBIDDEN,
            )

        serializer = RelationshipSerializer(
            data=request.data
        )

        serializer.is_valid(
            raise_exception=True
        )

        serializer.save()

        return Response(
            serializer.data,
            status=status.HTTP_201_CREATED,
        )


class EntityNeighborhoodView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get(self, request, entity_id):

        try:
            depth = int(
                request.query_params.get(
                    "depth",
                    1,
                )
            )

        except ValueError:

            return Response(
                {
                    "detail": "depth must be an integer."
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        if depth < 1 or depth > 3:

            return Response(
                {
                    "detail": (
                        "depth must be between "
                        "1 and 3."
                    )
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        if request.user.role == "ADMIN":

            get_object_or_404(
                Entity,
                id=entity_id,
            )

        else:

            get_object_or_404(
                Entity,
                id=entity_id,
                outgoing_relationships__source_document__is_active=True,
                outgoing_relationships__source_document__department__iexact=(
                    request.user.department
                ),
            )

        graph = get_entity_neighborhood(
            entity_id,
            depth,
            request.user,
        )

        return Response(
            {
                "entities": EntitySerializer(
                    graph["entities"],
                    many=True,
                ).data,

                "relationships": RelationshipSerializer(
                    graph["relationships"],
                    many=True,
                ).data,
            }
        )