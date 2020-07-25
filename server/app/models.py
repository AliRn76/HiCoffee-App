from rest_framework.authtoken.models import Token
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.conf import settings
from django.db import models


class Item(models.Model):
    id      = models.AutoField(db_column='ID', primary_key=True)
    name    = models.CharField(db_column='Name', max_length=96, unique=True, null=True)
    number = models.IntegerField(db_column='Number', null=True)
    class Meta:
        db_table = 'Item'

    def __str__(self):
        return str(self.name) + " " + str(self.number)


class Log(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)
    text = models.TextField(db_column='Text', blank=True, null=True)
    type = models.CharField(db_column='Type', max_length=96, blank=True, null=True)

    class Meta:
        db_table = 'Log'

    def __str__(self):
        return str(self.type) + " " + self.text

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

