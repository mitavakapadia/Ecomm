from django.db import models
from django.conf import settings
from accounts.models import Customer, DeliveryAddress
from product.models import Product

# Create your models here.

class Order(models.Model):
    STATUS_CHOICES = [
        ("pending", "Pending"),
        ("shipped", "Shipped"),
        ("delivered", "Delivered"),
    ]
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    address = models.ForeignKey(DeliveryAddress, on_delete=models.SET_NULL, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="pending")
    ordered = models.BooleanField(default=False)

    def __str__(self):
        return f"Order #{self.id}"
    
class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name="items", on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField()
    ordered = models.BooleanField(default=False)

    def get_total(self):
        return self.price * self.quantity