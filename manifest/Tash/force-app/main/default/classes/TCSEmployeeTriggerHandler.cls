public class TCSEmployeeTriggerHandler {
    //Before Insert
    public Static void onBeforeInsertRec(List<TCS_Employee__c> newList){
        for(TCS_Employee__c t: newList){
            t.Salary_Description__c = 'Here Before trigger has executed before Insert-Trigger Handler';
        }
    }
    
   //Before Update
    public Static void onBeforeUpdateRec(List<TCS_Employee__c> newList){
        for(TCS_Employee__c t: newList){
            t.Salary_Description__c = 'Here Before trigger has executed before update-Trigger Handler';

        }

    }
    //AfterInsert
    public Static void onAfterInsertRec(List<TCS_Employee__c> newList){
        List<TCS_Employee_Salary__c> empSalaryList = new List<TCS_Employee_Salary__c>();
        for (TCS_Employee__c t : newList) {
            TCS_Employee_Salary__c empSalary = new TCS_Employee_Salary__c();
            //empSalary.Employee_Type__c = 'Full Time Employee';
            empSalary.Salary__c = t.Salary__c;
            empSalary.TCS_Employee__c = t.Id;
            empSalaryList.add(empSalary);
        }                                              
        if (!empSalaryList.isEmpty()) {
            insert empSalaryList;
        }
    }
    //AfterUpdate
    public Static void onAfterUpdateRec(List<TCS_Employee__c> newList, Map<Id, TCS_Employee__c> oldMap){
        set<Id>parentEmpList = new set<Id>();
        for(TCS_Employee__c t:newList){
            if(OldMap.get(t.Id).Employee_Type__c != t.Employee_Type__c){
                parentEmpList.add(t.Id);
            }
        }
        
        Map<Id, TCS_Employee__c> newListMap = new Map<Id, TCS_Employee__c>(newList);
        List<TCS_Employee_Salary__c> empSalList = [SELECT Id ,Employee_Type__c, TCS_Employee__c FROM TCS_Employee_Salary__c WHERE TCS_Employee__c  IN :parentEmpList];
        for(TCS_Employee_Salary__c empSal : empSalList ){
            empSal.Employee_Type__c = newListMap.get(empSal.TCS_Employee__c).Employee_Type__c;
        }
        update empSalList;
          
        
    }
    
    //BeforeDelete
    public Static void onBeforeDeleteRec(List<TCS_Employee__c> newList){
        for (TCS_Employee__c t: newList){
            if (t.Salary__c != null){
               t.addError('Since the Salary Field is Not Null This Cannot Be Deleted--Trigger Handler');
                
            }
        }
    }
    
    //AfterDelete
    public Static void onAfterDeleteRec(List<TCS_Employee__c> newList){
        Set<Id> recordIds = new Set <Id>();
        for(TCS_Employee__c tcsEmp : newList){
            recordIds.add(tcsEmp.Id);
        }
        SendEmailMessage.sendEmail('testpurpose@yopmail.com', 'Alert! Record got deleted', 'There are some record which has been deleted from this org' + recordIds + UserInfo.getName());
    }
    
    //AfterUndelete
    public Static void onAfterUnDeleteRec(List<TCS_Employee__c> newList){
        List<TCS_Employee__c> toUpdate = new List<TCS_Employee__c>();
        for (TCS_Employee__c rec : [SELECT Id FROM TCS_Employee__c WHERE ID IN : Trigger.New ALL ROWS]){
            rec.Salary_Description__c = 'The Record has been restored from Recycle Bin--Trigger Handler';
            toUpdate.add(rec);
        }
        
        if (toUpdate.size()>0){
            Update toUpdate;
        }
     }

}