# chat/urls.py
from django.urls import path
from .views import ChatListView, MessageListView, MessageCreateView

urlpatterns = [
    path('chats/', ChatListView.as_view(), name='chat-list'),
    path('messages/<int:chat_id>/', MessageListView.as_view(), name='message-list'),
    path('messages/create/', MessageCreateView.as_view(), name='message-create'),
]
