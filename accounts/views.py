from django.shortcuts import render, redirect
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
from .forms import RegistrationForm, LoginForm, ProfileForm
from .models import Customer

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
            # to_email = form.cleaned_data.get("email")
            email = EmailMessage(mail_subject, message, to=[user.email])
            email.send()
            return HttpResponse("Please proceed confirm your email address to complete the registration")
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
            return HttpResponse("Thank you for your email confirmation. Now you can login your account!")
    else:
        print("Decoded UID:", uidb64)
        print("User is: None")

    return HttpResponse("Activation link is invalid")

def login_page(request):
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            password = form.cleaned_data['password']
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
    if request.method == 'POST':
        form = ProfileForm(request.POST, instance=user)
        if form.is_valid():
            form.save()
            return redirect('product:home')
    else:
        form = ProfileForm(instance=user)

    return render(request, 'accounts/edit_profile.html', {'form': form})