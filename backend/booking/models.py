from django.db import models
from django.conf import settings
from companion.models import Companion

class Booking(models.Model):
    DURATION_CHOICES = [
        (3, '3 hours'),
        (6, '6 hours'),
        (12, '12 hours'),
    ]

    STATUS_CHOICES = [
        ('pending', 'Menunggu Pembayaran'),
        ('on_progress', 'Sedang Berjalan'),
        ('completed', 'Order Selesai')
    ]

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    companion = models.ForeignKey(Companion, on_delete=models.CASCADE)
    duration = models.IntegerField(choices=DURATION_CHOICES, null=True, blank=True)
    custom_duration = models.IntegerField(null=True, blank=True)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    payment_proof = models.ImageField(upload_to='payment_proofs/', null=True, blank=True)
    status = models.CharField(max_length=12, choices=STATUS_CHOICES, default='pending')

    def save(self, *args, **kwargs):
        if self.custom_duration:
            self.total_price = self.companion.price_per_hour * self.custom_duration
        else:
            self.total_price = self.companion.price_per_hour * self.duration
        super().save(*args, **kwargs)

    def __str__(self):
        return f'{self.user.username} - {self.companion.name} - {self.status}'
