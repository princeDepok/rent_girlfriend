# booking/serializers.py
from rest_framework import serializers
from .models import Package, Booking, Review

class PackageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Package
        fields = ['id', 'companion', 'duration', 'price', 'extra_hour_price']

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = ['id', 'user', 'companion', 'package', 'start_time', 'end_time', 'is_ongoing', 'is_completed']

class ReviewSerializer(serializers.ModelSerializer):
    user = serializers.ReadOnlyField(source='booking.user.username')
    companion = serializers.ReadOnlyField(source='booking.companion.user.username')

    class Meta:
        model = Review
        fields = ['id', 'booking', 'rating', 'comment', 'created_at', 'user', 'companion']

    def validate(self, attrs):
        if attrs['booking'].is_completed == False:
            raise serializers.ValidationError("Cannot review before booking is completed.")
        return attrs
