public with sharing class lwcCreateContactRecord {
    @AuraEnabled(Cacheable=true)
    public static Contact createContact (string firstName , string lastName, string email){
        Contact con = New Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = email
            
        );
            Insert con;
            Return con;
          
    }

}