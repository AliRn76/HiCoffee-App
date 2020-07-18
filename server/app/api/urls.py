from django.urls import path, include
from app.api.views import test, show_all_items

urlpatterns = [
    path('test/', test),
    path('show-all/', show_all_items),
]
