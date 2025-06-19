from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth import login, authenticate
from django.contrib.auth.forms import AuthenticationForm
# from django.contrib.auth.hashers import make_password

# user.password = make_password('password')

from . import forms
from .forms import RegistrationForm, LoginForm
from .models import Customer
# Create your views here.

def sign_up(request):
    if request.method == "POST":
        form = RegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect("signup")
        else:
            print("else")
            form = RegistrationForm()
        return render(request, "accounts/signup.html", {"form":form})
    else:
        return render(request, "accounts/signup.html")
    
def login_page(request):
    # form = forms.LoginForm()
    message = ""
    if request.method == "POST":
        email = request.POST.get("email")
        password = request.POST.get("password")

        form = LoginForm(request.POST)
        if form.is_valid():
            # email = request.POST.get("email")
            # password = request.POST.get("password")
            user = authenticate(
                request,
                username= email,
                password = password
            )
            if user is not None:
                login(request, user)
                message = f"Hello {user.email}! You have logged in successfully!"
                return render(request, "accounts/login.html", {"message":message})
            else:
                message = "Login failed!"
    return render(request, "accounts/login.html", {"form":form, "message":message})