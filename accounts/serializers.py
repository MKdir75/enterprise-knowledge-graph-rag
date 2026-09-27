from django.contrib.auth import authenticate
from rest_framework import serializers

from .models import User


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            "username",
            "email",
            "password",
            "first_name",
            "last_name",
            "department",
            "role",
        ]
        extra_kwargs = {
            "password": {"write_only": True},
            "role": {"required": False},
        }

    def create(self, validated_data):
        password = validated_data.pop("password")

        role = validated_data.pop("role", "USER")

        user = User.objects.create_user(
            password=password,
            role=role,
            **validated_data
        )

        return user

class LoginSerializer(serializers.Serializer):

    username = serializers.CharField()

    password = serializers.CharField(
        write_only=True
    )

    def validate(self, attrs):

        username = attrs.get("username")
        password = attrs.get("password")

        user = authenticate(
            username=username,
            password=password,
        )

        if not user:
            raise serializers.ValidationError(
                "Invalid username or password."
            )

        if not user.is_active:
            raise serializers.ValidationError(
                "User account is inactive."
            )

        attrs["user"] = user

        return attrs


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User

        fields = [
            "id",
            "username",
            "email",
            "first_name",
            "last_name",
            "department",
            "role",
            "is_active",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "role",
            "is_active",
            "created_at",
        ]


class AdminUserUpdateSerializer(serializers.ModelSerializer):

    class Meta:
        model = User

        fields = [
            "username",
            "email",
            "first_name",
            "last_name",
            "department",
            "role",
            "is_active",
        ]