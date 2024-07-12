# Generated by Django 5.0.6 on 2024-07-12 02:23

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('companion', '0004_alter_companion_price_per_hour'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='companion',
            name='picture',
        ),
        migrations.CreateModel(
            name='CompanionPhoto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('photo', models.ImageField(upload_to='pictures/')),
                ('companion', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='photos', to='companion.companion')),
            ],
        ),
    ]