from django.urls import path
from . import views

app_name = "cart"

urlpatterns = [
    path("", views.cart_detail, name="cart-detail"),
    path("add/<int:product_id>/", views.add_to_cart, name="cart-add"),
    path("remove/<int:product_id>", views.remove_from_cart, name="cart-remove"),
    path("update/<int:item_id>", views.update_cart_item, name="cart-update"),
]
