# users/serializers.py
from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers
from rest_framework_simplejwt.tokens import RefreshToken
from django.utils.translation import gettext_lazy as _
from .models import Companion, CompanionGallery

User = get_user_model()

class UserListSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email'] 

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password', 'first_name', 'last_name', 'gender', 'birth_date')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            gender=validated_data['gender'],
            birth_date=validated_data['birth_date'],
        )
        return user

class UserDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'gender', 'birth_date', 'is_companion']

class CompanionGallerySerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanionGallery
        fields = ['id', 'image']

class CompanionSerializer(serializers.ModelSerializer):
    user = UserDetailSerializer(read_only=True)

    class Meta:
        model = Companion
        fields = ['id', 'user', 'bio', 'hobby', 'hourly_rate', 'available', 'location', 'is_approved']
        read_only_fields = ['is_approved']

    def create(self, validated_data):
        request = self.context.get('request')
        user = request.user
        user.is_companion = True
        user.save()
        companion = Companion.objects.create(user=user, **validated_data)
        return companion

    def update(self, instance, validated_data):
        instance.bio = validated_data.get('bio', instance.bio)
        instance.hobby = validated_data.get('hobby', instance.hobby)
        instance.hourly_rate = validated_data.get('hourly_rate', instance.hourly_rate)
        instance.available = validated_data.get('available', instance.available)
        instance.location = validated_data.get('location', instance.location)
        instance.save()
        return instance

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        if username and password:
            user = authenticate(request=self.context.get('request'), username=username, password=password)
            if not user:
                msg = _('Unable to log in with provided credentials.')
                raise serializers.ValidationError(msg, code='authorization')
        else:
            msg = _('Must include "username" and "password".')
            raise serializers.ValidationError(msg, code='authorization')

        data['user'] = user
        return data

class ResetPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()

class ValidateOTPSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField()

class SetNewPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()
    new_password = serializers.CharField()

class LogoutSerializer(serializers.Serializer):
    refresh = serializers.CharField()
