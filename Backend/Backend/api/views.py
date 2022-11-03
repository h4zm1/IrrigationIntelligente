from pickletools import long1
from numpy import dtype
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializer import InputSerializerPOST
from .serializer import InputSerializerGET
from .serializer import UserSerializer
from .serializer import GuideSerializer
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from .models import Input
from .models import Guide
import urllib.request
import json



class InputView(APIView):
    def get(self, request):
        inputs = Input.objects.all()
        serializer = InputSerializerGET(inputs, many=True)
        return Response(serializer.data)

    def post(self, request):
        sum = 0
        serializer = InputSerializerPOST(data=request.data)
        if serializer.is_valid():
            input_saved = serializer.save()
            sum = input_saved.temperature + input_saved.humidity + input_saved.water
            return Response({"result":sum})
        else:
            return Response({"result":"error"})


    
class WeatherView(APIView):
    # ex url: http://localhost:8000/api/weather/?lon=10.454610&lat=34.725160
    def get(self, request):
        lon = request.GET.get('lon')
        lat = request.GET.get('lat')
        url = urllib.request.urlopen("https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&units=metric&appid=be5b997fa84e2eee06abbcfc4072f6dd").read()

        convertedData = json.loads(url)

        result = {
            'city': str(convertedData['name']),
            "country_code": str(convertedData['sys']['country']),
            "temp": str(convertedData['main']['temp']),
            "humidity": str(convertedData['main']['humidity']),
        }

        return Response(result)
class AccountView(APIView):

    def get(self,request):
        userName = request.GET.get('username')
        userPass = request.GET.get('password')
        userMail = request.GET.get('email')
        try:
            user = User.objects.create_user(username=userName,
                                         email=userMail,
                                         password=userPass)
            response = {"success": True}
            return Response(response)
        except Exception:
            response = {"success": False}
            return Response(response)


    def post(self,request):
        userPass = request.data.get("password")
        userName = request.data.get("username")
        
        user = authenticate(username=userName, password=userPass)
        if user is not None:
          response = {"login": True}
          return Response(response)
        else:
          response = {"login": False}
          return Response(response)


class GuideView(APIView):
    def get(self, request):
        guides = Guide.objects.all()
        serializer = GuideSerializer(guides, many=True)
        return Response(serializer.data)
