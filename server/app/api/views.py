import base64
from rest_framework import status
from django.contrib.auth.models import User
from rest_framework.response import Response
from django.core.files.base import ContentFile
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.decorators import api_view, permission_classes

from app.models import Item
from app.api.serializers import ItemSerializers, SellItemSerializers


@api_view(['GET', ])
def test(request):
    return Response({"response": "successful"})


@api_view(['GET', ])
@permission_classes((AllowAny,))
def show_all_items(request):
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


@api_view(['POST', ])
def add_item(request):
    # Serialize data
    serializer = ItemSerializers(data=request.data)
    if serializer.is_valid():
        item = serializer.save()
        # If Name was null or empty
        if item.name is None or item.name == '':
            data = {
                "response": "name can't be null"
            }
            return Response(data=data, status=status.HTTP_406_NOT_ACCEPTABLE)
        # If number was null
        if item.number is None:
            item.number = 0
        item.save()
        data = {
            "response": "success",
            "name": item.name,
            "number": item.number
        }
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        return Response(data=serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


@api_view(['PUT', ])
def edit_item(request):
    # Serialize data
    serializer = ItemSerializers(data=request.data)
    old_name = request.data.get("old_name")

    try:
        # Check is old_name valid or not
        temp_old_item = Item.objects.filter(name=old_name)
        old_item = temp_old_item[0]

    except Item.DoesNotExist:
        data = {
            "response": "old_name does not exist",
        }
        return Response(data=data, status=status.HTTP_404_NOT_FOUND)

    # Save the serializer in item
    if serializer.is_valid():
        item = serializer.save()

        # If name was not null and doesn't exist --> update it
        if item.name is not None:
            name_check = Item.objects.get(name=item.name)
            if name_check is None:
                old_item.name = item.name
            else:
                data = {
                    "response": "item with this name already exists.",
                }
                return Response(data=data, status=status.HTTP_409_CONFLICT)

        # If Name was not null --> update it
        if item.number is not None:
            old_item.number = item.number

        # Update Response, Should be Null
        response = old_item.save()
        print("response: ", response)
        data = {
            "response": "success",
            "name": old_item.name,
            "number": old_item.number
        }
        return Response(data=data, status=status.HTTP_202_ACCEPTED)
    else:
        return Response(data=serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


@api_view(['DELETE', ])
def delete_item(request, item_name):
    items = Item.objects.filter(name=item_name)

    # If we have two item with same name, delete the first one
    try:
        item = items[0]
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)

    result = item.delete()
    if result:
        data = {
            "response": "deleted successfully",
        }
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        return Response(data=result, status=status.HTTP_409_CONFLICT)


@api_view(['POST', ])
def sell_item(request):
    # Collecting Data
    serializer = SellItemSerializers(data=request.data)
    if serializer.is_valid():
        name = serializer.data.get("name")
        number = serializer.data.get("number")

        try:
            # If we had multiple item, sell the first one
            temp = Item.objects.filter(name=name)
            item = temp[0]
        except:
            return Response(status=status.HTTP_404_NOT_FOUND)
        try:
            # Check Is Number Positive
            new_number = item.number - number
            print("sell nubmer: " + str(item.number))
            print("new nubmer: " + str(new_number))
            if new_number < 0:
                print("error, you cant sell that much")
                return Response(data={"response": "you can not sell that much"}, status=status.HTTP_406_NOT_ACCEPTABLE)

            # Update number of item
            old_item = Item.objects.filter(name=name).update(number=new_number)
        except:
            return Response(status=status.HTTP_409_CONFLICT)
        # Set Response
        if old_item:
            return Response(data={"response": "success"}, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    else:
        return Response(data=serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)
