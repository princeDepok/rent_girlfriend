# users/models.py
from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db import models

class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=15, null=True, blank=True)
    gender = models.CharField(max_length=10, choices=[('Laki-laki', 'Laki-laki'), ('Wanita', 'Wanita')], null=True, blank=True)
    birth_place = models.CharField(max_length=255, null=True, blank=True)
    birth_date = models.DateField(null=True, blank=True)
    picture = models.ImageField(null=True, blank=True, upload_to='user_images/')
    is_companion = models.BooleanField(default=False)    

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username'] 
    
    def __str__(self):
        return self.email

class Companion(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE, related_name='companion_profile')
    bio = models.TextField(null=True, blank=True)
    hobby = models.CharField(null=True, blank=True, max_length=255)
    hourly_rate = models.IntegerField()
    available = models.BooleanField(default=True)
    location = models.CharField(max_length=255, null=True, blank=True)
    is_approved = models.BooleanField(default=False)

    def __str__(self):
        return f'{self.user.username} - Companion'
    
class CompanionGallery(models.Model):
    companion = models.ForeignKey(Companion, related_name='galleries', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='companion_images/')
    
    def __str__(self):
        return f'{self.companion.user.username} - Gallery'
