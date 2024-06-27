from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models import JSONField

class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    gender = models.CharField(max_length=10, choices=[('Laki-laki', 'Laki-laki'), ('Wanita', 'Wanita')], null=True, blank=True)
    birth_date = models.DateField(null=True, blank=True)
    # picture = models.ImageField(null=True, blank=True, upload_to='user_images/')  # Comment out image field
    is_companion = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.email

class Companion(models.Model):
    BANK_CHOICES = [
        ('BCA', 'BCA'),
        ('Mandiri', 'Mandiri'),
        ('BRI', 'BRI'),
        ('Mega', 'Mega'),
        ('BSI', 'BSI'),
        ('CIMB', 'CIMB')
    ]

    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE, related_name='companion_profile')
    fullname = models.CharField(max_length=255)
    id_card = models.CharField(max_length=50)
    phone_number = models.CharField(max_length=20)
    bank_account = models.CharField(max_length=50, choices=BANK_CHOICES)
    bank_account_number = models.CharField(max_length=50)
    bio = models.TextField()
    tags = models.CharField(max_length=255)
    experience = models.TextField()
    services_offered = JSONField()
    instagram_account = models.CharField(max_length=255)
    # images = models.ImageField(upload_to='companion_images/', null=True, blank=True)  # Comment out image field
    available = models.BooleanField(default=True)
    location = models.CharField(max_length=255)
    is_approved = models.BooleanField(default=False)

    def __str__(self):
        return f'{self.user.username} - Companion'

class CompanionGallery(models.Model):
    companion = models.ForeignKey(Companion, related_name='galleries', on_delete=models.CASCADE)
    # image = models.ImageField(upload_to='companion_images/')  # Comment out image field

    def __str__(self):
        return f'{self.companion.user.username} - Gallery'
