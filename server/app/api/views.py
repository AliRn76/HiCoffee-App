import base64
from rest_framework import status
from django.contrib.auth.models import User
from rest_framework.response import Response
from django.core.files.base import ContentFile
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.decorators import api_view, permission_classes

from app.models import Item
from app.api.serializers import ItemSerializers


@api_view(['GET', ])
def test(request):
    return Response({"response":"successful"})


@api_view(['GET', ])
@permission_classes((AllowAny,))
def show_all_items(request):
    data = {}
    # Collecting Data
    items = Item.objects.all()

    # Serialize and Response
    if items:
        serializer = ItemSerializers(items, many=True)
        data = serializer.data
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        data = {"response": "there is no item"}
        return Response(data=data, status=status.HTTP_404_NOT_FOUND)

