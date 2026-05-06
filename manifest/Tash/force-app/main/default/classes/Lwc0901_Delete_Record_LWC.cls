public class Lwc0901_Delete_Record_LWC {
    
    @AuraEnabled(cacheable=false)
    public static String deleteAccount(String recordId) {
        TCS_Employee__c tcsEmpDelete =[SELECT ID FROM TCS_Employee__c WHERE ID=:recordId ][0];
        
        Delete tcsEmpDelete;
        
        return recordId;
    }
}