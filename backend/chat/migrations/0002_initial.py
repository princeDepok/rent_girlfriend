# Generated by Django 4.2.2 on 2024-06-27 12:18

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('users', '0002_companion_customuser_birth_date_customuser_gender_and_more'),
        ('chat', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='chat',
            name='companion',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='chats', to='users.companion'),
        ),
        migrations.AddField(
            model_name='chat',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='chats', to=settings.AUTH_USER_MODEL),
        ),
    ]