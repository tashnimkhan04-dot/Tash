public class Sep25DMLClass {
    
    public static void updateAccount(string accName){
        Account AccToUpdate = [SELECT Id,Name From Account WHERE Account.Name=:accName LIMIT 1];
        AccToUpdate.Name = AccToUpdate.Name + ' New';
        AccToUpdate.Phone = '234567876543';
        Update AccToUpdate;

    }
    
    Public static void AccToDelete(String accName){
        Account AccToDelete = [SELECT Id,Name From Account WHERE Account.Name=:accName LIMIT 1];
		DELETE AccToDelete;

    }
    
        Public static void AccToUndelete(String accName){
          Account AccToUndelete = [SELECT Id,Name From Account WHERE Account.Name=:accName LIMIT 1 ALL ROWS];
		  UNDELETE AccToUndelete;
            
    }
    
    
    	public static void updateContact(String conName) {
          Contact conToUpdate = [SELECT Id, Name, LastName FROM Contact WHERE Name =:conName LIMIT 1];
          conToUpdate.LastName = conToUpdate.LastName + ' New';
          conToUpdate.Email = 'tash@gmail.com';
          update conToUpdate;
    }
    
    
        public static void contactToDelete(String conName) {
            Contact conToDelete = [SELECT Id, Name, LastName FROM Contact WHERE Name = :conName  LIMIT 1];
            delete conToDelete;
    }

  
                

        
}