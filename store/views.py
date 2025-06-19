from django.shortcuts import render
from django.http import HttpResponse
from .models import Customer, Category, Product, Order
from django.views import View

# Create your views here.

# def home(request):
#     return render(request, "store/index.html")
