# models.py
from django.db import models

class Companion(models.Model):
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other'),
    ]

    name = models.CharField(max_length=255)
    birth_date = models.DateField()
    age = models.IntegerField()
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, blank=True, null=True)
    id_card = models.CharField(max_length=100)
    bio = models.TextField()
    profile_picture = models.ImageField(upload_to='profile_pictures/')
    rating = models.DecimalField(max_digits=3, decimal_places=2)
    price_per_hour = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.name

class CompanionPhoto(models.Model):
    companion = models.ForeignKey(Companion, related_name='photos', on_delete=models.CASCADE)
    photo = models.ImageField(upload_to='pictures/')

    def __str__(self):
        return f"Photo for {self.companion.name}"
