# payments/serializers.py
from rest_framework import serializers
from .models import Payment, Transaction

class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = ['id', 'booking', 'amount', 'payment_date', 'is_successful']

class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = ['id', 'payment', 'transaction_id', 'transaction_status', 'created_at']
