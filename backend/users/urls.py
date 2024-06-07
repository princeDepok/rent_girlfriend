# users/urls.py
from django.urls import path
from .views import LogoutView, RegisterView, LoginView, ResetPasswordView, ConfirmResetPasswordView, UserListView
urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('reset-password/', ResetPasswordView.as_view(), name='reset-password'),
    path('confirm-reset-password/', ConfirmResetPasswordView.as_view(), name='confirm-reset-password'),
    # path('test-email/', test_email, name='test-email'),
    path('list/', UserListView.as_view(), name='user-list'),
    path('logout/', LogoutView.as_view(), name='logout'),
]
