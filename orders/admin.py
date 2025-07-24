from django.contrib import admin
from .models import Order, OrderItem
# Register your models here.

class OrderModel(admin.ModelAdmin):
    def log_change(self, request, object, message):
        pass

class OrderItemModel(admin.ModelAdmin):
    def log_change(self, request, object, message):
        pass

admin.site.register(Order, OrderModel)
admin.site.register(OrderItem, OrderItemModel)
