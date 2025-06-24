from django.urls import path
from . import views

app_name = "accounts"

urlpatterns = [
    path("login/", views.login_page, name="login"),
    path("signup/", views.sign_up, name="signup"),
    path("logout/", views.logout_page, name="logout")
]
