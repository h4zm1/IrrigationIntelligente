from django.urls import include, path
from .views import InputView


urlpatterns = [
    path("input/", InputView.as_view()),
]
