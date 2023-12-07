from django.db import models



class Contact(models.Model):
    name = models.CharField(max_length=100, verbose_name="Имя")
    email = models.EmailField(max_length=100, verbose_name="Email")
    phone = models.CharField(max_length=12, verbose_name="Телефон")
    description = models.TextField(verbose_name="Описание")

    def __str__(self):
        return self.name