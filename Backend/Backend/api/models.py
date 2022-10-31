from unittest.util import _MAX_LENGTH
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend

class Input(models.Model):
    temperature = models.FloatField(max_length=50)
    humidity = models.FloatField(max_length=50)
    water = models.FloatField(max_length=50)
    def __int__(self):
        return self.id

class EmailBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        UserModel = get_user_model()
        try:
            user = UserModel.objects.get(email=username)
        except UserModel.DoesNotExist:
            return None
        else:
            if user.check_password(password):
                return user
        return None

# when adding new field
# run python manage.py migrate --run-syncdb