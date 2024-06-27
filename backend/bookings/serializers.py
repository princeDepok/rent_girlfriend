# booking/serializers.py
from rest_framework import serializers
from .models import Package, Booking, Review, Service

class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = ['id', 'name', 'description']

class PackageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Package
        fields = ['id', 'companion', 'duration', 'price', 'extra_hour_price']

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = ['id', 'user', 'companion', 'package', 'service', 'start_time', 'end_time', 'location', 'is_ongoing', 'is_completed']

class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = ['id', 'booking', 'rating', 'comment', 'created_at']
