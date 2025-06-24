from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.forms import AuthenticationForm
from . import forms
from .forms import RegistrationForm, LoginForm
from .models import Customer

# Create your views here.


def sign_up(request):
    if request.method == "POST":
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.set_password(form.cleaned_data["password1"])
            user.save()
            return redirect("accounts:login")
        else:
            print(form.errors)
    else:
        form = RegistrationForm()
    
    context = {"form": form}
    return render(request, "accounts/register.html", context)

def login_page(request):
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            password = form.cleaned_data['password']
            user = authenticate(request, username=email, password=password)

            if user:
                login(request, user)
                return redirect("home")
            else:
                form.add_error(None, "Invalid email or password")
    else:
        form = LoginForm()

    return render(request, "accounts/signin.html", {"form": form})

        
def logout_page(request):
    logout(request)
    return redirect("/")