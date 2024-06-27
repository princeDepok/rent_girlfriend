from django.contrib import admin

from bookings.models import Service, Package

@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ('name', 'description')
    search_fields = ('name',)

@admin.register(Package)
class PackageAdmin(admin.ModelAdmin):
    list_display = ('companion', 'duration', 'price', 'extra_hour_price')
    search_fields = ('companion__name', 'duration')