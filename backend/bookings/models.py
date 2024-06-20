# booking/models.py
from django.db import models
from django.conf import settings
from users.models import Companion

class Package(models.Model):
    duration_choices = [
        (3, '3 hours'),
        (6, '6 hours'),
        (9, '9 hours'),
        (12, '12 hours'),
    ]
    companion = models.ForeignKey(Companion, related_name='packages', on_delete=models.CASCADE)
    duration = models.IntegerField(choices=duration_choices)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    extra_hour_price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f'{self.companion.user.username} - {self.duration} hours'

class Booking(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    companion = models.ForeignKey(Companion, on_delete=models.CASCADE)
    package = models.ForeignKey(Package, on_delete=models.CASCADE)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    is_ongoing = models.BooleanField(default=True)
    is_completed = models.BooleanField(default=False)

    def __str__(self):
        return f'{self.user.username} booked {self.companion.user.username}'

class Review(models.Model):
    booking = models.OneToOneField(Booking, on_delete=models.CASCADE)
    rating = models.IntegerField()
    comment = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Review for {self.booking.companion.user.username} by {self.booking.user.username}'
