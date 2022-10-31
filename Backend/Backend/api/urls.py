from django.urls import include, path
from .views import InputView, WeatherView,AccountView


urlpatterns = [
    path("input/", InputView.as_view()),
    path("weather/", WeatherView.as_view()),
     path("account/", AccountView.as_view()),
]
