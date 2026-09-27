from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from rest_framework_simplejwt.tokens import RefreshToken

from .models import User
from .permissions import IsAdmin
from .serializers import (
    RegisterSerializer,
    LoginSerializer,
    UserSerializer,
    AdminUserUpdateSerializer,
)


class RegisterView(APIView):

    permission_classes = []

    def post(self, request):

        serializer = RegisterSerializer(
            data=request.data
        )

        serializer.is_valid(raise_exception=True)

        user = serializer.save()

        return Response(
            {
                "message": "User registered successfully.",
                "user": UserSerializer(user).data,
            },
            status=status.HTTP_201_CREATED,
        )


class LoginView(APIView):

    permission_classes = []

    def post(self, request):

        serializer = LoginSerializer(
            data=request.data
        )

        serializer.is_valid(raise_exception=True)

        user = serializer.validated_data["user"]

        refresh = RefreshToken.for_user(user)

        return Response(
            {
                "access": str(refresh.access_token),
                "refresh": str(refresh),
                "user": UserSerializer(user).data,
            },
            status=status.HTTP_200_OK,
        )


class MeView(APIView):

    permission_classes = [
        IsAuthenticated
    ]

    def get(self, request):

        return Response(
            UserSerializer(request.user).data
        )


class UserListView(APIView):

    permission_classes = [
        IsAdmin
    ]

    def get(self, request):

        users = User.objects.all().order_by("-created_at")

        serializer = UserSerializer(
            users,
            many=True,
        )

        return Response(serializer.data)


class UserDetailView(APIView):

    permission_classes = [
        IsAdmin
    ]

    def get(self, request, user_id):

        user = User.objects.get(id=user_id)

        return Response(
            UserSerializer(user).data
        )

    def patch(self, request, user_id):

        user = User.objects.get(id=user_id)

        serializer = AdminUserUpdateSerializer(
            user,
            data=request.data,
            partial=True,
        )

        serializer.is_valid(raise_exception=True)

        serializer.save()

        return Response(
            serializer.data
        )

    def delete(self, request, user_id):

        user = User.objects.get(id=user_id)

        user.delete()

        return Response(
            {
                "message": "User deleted successfully."
            },
            status=status.HTTP_204_NO_CONTENT,
        )