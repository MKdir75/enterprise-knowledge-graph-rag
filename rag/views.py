from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import QuestionSerializer
from .services.rag_service import answer_question


class AskRAGView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def post(self, request):

        serializer = QuestionSerializer(
            data=request.data
        )

        serializer.is_valid(
            raise_exception=True
        )

        question = serializer.validated_data[
            "question"
        ]

        try:

            result = answer_question(
                question,
                request.user,
            )

            return Response(
                result,
                status=status.HTTP_200_OK,
            )

        except ValueError as exc:

            return Response(
                {
                    "detail": str(exc)
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        except Exception:

            return Response(
                {
                    "detail": (
                        "An error occurred while "
                        "processing the RAG request."
                    )
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )