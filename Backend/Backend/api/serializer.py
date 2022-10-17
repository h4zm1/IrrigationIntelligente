from rest_framework import serializers

from .models import Input


class InputSerializer(serializers.Serializer):
       temperature = serializers.FloatField()
       humidity = serializers.FloatField()


       def create(self, validated_data):
           return Input.objects.create(**validated_data)