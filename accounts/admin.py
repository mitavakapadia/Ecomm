from django.contrib import admin
from .models import Customer, DeliveryAddress
# Register your models here.

class CustomerAdmin(admin.ModelAdmin):
    def log_change(self, request, object, message):
        pass

class DeliveryAddressAdmin(admin.ModelAdmin):
    def log_change(self, request, object, message):
        pass

admin.site.register(Customer, CustomerAdmin)
admin.site.register(DeliveryAddress, DeliveryAddressAdmin)