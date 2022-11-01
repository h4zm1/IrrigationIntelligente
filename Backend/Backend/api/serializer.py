from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Input
from .models import Guide


class InputSerializer(serializers.Serializer):
       temperature = serializers.FloatField()
       humidity = serializers.FloatField()
       water = serializers.FloatField()

       def create(self, validated_data):
           return Input.objects.create(**validated_data)

class GuideSerializer(serializers.Serializer):
       plantName = serializers.CharField()
       plantDisc = serializers.CharField()
       plantWaterUsage = serializers.FloatField()
       plantImageUrl = serializers.CharField()

       def create(self, validated_data):
           return Guide.objects.create(**validated_data)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'email', 'password')