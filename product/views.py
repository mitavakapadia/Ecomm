from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .models import Category, Product
from django.db.models import Q
from datetime import date
from cart.forms import CartAddProductForm

# Create your views here.

def home(request):
    all_products = Product.objects.all()
    categories = Category.objects.all()
    return render(request, "home.html", {
        "all_products":all_products,
        "categories": categories
    })

def product_detail(request, slug):
    product = get_object_or_404(Product, slug=slug)
    categories = Category.objects.all()
    cart_product_form = CartAddProductForm()
    related_products = Product.objects.filter(
    category=product.category).exclude(id=product.id).order_by('?')[:4]
    low_stock = False
    
    if product.stock < 25:
        low_stock = True

    return render(request, "product/product_detail.html", {
        "product":product, 
        "related_products":related_products,
        "categories":categories,
        "cart_product_form":cart_product_form,
        "low_stock": low_stock
    })

def search(request):
    query = request.GET.get("search")
    products = Product.objects.all()
    categories = Category.objects.all()
    if query:
        products = products.filter(Q(prod_name__icontains=query))
    else:
        return render(request, "product/search.html")

    return render(request, "product/search.html", {
        "query": query, 
        "products":products,
        "categories": categories,
    })

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

def popularity(request):
    product = Product.objects.all()
    popular_products = product.filter(rating__gte=3)
    return render(request, "product/popular_products.html", {
        "popular_products":popular_products
    })

def newest(request):
    product = Product.objects.all()
    newest_products = product.order_by("-created_at")
    return render(request, "product/newest_products.html", {
        "newest_products":newest_products
    })

def low_to_high(request):
    products = Product.objects.all()
    l_to_h = products.order_by("price")
    categories = Category.objects.all()
    return render(request, "product/low_to_high.html", {
        "l_to_h":l_to_h,
        "categories":categories
    })

def high_to_low(request):
    products = Product.objects.all()
    h_to_l = products.order_by("-price")
    categories = Category.objects.all()
    return render(request, "product/high_to_low.html", {
        "h_to_l":h_to_l,
        "categories":categories
    })