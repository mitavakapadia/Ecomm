from django.db import models

# Create your models here.

class Customer(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    phone = models.CharField(max_length=10)
    password = models.CharField(max_length=50)
    address = models.TextField(max_length=250)

    USERNAME_FIELD = "email"

    def __str__(self):
        return self.email