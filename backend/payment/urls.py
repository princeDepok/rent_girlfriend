# payments/urls.py
from django.urls import path
from .views import PaymentCreateView, PaymentListView, TransactionCreateView, TransactionListView

urlpatterns = [
    path('create/', PaymentCreateView.as_view(), name='payment-create'),
    path('list/', PaymentListView.as_view(), name='payment-list'),
    path('transaction/create/', TransactionCreateView.as_view(), name='transaction-create'),
    path('transaction/list/', TransactionListView.as_view(), name='transaction-list'),
]
