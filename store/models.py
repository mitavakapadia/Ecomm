from django.db import models

# Create your models here.

class Customer(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    phone = models.CharField(max_length=10)
    email = models.EmailField(unique=True)

    def register(self):
        return self.save()
    
    @staticmethod
    def get_customer_by_email(email):
        try:
            Customer.objects.get(email=email)
        except:
            return False
    
    def is_customer_exists(self):
        if Customer.objects.filter(email=self.email):
            return True
        
        return False

    def full_name(self):
        return f"{self.first_name} {self.last_name}"
    
    def __str__(self):
        return self.full_name()

class Category(models.Model):
    name = models.CharField(max_length=50)

    class Meta:
        verbose_name_plural = "Categories"
        
    @staticmethod
    def get_all_categories(self):
        return Category.objects.all()
    
    def __str__(self):
        return self.name

class Product(models.Model):
    product_name = models.CharField(max_length=50)
    price = models.IntegerField(default=0)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, default=1)
    desc = models.CharField(max_length=250, null=True, blank=True, default="")
    images = models.ImageField(upload_to="imgs")

    @staticmethod
    def get_all_products(self):
        return Product.objects.all()
    
    @staticmethod
    def get_product_by_id(ids):
        return Product.objects.filter(id__in=ids)
    
    @staticmethod
    def get_product_by_category(category_name):
        if category_name:
            Product.objects.filter(category=category_name)
        else:
            Product.get_all_products()

    def __str__(self):
        return self.product_name

class Order(models.Model):
    product_name = models.ForeignKey(Product, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    qty = models.IntegerField(default=1)
    price = models.IntegerField()
    status = models.BooleanField(default=False)
    address = models.CharField(max_length=250)
    date = models.DateField(auto_now=True)
    phone = models.CharField(max_length=10)

    def place_order(self):
        return self.save()
    
    def get_order_by_customer(customer_id):
        return Order.objects.filter(customer=customer_id).order_by('-date')

    def __str__(self):
        return f"{self.product_name}"

