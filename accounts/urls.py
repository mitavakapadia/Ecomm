from django.urls import path
from . import views
from django.contrib.auth.views import (
    PasswordResetView, 
    PasswordResetDoneView, 
    PasswordResetConfirmView, 
    PasswordResetCompleteView
)

app_name = "accounts"

urlpatterns = [
    path("login/", views.login_page, name="login"),
    path("register/", views.register, name="register"),
    path("logout/", views.logout_page, name="logout"),
    path("dashboard/", views.dashboard, name="dashboard"),
    path("addresses", views.manage_addresses, name="addresses"),
    path("addresses/update/<int:address_id>/", views.edit_address, name='edit-address'),
    path("addresses/delete/<int:address_id>/", views.delete_address, name='delete-address'),
    path('edit-profile/', views.edit_profile, name='edit-profile'),
    path("password-reset/", PasswordResetView.as_view(template_name="accounts/password_reset.html"), name="password-reset"),
    path("password-reset/done/", PasswordResetDoneView.as_view(template_name="accounts/password_reset_done.html"), name="password_reset_done"),
    path("password-reset-confirm/<uidb64>/<token>/", PasswordResetConfirmView.as_view(template_name="accounts/password_reset_confirm.html"), name="password_reset_confirm"),
    path("activate/<uidb64>/<token>",views.activate, name="activate")
]
