from django.contrib import admin
from .models import Category, Brand, Product
from django.contrib.admin import SimpleListFilter
from . import models
# Register your models here.

class CategoryAdmin(admin.ModelAdmin):
    list_display = ["name", "slug"]
    list_filter = ["name"]
    prepopulated_fields = {"slug": ("name",)}

class LowStockFilter(SimpleListFilter):
    title = 'Stock Level'
    parameter_name = 'stock_level'

    def lookups(self, request, model_admin):
        return [
            ('low', 'Low Stock'),
        ]

    def queryset(self, request, queryset):
        if self.value() == 'low':
            return queryset.filter(quantity__lt=models.F('low_stock_threshold'))
        return queryset

class ProductAdmin(admin.ModelAdmin):
    list_display = ["prod_name", "category", "brand", "available", "slug", "low_stock_warning"] 
    search_fields = ('prod_name',)

    def low_stock_warning(self, obj):
        if obj.stock < 5:
            from django.utils.html import format_html
            return format_html('<span style="color:red;">Low Stock!</span>')
        return 'OK'

    low_stock_warning.short_description = 'Stock Status'

    def log_change(self, request, object, message):
        pass

admin.site.register(Category, CategoryAdmin)
admin.site.register(Brand)
admin.site.register(Product, ProductAdmin)