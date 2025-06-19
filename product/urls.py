from django.urls import path
from . import views

urlpatterns = [
    path("", views.product_list, name="product_list"),
    path("<int:pk>/", views.product_detail, name="product-detail"),
    path("<slug:category_slug>/", views.product_list, name="product_list_by_category"),
]
