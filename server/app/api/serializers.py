
from rest_framework import serializers
from app.models import Item


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
