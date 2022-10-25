from pickletools import long1
from numpy import dtype
from regex import D
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializer import InputSerializer
from .models import Input
import urllib.request
import json


class InputView(APIView):
    def get(self, request):
        inputs = Input.objects.all()
        serializer = InputSerializer(inputs, many=True)
        return Response({"inputs": serializer.data})

    def post(self, request):
        input = request.data.get("input")

        # create an input from above data
        serializer = InputSerializer(data=input)
        if serializer.is_valid(raise_exception=True):
            input_saved = serializer.save()
        return Response(
            {
                "success": "input with temp '{}' created successfully".format(
                    input_saved.temperature
                )
            }
        )


class WeatherView(APIView):
    def get(self, request):
        lon = request.GET.get('lon')
        lat = request.GET.get('lat')
        url = urllib.request.urlopen(
            "https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&units=metric&appid=be5b997fa84e2eee06abbcfc4072f6dd").read()

        convertedData = json.loads(url)

        result = {
            'city': str(convertedData['name']),
            "country_code": str(convertedData['sys']['country']),
            "temp": str(convertedData['main']['temp']),
            "humidity": str(convertedData['main']['humidity']),
        }

        return Response(result)
