# Generated by Django 4.2.2 on 2024-06-21 03:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0008_companion_is_approved'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='picture',
            field=models.ImageField(blank=True, null=True, upload_to='user_images/'),
        ),
    ]