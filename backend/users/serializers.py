from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers
from bookings.models import Service
from .models import Companion, CompanionGallery

User = get_user_model()

class UserListSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password', 'gender', 'birth_date')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
            gender=validated_data['gender'],
            birth_date=validated_data['birth_date'],
        )
        return user

class UserDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'gender', 'birth_date', 'is_companion']

class CompanionGallerySerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanionGallery
        fields = ['id', 'image']

class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = ['id', 'name', 'description']

class CompanionSerializer(serializers.ModelSerializer):
    user = serializers.ReadOnlyField(source='user.username')
    # images = serializers.ImageField(required=False)  # Comment out image field
    services_offered = serializers.JSONField()

    class Meta:
        model = Companion
        fields = ['id', 'user', 'fullname', 'id_card', 'phone_number', 'bank_account', 'bank_account_number', 'bio', 'tags', 'experience', 'services_offered', 'instagram_account', 'available', 'location', 'is_approved']
        read_only_fields = ['is_approved']

    def create(self, validated_data):
        services_data = validated_data.pop('services_offered')
        request = self.context.get('request')
        user = request.user
        user.is_companion = True
        user.save()
        companion = Companion.objects.create(user=user, **validated_data)
        companion.services_offered = services_data
        companion.save()
        return companion

    def update(self, instance, validated_data):
        services_data = validated_data.pop('services_offered')
        instance.fullname = validated_data.get('fullname', instance.fullname)
        instance.id_card = validated_data.get('id_card', instance.id_card)
        instance.phone_number = validated_data.get('phone_number', instance.phone_number)
        instance.bank_account = validated_data.get('bank_account', instance.bank_account)
        instance.bank_account_number = validated_data.get('bank_account_number', instance.bank_account_number)
        instance.bio = validated_data.get('bio', instance.bio)
        instance.tags = validated_data.get('tags', instance.tags)
        instance.experience = validated_data.get('experience', instance.experience)
        instance.instagram_account = validated_data.get('instagram_account', instance.instagram_account)
        # instance.images = validated_data.get('images', instance.images)  # Comment out image field
        instance.available = validated_data.get('available', instance.available)
        instance.location = validated_data.get('location', instance.location)
        instance.services_offered = services_data
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
