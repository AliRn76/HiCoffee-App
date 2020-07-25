from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token

from app.api.views import *

urlpatterns = [
    path('delete/<str:item_name>', delete_item),
    path('login/', obtain_auth_token),
    path('show-all/', show_all_items),
    path('show-logs/', show_all_logs),
    path('edit/', edit_item),
    path('sell/', sell_item),
    path('add/', add_item),
]
