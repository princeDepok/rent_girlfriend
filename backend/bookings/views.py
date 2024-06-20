# booking/views.py
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Package, Booking, Review
from .serializers import PackageSerializer, BookingSerializer, ReviewSerializer

class PackageListView(generics.ListAPIView):
    queryset = Package.objects.all()
    serializer_class = PackageSerializer
    permission_classes = [IsAuthenticated]

class BookingCreateView(generics.CreateAPIView):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class BookingListView(generics.ListAPIView):
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Booking.objects.filter(user=user)

class BookingDetailView(generics.RetrieveAPIView):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]

class ReviewCreateView(generics.CreateAPIView):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        booking_id = self.kwargs.get('booking_id')
        booking = Booking.objects.get(id=booking_id)
        if booking.user != self.request.user:
            raise serializers.ValidationError("You can only review your own bookings.")
        serializer.save(booking=booking)
