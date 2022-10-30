from unittest.util import _MAX_LENGTH
from django.db import models


class Input(models.Model):
    temperature = models.FloatField(max_length=50)
    humidity = models.FloatField(max_length=50)
    water = models.FloatField(max_length=50)
    def __int__(self):
        return self.id


# when adding new field