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
import joblib  
import numpy as np
import pickle
import math;
class InputView(APIView):
    valHolder2 =[]
    def get(self, request):
        inputs = Input.objects.all()
        serializer = InputSerializerGET(inputs, many=True)
        return Response(serializer.data)
    def getWaterLeft(self, valTemp, valHumidity, valWater, c):
        counter = c;
        if counter == 5 :
            return False
        counter= counter+1
        print("~~~~~~~~~~~##############")
        inc = np.array([[valTemp,0.1]]) #temp,precipitation
        inc2 = np.array([[valHumidity,0.1]])
        modelHum = joblib.load("model_humidity.pkl")
        modelTem = joblib.load("model_temperature.pkl")
 
        predictHum = modelHum.predict(inc).tolist()
        predictTem = modelTem.predict(inc2).tolist()
        print("temp ",predictTem[0])
        print("hum ",predictHum[0])

        #Antoine formula for Vapor pressure (based on temperature, and only for water under 100c)
        #Vapor pressure of water in kPa so had to multiply by 0.133322
        vpw = 0.133322* math.pow(10,8.07131-(1730.63/(233.426+predictTem[0])))
        # vapor pressure in the air, 0.5 value of calibration, related to the used dataset
        vpa = (vpw * predictHum[0]/100)-0.5
        print("Vapor pressure of water",vpw)
        print("vapor pressure in the air ",vpa)
        # assuming that the air is almost stationary (v = 0.1m/s)      
        v = 0.1
        #  latent heat required to change water to vapor at surface water temperature, kJ/kg
        Y = 2272
        #valF = float(valFormated)
        #evaporation rate in kg/m^2/s
        evaporationRate=(vpw - vpa)*(0.089 + 0.0782*v)/Y
        print("result ",'{:f}'.format(evaporationRate)) ### 0.000031
        #print("predictHum ",predictHum)
        #using area of half a meter 0.0625m^2
        valRateInArea = (evaporationRate*0.0625)*1000 # x1000 to convert to grams, it was in kg
        #incoming water value in liter and we need it in milliliter hence x1000
        resultInHours = ((valWater*1000 )/valRateInArea)/3600 
        resultInDays = resultInHours/24
        print("valRateInArea ",'{:11.8F}'.format(valRateInArea))
        print("hours ",resultInHours)
        print("days ",resultInDays)
        waterLeftAfterAday =  (valWater*1000 )  - (valRateInArea * 86400)
        waterLeftRounded = float("{:.2f}".format(waterLeftAfterAday/1000))
        print("water left tomorrow ",waterLeftRounded)
        self.valHolder2.append(waterLeftRounded)
        #call this meth again
        self.getWaterLeft(predictTem[0], predictHum[0],waterLeftAfterAday/1000,counter)

    def post(self, request):
        sum = 0
        serializer = InputSerializerPOST(data=request.data)
        if serializer.is_valid():
            input_saved = serializer.save()
            sum = input_saved.temperature + input_saved.humidity + input_saved.water
            self.valHolder2.clear()
            self.getWaterLeft(input_saved.temperature,input_saved.humidity,input_saved.water,0)

            return Response({"result":self.valHolder2})
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
        userMail = request.data.get("username")
        
        user = authenticate(username=userMail, password=userPass)
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
        garden = Mygardin.objects.filter(userId=userId,plantName=plantName).first()
        print(garden)
        serializer = MygardinSerializer(data=serializer_data)
        if(garden != None):# db exist
           print(garden)
           serializer_data = {
                "plantName":garden.plantName, 
                "plantDisc":garden.plantDisc,
                "plantWaterUsage":garden.plantWaterUsage,
                "plantImageUrl":garden.plantImageUrl + "," + image_path,
                "userId":userId
            }
           serializer2 = MygardinSerializer(garden, data=serializer_data)
           if serializer2.is_valid():
               serializer2.save()
               return Response(serializer2.data)


        # create a plant in mygardin table
        elif serializer.is_valid():
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
        user_id = request.GET.get("userId")

        gardin = Mygardin.objects.filter(userId=user_id)
        serializer = MygardinSerializer(gardin, many=True)
        return Response(serializer.data)

        
   