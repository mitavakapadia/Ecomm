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
from .forms import RegistrationForm, LoginForm
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
            current_site_info = get_current_site(request)
            mail_subject = "Activate your GreatKart Account"
            message = render_to_string("accounts/activate_account.html", {
                "user": user,
                "domain": current_site_info.domain,
                "uid": urlsafe_base64_encode(force_bytes(user.pk)),
                "token": account_activation_token.make_token(user),
            })
            to_email = form.cleaned_data.get("email")
            email = EmailMessage(
                mail_subject, message, to=[to_email]
            )
            email.send()
            return HttpResponse("Please proceed confirm your email address to complete the registration")
            # activateEmail(request, user, form.cleaned_data.get('email'))
            # return redirect("accounts:login")
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
        user = Customer.objects.get(pk=uid)
    except(TypeError, ValueError, OverflowError, User.DoesNotExist):
        user = None
    if user is not None and account_activation_token.check_token(user, token):
        user.is_active = True
        user.save()
        return HttpResponse("Thank you for your email confirmation. Now you can login your account!")
    else:
        print("Decoded UID:", uid)
        print("Token valid:", account_activation_token.check_token(user, token))
        print("User is:", user)
        return HttpResponse("Activation link is invalid")
    # return redirect('homepage')

# def activateEmail(request, user, to_email):
#     mail_subject = "Activate your GreatKart Account"
#     message = render_to_string("accounts/activate_account.html", {
#         "user": user.email,
#         "domain": get_current_site(request).domain,
#         "uid": urlsafe_base64_encode(force_bytes(user.pk)),
#         "token": account_activation_token.make_token(user),
#         "protocol": "https" if request.is_secure() else "http"
#     })
#     email = EmailMessage(mail_subject, message, to=[to_email])
#     if email.send():
#         message.success(request, f"Thank you <b>{user}</b> for registering!<br> You are almost there to login into GreatKart. <br> Please go to <b>{to_email}</b> inbox and click on received account activation link to confirm and complete the registration. <br> Note: Check your spam folder too!")
#     else:
#         message.error(request, f"Problem occured while sending email to {to_email}, check if email is correctly typed.")


# def activate(request, uidb64, token):
#     User = get_user_model()
#     try:
#         uid = force_str(urlsafe_base64_decode(uidb64))
#         user = Customer.objects.get(pk=uid)
#     except(TypeError, ValueError, OverflowError, User.DoesNotExists):
#         user= None
#     if user is not None and account_activation_token.check_token(user, token):
#         user.is_active = True
#         user.save()

#         message.success(request, 'Thank you for your email confirmation. Now you can login your account.')
#         return redirect("login")
#     else:
#         message.error(request, "Activation link is invalid")
#     return redirect("home")

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