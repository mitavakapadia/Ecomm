from django.contrib import admin
from .models import Category, Brand, Product

# Register your models here.

class CategoryAdmin(admin.ModelAdmin):
    list_display = ["name", "slug"]
    list_filter = ["name"]
    prepopulated_fields = {"slug": ("name",)}

class ProductAdmin(admin.ModelAdmin):
    list_display = ["prod_name", "category", "brand", "available", "slug"]
    list_filter = ["category", "price",]
    prepopulated_fields = {"slug": ("prod_name",)}

admin.site.register(Category, CategoryAdmin)
admin.site.register(Brand)
admin.site.register(Product, ProductAdmin)