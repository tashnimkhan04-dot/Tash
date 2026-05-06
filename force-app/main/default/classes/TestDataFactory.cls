public class TestDataFactory {
    
    public void createMultipleAccounts() {
        List<Account> accountsToInsert = new List<Account>();
        
        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();
            acc.Name = 'Account ' + i; 
            acc.Rating = 'Cold'; 
            acc.Industry = 'Energy';
            acc.Description = 'Description for Account ' + i;
            
            accountsToInsert.add(acc);
        }
        
        	insert accountsToInsert;
  	}
    
    public void createMultipleContacs(){
        List <contact> contactsToInsert = new List <contact>();
        
        for (integer i = 0; i<7; i++){
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'Contact' +i;
            con.Phone = '123456612' +i;
            con.Description = 'Description for Account' +i;
            
            contactsToInsert.add(con);
            
        }
        
       	    insert contactsToInsert;
    }
}