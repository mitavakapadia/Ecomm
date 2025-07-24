from django.db import models

# Create your models here.

class Category(models.Model):
    name = models.CharField(max_length=100, db_index=True)
    slug = models.SlugField(unique=True)
    discount = models.DecimalField(max_digits=10, decimal_places=2, default=10.00)

    class Meta:
        ordering = ("name",)
        verbose_name_plural = "Categories"

    def __str__(self):
        return self.name
    
class Brand(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name
    
class Product(models.Model):
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    prod_name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True)
    prod_img = models.ImageField(upload_to="products")
    price = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.TextField(blank=True)
    rating = models.IntegerField(default=0)
    review = models.CharField(max_length=300)
    available = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    stock = models.IntegerField(default=50)

    class Meta:
        ordering = ("-created_at",)
        indexes = [
            models.Index(fields=["id", "slug"], name="id_slug_index")
        ]

    def __str__(self):
        return self.prod_name