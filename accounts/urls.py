from django.urls import path
from . import views

app_name = "accounts"

urlpatterns = [
    path("login/", views.login_page, name="login"),
    path("register/", views.register, name="register"),
    path("logout/", views.logout_page, name="logout"),
    path('activate/<uidb64>/<token>',views.activate, name='activate')
    # path("activateemail/<uidb64>/<token>", views.activateEmail, name="activateEmail"),
    # path("activate/<uidb64>/<token>", views.activate, name="activate")
]
