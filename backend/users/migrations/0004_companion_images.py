# Generated by Django 4.2.2 on 2024-06-27 13:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0003_remove_companion_hourly_rate'),
    ]

    operations = [
        migrations.AddField(
            model_name='companion',
            name='images',
            field=models.ImageField(blank=True, null=True, upload_to='companion_images/'),
        ),
    ]
