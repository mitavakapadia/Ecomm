from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.conf import settings
from django.core.mail import send_mail, EmailMessage
from django.template.loader import render_to_string
from accounts.models import DeliveryAddress, Customer
from cart.models import CartItem, Cart
from orders.models import Order, OrderItem
from product.models import Product, Category
from accounts.forms import DeliveryAddressForm

# Create your views here.

@login_required
def checkout(request):
    addresses = DeliveryAddress.objects.filter(customer=request.user)
    cart = get_object_or_404(Cart, customer=request.user, ordered=False)
    cart_items = CartItem.objects.filter(cart=cart)
    customer = Customer.objects.filter(email=request.user).first()
    categories = Category.objects.all()
    
    total = sum(item.product.price * item.quantity for item in cart_items)
    total_price = sum(item.total_price() for item in cart_items)
    discount = sum(item.discount() for item in cart_items)
    final_price = total_price - discount
    
    order = Order.objects.create(customer=request.user)
    print("ORDER OBJECT:", order)
    print("ORDER ID:", order.id)
    for item in cart_items:
        OrderItem.objects.create(
            order=order,
            product=item.product,
            price=item.product.price,
            quantity=item.quantity,
        )

        item.product.stock -= item.quantity
        item.product.save()

    return render(request, "orders/place_order.html", {
            "addresses": addresses,
            "cart_items": cart_items,
            "total": total,
            "categories": categories,
            "form": DeliveryAddressForm(),
            "error": "Selected address not found.",
            "total_price": round(total_price, 2),
            "discount": round(discount, 2),
            "final_price": round(final_price, 2),
            "order": order, 
            "customer":customer,
        })

@login_required
def order_confirmation(request, order_id):
    cart = get_object_or_404(Cart, customer=request.user, ordered=False)
    order = Order.objects.filter(pk=order_id).first()
    print("request id ",request.method)
    address = None
    if request.method == 'POST':
        selected_address_id = request.POST.get('selected_address')
        print("selected_address_id - ",selected_address_id)
        address = DeliveryAddress.objects.filter(pk=selected_address_id).first()

    from django.db.models import F, ExpressionWrapper, DecimalField
    order_items = OrderItem.objects.filter(order=order).annotate(total=ExpressionWrapper(F('quantity')*F('product__price'), output_field=DecimalField(max_digits=12, decimal_places=2)))
    cart_items = CartItem.objects.filter(cart=cart)
    total_price = sum(item.total_price() for item in cart_items)
    discount = sum(item.discount() for item in cart_items)
    final_price = total_price - discount

    subject="Order Confirmation",
    message= render_to_string("orders/order_confirm_email.html", {
        "order_items":order_items,
        "total_price": total_price,
        "discount": discount,
        "final_price":final_price
    })
    email = EmailMessage(subject, message, from_email=settings.EMAIL_FROM, 
        to=[request.user.email])
    email.send()

    order.ordered = True
    order.save()
    cart.ordered = True
    cart.save()

    order = get_object_or_404(Order, id=order_id, customer=request.user)
    return render(request, "orders/order_completed.html", {
    "order": order,
    "order_items": order_items,
    "total_price": total_price,
    "discount": discount,
    "final_price":final_price,
    "address":address,

})