
from django.urls import path
from companywebsite.views import home, about, services, ContactView,SuccesView,bms_service

urlpatterns = [

    path('', home, name='home'),
    path('about/', about, name='about'),
    path('services/', services, name='services'),
    path('contact/', ContactView.as_view(), name='contact'),
    path("success/", SuccesView.as_view(), name="success"),
    path('services/bms/', bms_service, name='bms_service'),  
]
