# chat/models.py
from django.db import models
from django.conf import settings
from users.models import Companion

class Chat(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='chats', on_delete=models.CASCADE)
    companion = models.ForeignKey(Companion, related_name='chats', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Chat between {self.user.username} and {self.companion.user.username}'

class Message(models.Model):
    chat = models.ForeignKey(Chat, related_name='messages', on_delete=models.CASCADE)
    sender = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    message = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Message from {self.sender.username} at {self.timestamp}'
