from django.conf import settings

from openai import OpenAI


class OpenAIService:

    def __init__(self):

        if not settings.OPENAI_API_KEY:
            raise ValueError(
                "OPENAI_API_KEY is not configured."
            )

        self.client = OpenAI(
            api_key=settings.OPENAI_API_KEY
        )

        self.model = settings.OPENAI_MODEL

    def generate_answer(
        self,
        question,
        context,
    ):

        prompt = f"""
You are an enterprise knowledge assistant.

Answer the user's question using ONLY the
provided enterprise context.

If the context does not contain enough
information, clearly say that the available
enterprise data is insufficient.

Do not invent facts.

USER QUESTION:
{question}

ENTERPRISE CONTEXT:
{context}
"""

        response = self.client.responses.create(
            model=self.model,
            input=prompt,
        )

        return response.output_text