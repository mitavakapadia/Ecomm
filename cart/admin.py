from django.contrib import admin
from .models import Cart, CartItem

# Register your models here.

class CartAdmin(admin.ModelAdmin):
    def log_change(self, request, object, message):
        pass

class CartItemAdmin(admin.ModelAdmin):
    def log_change(self, request, object, message):
        pass

admin.site.register(Cart, CartAdmin)
admin.site.register(CartItem, CartItemAdmin)