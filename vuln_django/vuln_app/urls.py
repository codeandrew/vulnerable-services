from django.urls import path
from . import views

urlpatterns = [
    path('code-injection/', views.code_injection, name='code-injection'),
    path('sql-injection/', views.sql_injection, name='sql-injection'),
]
