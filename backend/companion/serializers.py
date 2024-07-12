# serializers.py
from rest_framework import serializers
from .models import Companion, CompanionPhoto

class CompanionPhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanionPhoto
        fields = ['id', 'photo']

class CompanionDetailSerializer(serializers.ModelSerializer):
    photos = CompanionPhotoSerializer(many=True, read_only=True)

    class Meta:
        model = Companion
        fields = '__all__'

class CompanionListSerializer(serializers.ModelSerializer):
    photos = CompanionPhotoSerializer(many=True, read_only=True)

    class Meta:
        model = Companion
        fields = '__all__'
