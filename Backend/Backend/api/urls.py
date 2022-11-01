from django.urls import include, path
from .views import InputView, WeatherView,AccountView, GuideView


urlpatterns = [
    path("input/", InputView.as_view()),
    path("weather/", WeatherView.as_view()),
     path("account/", AccountView.as_view()),
     path("guide/", GuideView.as_view())
]
