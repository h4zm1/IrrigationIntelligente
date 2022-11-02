from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Input
from .models import Guide


class InputSerializerPOST(serializers.Serializer):
       temperature = serializers.FloatField()
       humidity = serializers.FloatField()
       water = serializers.FloatField()
       def create(self, validated_data):
           return Input.objects.create(**validated_data)

class InputSerializerGET(serializers.Serializer):
       temperature = serializers.FloatField()
       humidity = serializers.FloatField()
       water = serializers.FloatField()
       created_at = serializers.DateTimeField()
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