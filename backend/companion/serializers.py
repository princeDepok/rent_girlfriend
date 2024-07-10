from rest_framework import serializers
from .models import Companion

class CompanionDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Companion
        fields = '__all__'

class CompanionListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Companion
        fields = '__all__'
