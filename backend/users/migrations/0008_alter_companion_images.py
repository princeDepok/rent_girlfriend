# Generated by Django 4.2.2 on 2024-06-27 17:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0007_remove_companion_services_offered_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='companion',
            name='images',
            field=models.ImageField(blank=True, null=True, upload_to='companion_images/'),
        ),
    ]