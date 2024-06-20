# booking/urls.py
from django.urls import path
from .views import PackageListView, BookingCreateView, BookingListView, BookingDetailView, ReviewCreateView

urlpatterns = [
    path('packages/', PackageListView.as_view(), name='package-list'),
    path('book/', BookingCreateView.as_view(), name='booking-create'),
    path('bookings/', BookingListView.as_view(), name='booking-list'),
    path('booking/<int:pk>/', BookingDetailView.as_view(), name='booking-detail'),
    path('review/<int:booking_id>/', ReviewCreateView.as_view(), name='review-create'),
]
