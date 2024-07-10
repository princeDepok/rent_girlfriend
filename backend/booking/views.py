from rest_framework import viewsets, generics
from .models import Booking
from .serializers import BookingSerializer
from rest_framework.permissions import IsAuthenticated, IsAdminUser

class BookingViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()

    def get_serializer_class(self):
        return BookingSerializer

    # def get_permissions(self):
    #     if self.action in ['create', 'update', 'partial_update', 'destroy']:
    #         self.permission_classes = [IsAuthenticated,]
    #     elif self.action in ['list', 'retrieve']:
    #         self.permission_classes = [IsAuthenticated, IsAdminUser]
    #     return super(self.__class__, self).get_permissions()

class UserBookingHistoryView(generics.ListAPIView):
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Booking.objects.filter(user=user)