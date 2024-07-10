from rest_framework import viewsets
from .models import Companion
from .serializers import CompanionDetailSerializer, CompanionListSerializer
from rest_framework.permissions import IsAdminUser

class CompanionViewSet(viewsets.ModelViewSet):
    queryset = Companion.objects.all()

    def get_serializer_class(self):
        if self.action == 'list':
            return CompanionListSerializer
        return CompanionDetailSerializer

    def get_permissions(self):
        if self.action in ['create', 'update', 'partial_update', 'destroy']:
            self.permission_classes = [IsAdminUser,]
        return super(self.__class__, self).get_permissions()

