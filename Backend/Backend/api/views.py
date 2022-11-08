from pickletools import long1
from numpy import dtype
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializer import InputSerializerPOST
from .serializer import InputSerializerGET
from .serializer import UserSerializer
from .serializer import GuideSerializer
from .serializer import MygardinSerializer
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from .models import Input
from .models import Guide
from .models import Mygardin
import urllib.request
import json
import cloudinary.uploader
import requests
import json
import urllib.request
import os


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
        data = {}
       
        if user is not None:
            # user is not serializable, so we manually created
          data['username'] = user.username
          data['id'] = user.id
          data['email'] = user.email
          data['login'] = 'true'
          response = data
          return Response(response)
        else:
          response = {"login": 'false'}
          return Response(response)


class GuideView(APIView):

    def get(self, request):
        guides = Guide.objects.all()
        serializer = GuideSerializer(guides, many=True)
        return Response(serializer.data)
    def post(self,request):
        serializer_data = {}
        # parameter key name for picture
        file = request.data.get('picture')
        userId = request.data.get("userId")

        # upload image to cloudinary
        upload_data = cloudinary.uploader.upload(file)
        API_KEY = os.environ['API_KEY']
        PROJECT = "all" # try specific floras: "weurope", "canada"…
        api_endpoint = f"https://my-api.plantnet.org/v2/identify/{PROJECT}?api-key={API_KEY}"

        data = {
        'organs': ['flower']
        }
        
        image_path = str(upload_data['secure_url'])
        image_data = urllib.request.urlopen(image_path)
        file = [('images', (image_path, image_data))]
       
        
        req = requests.Request('POST', url=api_endpoint, files=file)
        prepared = req.prepare()
        
        # plant recognition
        s = requests.Session()
        response = s.send(prepared)
        json_result = json.loads(response.text)
        print(json_result)
        #print(json_result['results'][0]['species']['commonNames'][0])
        plantName = ""
        try:
             # might fail if given plant name doesn't exist in guide table
            plantName = json_result['results'][0]['species']['commonNames'][0]
            plant = Guide.objects.get(plantName=plantName)
            serializer_data = {
                "plantName":plant.plantName, 
                "plantDisc":plant.plantDisc,
                "plantWaterUsage":plant.plantWaterUsage,
                "plantImageUrl":image_path,
                "userId":userId
            }
        except Exception as e:
            print("not found:",e)
            serializer_data = {
                "plantName":plantName,
                "plantDisc":"",
                "plantWaterUsage":"",
                "plantImageUrl":image_path,
                "userId":userId
            }
            if(str(e) == "list index out of range"):
                return Response({
                    'status':'not detected'
                })
            else:
                return Response({
                    'status':'not found',
                    'name':json_result['results'][0]['species']['commonNames'][0]
                })
       
        # create a plant in mygardin table
        serializer = MygardinSerializer(data=serializer_data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        else:
            print(serializer.errors)
            return Response({
                'status': 'error',
                'agrs':serializer.errors,
                'json_result':json_result,
            })

class GardinView(APIView):
    def get(self, request):
        gardin = Mygardin.objects.all()
        serializer = MygardinSerializer(gardin, many=True)
        return Response(serializer.data)
   