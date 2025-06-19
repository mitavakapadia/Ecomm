from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import Customer

class RegistrationForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = "__all__"

class LoginForm(forms.Form):
    email = forms.EmailField()
    password = forms.CharField(max_length=50, widget=forms.PasswordInput)