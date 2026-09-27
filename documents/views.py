from django.shortcuts import get_object_or_404

from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Document
from .serializers import (
    DocumentSerializer,
    DocumentChunkSerializer,
)

from .services.ingestion import ingest_document


class DocumentListCreateView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get_queryset(self, request):

        user = request.user

        # ADMIN can access all active documents
        if user.role == "ADMIN":
            queryset = Document.objects.filter(
                is_active=True
            )

        # ANALYST and USER can access
        # only their own department documents
        else:
            queryset = Document.objects.filter(
                is_active=True,
                department__iexact=user.department
            )

        department = request.query_params.get(
            "department"
        )

        if department:
            queryset = queryset.filter(
                department__iexact=department
            )

        document_type = request.query_params.get(
            "document_type"
        )

        if document_type:
            queryset = queryset.filter(
                document_type=document_type
            )

        return queryset

    def get(self, request):

        queryset = self.get_queryset(request)

        serializer = DocumentSerializer(
            queryset,
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
                    "detail": (
                        "Only ADMIN or ANALYST "
                        "can create documents."
                    )
                },
                status=status.HTTP_403_FORBIDDEN,
            )

        serializer = DocumentSerializer(
            data=request.data
        )

        serializer.is_valid(
            raise_exception=True
        )

        # IMPORTANT:
        # Department is controlled by the
        # authenticated user's department.
        document = serializer.save(
            uploaded_by=request.user,
            department=request.user.department,
        )

        ingest_document(document)

        return Response(
            DocumentSerializer(document).data,
            status=status.HTTP_201_CREATED,
        )


class DocumentDetailView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get_document(self, request, document_id):

        user = request.user

        if user.role == "ADMIN":
            return get_object_or_404(
                Document,
                id=document_id,
                is_active=True,
            )

        return get_object_or_404(
            Document,
            id=document_id,
            is_active=True,
            department__iexact=user.department,
        )

    def get(self, request, document_id):

        document = self.get_document(
            request,
            document_id,
        )

        return Response(
            DocumentSerializer(document).data
        )

    def patch(self, request, document_id):

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

        document = self.get_document(
            request,
            document_id,
        )

        serializer = DocumentSerializer(
            document,
            data=request.data,
            partial=True,
        )

        serializer.is_valid(
            raise_exception=True
        )

        # Prevent ANALYST from changing
        # the document to another department.
        update_data = serializer.validated_data

        if request.user.role != "ADMIN":
            update_data["department"] = (
                request.user.department
            )

        document = serializer.save(
            **update_data
        )

        ingest_document(document)

        return Response(
            DocumentSerializer(document).data
        )

    def delete(self, request, document_id):

        if request.user.role != "ADMIN":
            return Response(
                {
                    "detail": (
                        "Only ADMIN can delete "
                        "documents."
                    )
                },
                status=status.HTTP_403_FORBIDDEN,
            )

        document = get_object_or_404(
            Document,
            id=document_id,
        )

        document.delete()

        return Response(
            status=status.HTTP_204_NO_CONTENT
        )


class DocumentChunkListView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get(self, request, document_id):

        user = request.user

        if user.role == "ADMIN":
            document = get_object_or_404(
                Document,
                id=document_id,
            )
        else:
            document = get_object_or_404(
                Document,
                id=document_id,
                department__iexact=user.department,
            )

        chunks = document.chunks.all()

        serializer = DocumentChunkSerializer(
            chunks,
            many=True,
        )

        return Response(
            serializer.data
        ) 