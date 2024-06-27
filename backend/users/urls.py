from django.urls import path
from .views import (
    ApproveCompanionView, CompanionCreateView, CompanionListView, LogoutView, RegisterView, LoginView, ResetPasswordView, 
    ValidateOTPView, SetNewPasswordView, UserListView, UserDetailView, RefreshTokenView, CheckApprovalStatusView
)

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('reset-password/', ResetPasswordView.as_view(), name='reset-password'),
    path('validate-otp/', ValidateOTPView.as_view(), name='validate-otp'),
    path('set-new-password/', SetNewPasswordView.as_view(), name='set-new-password'),
    path('list/', UserListView.as_view(), name='user-list'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('user/<int:pk>/', UserDetailView.as_view(), name='user-detail'), 
    path('companion/approve/<int:pk>/', ApproveCompanionView.as_view(), name='companion-approve'),
    path('companion/register/', CompanionCreateView.as_view(), name='companion-register'),
    path('companions/', CompanionListView.as_view(), name='companions-list'),
    path('refresh-token/', RefreshTokenView.as_view(), name='refresh-token'),
    path('companion/check-approval/', CheckApprovalStatusView.as_view(), name='check-approval-status'),
]
