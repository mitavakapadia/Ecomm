from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_POST, require_GET
from product.models import Product
from cart.models import Cart
from .forms import CartAddProductForm

# Create your views here.

@require_POST
def cart_add(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)
    form = CartAddProductForm(request.POST)
    if form.is_valid():
        cd = form.cleaned_data
        cart.add(
            product=product, 
            quantity=cd["quantity"], 
            override_quantity=cd["override"]
        )
    return redirect("cart:cart-detail")

@require_POST
def cart_remove(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)
    cart.remove(product)
    return redirect("cart:cart-detail")

@require_POST
def cart_detail(request):
    if request.POST:
        cart = Cart(request)
        for item in cart:
            item["update_quantity_form"] = CartAddProductForm(initial={
                "quantity": item["quantity"], 
                "override": True
            })
        return redirect(request, "cart/cart.html", {"cart" : cart})
    else:
        return redirect(request, "cart/cart.html", {})
