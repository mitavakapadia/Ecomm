from django.db import models
from django.conf import settings
from product.models import Product, Category
from accounts.models import Customer
from decimal import Decimal

# Create your models here.

class Cart(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    ordered = models.BooleanField(default=False)

class CartItem(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)

    def __str__(self):
        return f"{self.quantity} x {self.product.prod_name}"

    def total_price(self):
        return self.quantity * self.product.price
    
    def discount(self):
        if self.product.category and self.product.category.discount:
            return (self.product.category.discount / 100) * self.product.price * self.quantity
        return 0
    
    def final_price(self):
        return self.total_price() - self.discount()

    
















# class Cart:
#     def __init__(self, request):
#         self.session = request.session
#         cart = self.session.get(settings.CART_SESSION_ID)
#         if not cart:
#             cart = self.session[settings.CART_SESSION_ID] = {}
#         self.cart = cart

#     def __iter__(self):
#         product_ids = self.cart.keys()
#         products = Product.objects.filter(id__in=product_ids)
#         cart = self.cart.copy()
#         for product in products:
#             cart[str(product.id)]["product"] = product
#         for item in cart.values():
#             item['price'] = Decimal(item["price"])
#             item["total_price"] = item["price"] * item["quatity"]
#             yield item

#     def __len__(self):
#         return sum(item["quantity"] for item in self.cart.values())
    
#     def add(self, product, quantity=1, override_quantity=False):
#         product_id = str(product.id)
#         if product_id not in self.cart:
#             self.cart[product_id] = {
#                 "quantity" : 0,
#                 "price" : str(product.price)
#             }
        
#         if override_quantity:
#             self.cart[product_id]["quantity"] = quantity
#         else:
#             self.cart[product_id]["quantity"] += quantity
#         self.save()

#     def save(self):
#         self.session.modified = True

#     def remove(self, product):
#         product_id = str(product.id)
#         if product_id in self.cart:
#             del self.cart[product_id]
#             self.save()
    
#     def clear(self):
#         del self.session[settings.CART_SESSION_ID]
#         self.save()

#     def get_total_price(self):
#         return sum(Decimal(item["price"]) * item["quantity"] for item in self.cart.values())