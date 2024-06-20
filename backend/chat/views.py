# chat/views.py
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Chat, Message
from .serializers import ChatSerializer, MessageSerializer

class ChatListView(generics.ListAPIView):
    serializer_class = ChatSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Chat.objects.filter(user=user) | Chat.objects.filter(companion__user=user)

class MessageListView(generics.ListAPIView):
    serializer_class = MessageSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        chat_id = self.kwargs['chat_id']
        return Message.objects.filter(chat_id=chat_id)

class MessageCreateView(generics.CreateAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        chat_id = self.request.data.get('chat')
        chat = Chat.objects.get(id=chat_id)
        if self.request.user not in [chat.user, chat.companion.user]:
            raise PermissionDenied("You are not a participant in this chat")
        serializer.save(sender=self.request.user)
