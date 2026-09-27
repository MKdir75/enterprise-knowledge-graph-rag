from rest_framework import serializers


class QuestionSerializer(serializers.Serializer):

    question = serializers.CharField(
        min_length=3,
        max_length=2000,
    )