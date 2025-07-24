from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth import get_user_model
from django.contrib.auth.decorators import login_required

from django.template.loader import render_to_string
from django.contrib.sites.shortcuts import get_current_site
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.core.mail import EmailMessage
from .tokens import account_activation_token

from django.contrib.auth.forms import AuthenticationForm
from . import forms
from .forms import RegistrationForm, LoginForm, ProfileForm, DeliveryAddressForm
from .models import Customer, DeliveryAddress
from product.models import Product, Category

# Create your views here.

def register(request):
    if request.method == "POST":
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.set_password(form.cleaned_data["password1"])
            user.is_active = False
            user.save()

            uid = urlsafe_base64_encode(force_bytes(user.pk))
            token = account_activation_token.make_token(user)

            print("Registering user with:")
            print("UID:", uid)
            print("Token:", token)
            print("user.is_active:", user.is_active)

            current_site_info = get_current_site(request)
            
            mail_subject = "Activate your GreatKart Account"
            message = render_to_string("accounts/activate_account.html", {
                "user": user,
                "domain": current_site_info.domain,
                "uid": uid,
                "token": token,
            })
            email = EmailMessage(mail_subject, message, to=[user.email])
            email.send()
            context = {"user":user}
            return render(request, "accounts/activation_sent.html", context)
        else:
            print(form.errors)
    else:
        form = RegistrationForm()
    
    context = {"form": form}
    return render(request, "accounts/register.html", context)

def activate(request, uidb64, token):
    User = get_user_model()
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except (TypeError, ValueError, OverflowError, User.DoesNotExist):
        user = None

    if user is not None:
        is_valid_token = account_activation_token.check_token(user, token)
        print("Decoded UID:", uid)
        print("Token valid:", is_valid_token)
        print("User is:", user)

        if is_valid_token:
            user.is_active = True
            user.save()
            return render(request, "accounts/activation_success.html", {"user": User.objects.get(pk=uid)})
    else:
        print("Decoded UID:", uidb64)
        print("User is: None")

        return render(request, "accounts/activation_invalid.html")

def login_page(request):
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            password = form.cleaned_data["password"]
            user = authenticate(request, username=email, password=password)
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return redirect("/")
                else:
                    form.add_error(None, "Please activate your account from the email sent to you.")
            else:
                form.add_error(None, "Invalid email or password")
    else:
        form = LoginForm()

    return render(request, "accounts/signin.html", {"form": form})

def logout_page(request):
    logout(request)
    return redirect("/")

@login_required
def edit_profile(request):
    user = request.user
    if request.method == "POST":
        form = ProfileForm(request.POST, instance=user)
        if form.is_valid():
            form.save()
            return redirect("product:home")
    else:
        form = ProfileForm(instance=user)

    return render(request, "accounts/edit_profile.html", {"form": form})

@login_required
def manage_addresses(request):
    addresses = DeliveryAddress.objects.filter(customer=request.user)
    categories = Category.objects.all()
    form = DeliveryAddressForm()

    if request.method == "POST":
        form = DeliveryAddressForm(request.POST)
        if form.is_valid():
            address = form.save(commit=False)
            address.customer = request.user
            if address.is_default:
                DeliveryAddress.objects.filter(customer=request.user, is_default=True).update(is_default=False)
            address.save()
            return redirect("accounts:addresses")

    return render(request, "accounts/addresses.html", {
        "addresses": addresses, 
        "form": form, 
        "categories":categories})

@login_required
def edit_address(request, address_id):
    address = get_object_or_404(DeliveryAddress, id=address_id, customer=request.user)
    if request.method == "POST":
        form = DeliveryAddressForm(request.POST, instance=address)
        if form.is_valid():
            updated_address = form.save(commit=False)
            if updated_address.is_default:
                DeliveryAddress.objects.filter(customer=request.user, is_default=True).exclude(id=address_id).update(is_default=False)
            updated_address.save()
            return redirect("accounts:addresses")
    else:
        form = DeliveryAddressForm(instance=address)
    return render(request, "accounts/addresses.html", {
        "form": form, 
        "is_editing": True, 
        "address_id": address.id,
        "addresses": DeliveryAddress.objects.filter(customer=request.user)
        })

@login_required
def delete_address(request, address_id):
    address = get_object_or_404(DeliveryAddress, id=address_id, customer=request.user)
    address.delete()
    return redirect("accounts:addresses")

def dashboard(request):
    categories = Category.objects.all()
    user = request.user
    if request.method == "POST":
        form = ProfileForm(request.POST, instance=user)
        if form.is_valid():
            form.save()
            return redirect("product:home")
    else:
        form = ProfileForm(instance=user)
    context = {"categories":categories, "form":form}
    return render(request, "accounts/dashboard.html", context)