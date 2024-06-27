# Generated by Django 4.2.2 on 2024-06-27 17:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bookings', '0002_initial'),
        ('users', '0005_alter_companion_bank_account_alter_companion_bio_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='companion',
            name='services_offered',
        ),
        migrations.AddField(
            model_name='companion',
            name='services_offered',
            field=models.ManyToManyField(related_name='companions', to='bookings.service'),
        ),
    ]
