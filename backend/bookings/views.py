# booking/views.py
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Package, Booking, Review, Service
from .serializers import PackageSerializer, BookingSerializer, ReviewSerializer, ServiceSerializer

class PackageListView(generics.ListAPIView):
    queryset = Package.objects.all()
    serializer_class = PackageSerializer
    permission_classes = [IsAuthenticated]

class BookingCreateView(generics.CreateAPIView):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    # permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        user = self.request.user
        service_id = self.request.data.get('service')
        service = Service.objects.get(id=service_id)
        location = self.request.data.get('location')

        if service.name in ['dating', 'hangout', 'kondangan'] and not location:
            raise serializers.ValidationError('Location is required for this service.')

        serializer.save(user=user)

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

class ServiceListView(generics.ListAPIView):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    permission_classes = [IsAuthenticated]
