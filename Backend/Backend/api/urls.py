from django.urls import include, path
from .views import InputView, WeatherView


urlpatterns = [
    path("input/", InputView.as_view()),
    path("weather/", WeatherView.as_view()),
]
