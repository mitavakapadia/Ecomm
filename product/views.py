from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Category, Product

# Create your views here.

def home(request):
    all_products = Product.objects.all()
    categories = Category.objects.all()
    return render(request, "product/home.html", {
        "all_products":all_products,
        "categories": categories
    })

def product_detail(request, pk):
    product = get_object_or_404(Product, pk=pk)
    return render(request, "product/product_detail.html", {"product":product})

def product_list(request, category_slug=None):
    category = None
    categories = Category.objects.all()
    products = Product.objects.filter(available=True)
    if category_slug:
        category = get_object_or_404(Category, slug=category_slug)
        products = products.filter(category=category)
    return render(request, "product/categories.html", {
        "category": category,
        "categories": categories,
        "products": products
    })