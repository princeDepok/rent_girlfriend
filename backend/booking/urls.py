from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import BookingViewSet, UserBookingHistoryView

router = DefaultRouter()
router.register(r'bookings', BookingViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('bookings/history/', UserBookingHistoryView.as_view(), name='user-booking-history'),
]
