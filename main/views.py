from rest_framework import generics, permissions
from .models import Contact
from .serializers import ContactSerializer

class ContactListCreateAPIView(generics.ListCreateAPIView):
    queryset = Contact.objects.all()
    serializer_class = ContactSerializer
    permission_classes = [permissions.AllowAny]

    ordering_fields = ['name', 'email', 'phone']
    
    search_fields = ['name', 'email']
    
    def get_queryset(self):
        queryset = Contact.objects.all()
        search_term = self.request.query_params.get('search', None)
        if search_term:
            queryset = queryset.filter(name__icontains=search_term) | \
            queryset.filter(email__icontains=search_term)
            
        return queryset
    
class ContactRetrieveUpdateDestroyAPIView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Contact.objects.all()
    serializer_class = ContactSerializer
    permission_classes = [permissions.AllowAny]
    
    lookup_field = 'id'
    
    