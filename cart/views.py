from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_POST, require_GET
from django.contrib.auth.decorators import login_required
from product.models import Product, Category
from cart.models import Cart, CartItem
from .forms import CartAddProductForm
from django.contrib import messages

def get_cart(request):
    if request.user.is_authenticated:
        cart = Cart.objects.filter(customer__email=request.user, ordered=False).first()
        if not cart:
            cart = Cart.objects.create()
            request.session["cart_id"] = cart.id
    else:
        cart_id = request.session.get("cart_id")
        if cart_id:
            cart = get_object_or_404(Cart, id=cart_id)
        else:
            cart = Cart.objects.create()
            request.session["cart_id"] = cart.id
    print("cart= ", cart)
    return cart

def add_to_cart(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart = get_cart(request)
    print(cart)
    cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product, )
    if not created:
        cart_item.quantity += 1
    cart_item.save()
    return redirect("cart:cart-detail")

@require_POST
def update_cart_item(request, item_id):
    cart = get_cart(request)
    cart_item = get_object_or_404(CartItem, id=item_id, cart=cart)

    qty = int(request.POST.get("quantity", 1))
    cart_item.quantity = max(1, qty)
    cart_item.save()
    return redirect("cart:cart-detail")


def remove_from_cart(request, product_id):
    cart = get_cart(request)
    cart_item = get_object_or_404(CartItem, cart=cart, product_id=product_id)
    cart_item.delete()
    return redirect("cart:cart-detail")

def cart_detail(request):
    cart = None
    categories = Category.objects.all()
    items = []

    if request.user.is_authenticated:
        cart = Cart.objects.filter(customer=request.user, ordered=False).first()
        if cart:
            request.session["cart_id"] = cart.id 
        else:
            cart = Cart.objects.create(customer=request.user)
    else:
        cart_id = request.session.get("cart_id")
        if cart_id:
            cart = get_object_or_404(Cart, id=cart_id)

    if cart:
        items = CartItem.objects.filter(cart=cart)
        total_price = sum(item.total_price() for item in items)
        discount = sum(item.discount() for item in items)
        final_price = total_price - discount
    else:
        total_price = discount = final_price = 0

    return render(request, "cart/cart.html", {
        "cart": cart,
        "items": items,
        "total_price": round(total_price, 2),
        "discount": round(discount, 2),
        "final_price": round(final_price, 2),
        "categories":categories
    })