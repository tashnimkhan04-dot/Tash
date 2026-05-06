public class Lwc_2312_GetAccounts {
    
    @auraEnabled(Cacheable = true)
    public static List<Account> getSomeAccounts(){
        
        List<Account>accList = [SELECT id, Name, Phone, Industry From Account LIMIT 10];
        return accList;
    }

}