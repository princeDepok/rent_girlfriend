from django.contrib import admin
from .models import Companion, CompanionPhoto

class CompanionPhotoInline(admin.StackedInline):  # Use StackedInline for a different layout
    model = CompanionPhoto
    extra = 1

class CompanionAdmin(admin.ModelAdmin):
    inlines = [CompanionPhotoInline]
    list_display = ('name', 'age', 'gender', 'rating')  # Customize the list display
    search_fields = ('name', 'id_card')  # Add search fields
    list_filter = ('gender', 'rating')  # Add list filters

admin.site.register(Companion, CompanionAdmin)
