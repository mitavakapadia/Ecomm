from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Customer
from django import forms

class ProfileForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = ['name', 'email', 'phone', 'address']

class RegistrationForm(UserCreationForm):
    name = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    phone = forms.CharField(
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'maxlength': '10',
            'pattern': '[0-9]*',
            'inputmode': 'numeric',
            'placeholder': 'Enter 10-digit phone number'
        })
    )
    address = forms.CharField(
        widget=forms.Textarea(attrs={'class': 'form-control'})
    )
    password1 = forms.CharField(
        label="Password",
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        strip=False,
    )
    password2 = forms.CharField(
        label="Password confirmation",
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        strip=False,
    )

    class Meta:
        model = Customer
        fields = ["email", "name", "phone", "address"]
        widgets = {
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.Textarea(attrs={'class': 'form-control'}),
        }

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords do not match.")
        return password2

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user

class LoginForm(forms.Form):
    email = forms.EmailField(widget=forms.EmailInput(attrs={'class': 'form-control'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))