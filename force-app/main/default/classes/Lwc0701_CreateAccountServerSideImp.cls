public class Lwc0701_CreateAccountServerSideImp {
    
    @auraEnabled
    public static void createAccount(String Name, String Rating , String Industry){
        Account acc = new Account();
        acc.Name = Name;
        acc.Rating = Rating;
        acc.Industry = Industry;
        
        Insert acc;
        
        
    }

}