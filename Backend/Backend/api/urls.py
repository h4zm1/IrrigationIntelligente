from django.urls import include, path
from rest_framework import routers
#from .views import InputViewSet
from .views import InputView

#router = routers.DefaultRouter()
#router.register(r'input', InputViewSet)

urlpatterns = [

    #path('', include(router.urls)),
        path('input/',InputView.as_view()),

]