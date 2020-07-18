from django.urls import path, include
from app.api.views import *

urlpatterns = [
    path('delete/<str:item_name>', delete_item),
    path('show-all/', show_all_items),
    path('edit/', edit_item),
    path('sell/', sell_item),
    path('add/', add_item),
]
