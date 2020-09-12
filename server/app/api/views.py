import base64
from rest_framework import status
from django.contrib.auth.models import User
from rest_framework.response import Response
from django.core.files.base import ContentFile
from django.utils.datetime_safe import datetime
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.decorators import api_view, permission_classes

from app.models import Item, Log
from app.api.serializers import ItemSerializers, SellItemSerializers, LogSerializers


@api_view(['GET', ])
def test(request):
    return Response({"response": "successful"})


@api_view(['GET', ])
@permission_classes((IsAuthenticated, ))
def show_all_items(request):
    # Collecting Data
    items = Item.objects.all().order_by('-date_modified')

    # Serialize and Response
    if items:
        serializer = ItemSerializers(items, many=True)
        data = serializer.data
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        data = {"response": "there is no item"}
        return Response(data=data, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST', ])
@permission_classes((IsAuthenticated, ))
def add_item(request):
    # Serialize data
    serializer = ItemSerializers(data=request.data)
    if serializer.is_valid():
        item = serializer.save()
        # If Name was null or empty
        if item.name is None or item.name == '':
            data = {"response": "name can't be null"}
            return Response(data=data, status=status.HTTP_406_NOT_ACCEPTABLE)
        # If number was null
        if item.number is None:
            item.number = 0
        item.save()
        # Save the Log
        log = Log.objects.create(
            text="{} {}: {} ثبت شد.".format(item.name, item.count_type, item.number),
            type="add",
            date=datetime.now()
        )
        log_response = log.save()
        print("log_response: {}".format(log_response))
        data = {
            "response": "success",
            "name": item.name,
            "number": item.number
        }
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        return Response(data=serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


@api_view(['PUT', ])
@permission_classes((IsAuthenticated, ))
def edit_item(request):
    # Serialize data
    serializer = ItemSerializers(data=request.data)
    try:
        # Check is old_name valid or not
        old_name = request.data.get("old_name")
        temp_old_item = Item.objects.filter(name=old_name)
        old_item = temp_old_item[0]
    except:
        data = {"response": "old_name does not exist"}
        return Response(data=data, status=status.HTTP_404_NOT_FOUND)

    # Save the serializer in item
    if serializer.is_valid():
        name = serializer.data.get("name")
        number = serializer.data.get("number")
        countType = serializer.data.get("count_type")

        # If name was not null and doesn't exist --> update it
        if name is not None:
            try:
                name_check = Item.objects.get(name=name)
            except:
            # if name_check is None:
                old_item.name = name
            else:
                data = {"response": "item with this name already exists."}
                return Response(data=data, status=status.HTTP_409_CONFLICT)

        # If Name was not null --> update it
        if number is not None:
            old_number = old_item.number
            old_item.number = number

        if countType is not None:
            old_count_type = old_item.count_type
            old_item.count_type = countType

        # Update Response, Should be Null
        response = old_item.save()
        # Save the Log
        if name is None:
            new_name = old_name
        else:
            new_name = name
        log = Log.objects.create(
            text="{}  {}: {} به {} {}: {} ویرایش شد.".format(old_name, old_count_type, old_number, new_name, old_item.count_type, number),
            type="edit",
            date=datetime.now()
        )
        log_response = log.save()
        print("log_response: {}".format(log_response))
        print("response: ", response)
        data = {
            "response": "success",
            "name": old_item.name,
            "number": old_item.number,
            "countType": old_item.count_type
        }
        return Response(data=data, status=status.HTTP_202_ACCEPTED)
    else:
        return Response(data=serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


@api_view(['DELETE', ])
@permission_classes((IsAuthenticated, ))
def delete_item(request, item_name):
    items = Item.objects.filter(name=item_name)

    # If we have two item with same name, delete the first one
    try:
        item = items[0]
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
    number = item.number
    count_type = item.count_type
    result = item.delete()
    if result:
        # Save the Log
        log = Log.objects.create(
            text="{} {}: {} حذف شد.".format(item_name, count_type, number),
            type="delete",
            date=datetime.now()
        )
        log_response = log.save()
        print("log_response: {}".format(log_response))
        data = {
            "response": "deleted successfully",
        }
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        return Response(data=result, status=status.HTTP_409_CONFLICT)


@api_view(['POST', ])
@permission_classes((IsAuthenticated, ))
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
            old_item = Item.objects.filter(name=name).update(number=new_number, date_modified=datetime.now())
        except:
            return Response(status=status.HTTP_409_CONFLICT)
        # Set Response
        if old_item:
            # Save the Log
            if item.count_type == 'تعداد':
                log_text = "{} {} عدد فروخته شد.".format(name, number)
            else:
                log_text = "{} {} {} فروخته شد.  موجودی: {}".format(name, number, item.count_type, new_number)
            log = Log.objects.create(
                text=log_text,
                type="sell",
                date=datetime.now()
            )
            log_response = log.save()
            print("log_response: {}".format(log_response))
            return Response(data={"response": "success"}, status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

    else:
        return Response(data=serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)


@api_view(['GET', ])
@permission_classes((IsAuthenticated, ))
def show_all_logs(request):
    # Collecting Data
    logs = Log.objects.all().order_by('-date')
    print(logs)
    # Serialize and Response
    if logs:
        serializer = LogSerializers(logs, many=True)
        data = serializer.data
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        data = {"response": "there is no item"}
        return Response(data=data, status=status.HTTP_404_NOT_FOUND)


