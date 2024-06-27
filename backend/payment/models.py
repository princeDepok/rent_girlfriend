# payments/models.py
from django.db import models
from django.conf import settings
# from bookings.models import Booking

class Payment(models.Model):
    # booking = models.ForeignKey(Booking, related_name='payments', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_date = models.DateTimeField(auto_now_add=True)
    is_successful = models.BooleanField(default=False)

    def __str__(self):
        return f'Payment for booking {self.booking.id} - {self.amount}'

class Transaction(models.Model):
    payment = models.ForeignKey(Payment, related_name='transactions', on_delete=models.CASCADE)
    transaction_id = models.CharField(max_length=100, unique=True)
    transaction_status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Transaction {self.transaction_id} - {self.transaction_status}'
