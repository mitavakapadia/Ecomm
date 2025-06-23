from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name="home"),
    path("search/", views.search, name="search"),
    path("popularity/", views.popularity, name="popularity"),
    path("low-to-high/", views.low_to_high, name="low-to-high"),
    path("high-to-low/", views.high_to_low, name="high-to-low"),
    path("newest/", views.newest, name="newest"),
    path("<slug:slug>/", views.product_detail, name="product-detail"),
    path("category/<slug:category_slug>/", views.product_list, name="product_list_by_category"),
]
