public with sharing class ListOfAccountsLWC {
    @AuraEnabled(cacheable=true)
        public static list<account>getAcconts(){
            return[SELECT id, Name, Industry FROM Account LIMIT 10];
        }

}