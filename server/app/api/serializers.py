
from rest_framework import serializers
from app.models import Item, Log


class ItemSerializers(serializers.ModelSerializer):
    class Meta:
        model   = Item
        fields  = ['name', 'number']


class SellItemSerializers(serializers.ModelSerializer):
    class Meta:
        model   = Item
        fields  = ['name', 'number']
        extra_kwargs = {
            'name': {
                'validators': [],
            }
        }

class LogSerializers(serializers.ModelSerializer):
    class Meta:
        model   = Log
        fields  = ['text', 'type', 'date']
