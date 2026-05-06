public with sharing class ListOfAccountsLWC {
    @AuraEnabled(cacheable=true)
        public static List<Account>getAccounts(){
           List <Account> accounts = [SELECT Id, Name, Industry FROM Account LIMIT 10];
            System.debug ('Accounts Fetched:' + accounts.size());
            return accounts;
            
                
        }

}