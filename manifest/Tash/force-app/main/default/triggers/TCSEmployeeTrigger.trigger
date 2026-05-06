trigger TCSEmployeeTrigger on TCS_Employee__c (before Insert, before delete,before Update, after Insert, after Update, after delete, after Undelete) {
    
    System.debug('isBefore Check :' +Trigger.isBefore);
    System.debug('isInsert Check :' +Trigger.isInsert);
    System.debug('isAfter Check :' +Trigger.isAfter);
    System.debug('isUpdate Check :' +Trigger.isUpdate);
	System.debug('isDelete Check :' +Trigger.isDelete);
    System.debug('isUnDelete Check :' +Trigger.isUnDelete);
    System.debug('isUnDelete Check :' +Trigger.isUnDelete);
    System.debug('isExecuting Check :' +Trigger.isExecuting);
	System.debug('Trigger.New List Check :' +Trigger.New);//List of new<sObjects>
    System.debug('Trigger.Old List Check :' +Trigger.Old);
    System.debug('Trigger.NewMap List Check :' +Trigger.NewMap);
	System.debug('Trigger.OldMap List Check :' +Trigger.OldMap);//Map<Id,sObject>


    if(Trigger.isBefore && Trigger.isInsert){
        TCSEmployeeExecuteTrigger__c orgDefaultLevel = 	TCSEmployeeExecuteTrigger__c.getOrgDefaults();
        
       
        system.debug('Custom Setting Value ' +orgDefaultLevel);
        
        TCSEmployeeExecuteTrigger__c profilAcess = 	TCSEmployeeExecuteTrigger__c.getInstance('005gK000004kQGXQA2');

        
        if(orgDefaultLevel.ExecuteTrigger__c || profilAcess.ExecuteTrigger__c) {
                    
           TCSEmployeeTriggerHandler.onBeforeInsertRec(Trigger.New);

        }
        
        
    	/*for (TCS_Employee__c t:Trigger.New){
        	t.Salary_Description__c = 'Here Before trigger has executed before Insert';
     	} */  
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        TCSEmployeeTriggerHandler.onBeforeUpdateRec(Trigger.New);
    	/*for (TCS_Employee__c t:Trigger.New){
        	t.Salary_Description__c = 'Here Before trigger has executed before update';
     	} */  
    }
    
    //After Insert/Update
    //When the Employee type field is changed, update tye childs employee type field value and in description field child record update both old and new employee type value
        if (Trigger.isAfter && Trigger.isInsert) {
            TCSEmployeeTriggerHandler.onAfterInsertRec(Trigger.New);
            
        /*List<TCS_Employee_Salary__c> empSalaryList = new List<TCS_Employee_Salary__c>();
        for (TCS_Employee__c t : Trigger.New) {
            TCS_Employee_Salary__c empSalary = new TCS_Employee_Salary__c();
            //empSalary.Employee_Type__c = 'Full Time Employee';
            empSalary.Salary__c = t.Salary__c;
            empSalary.TCS_Employee__c = t.Id;
            empSalaryList.add(empSalary);
        }                                              
        if (!empSalaryList.isEmpty()) {
            insert empSalaryList;
        }*/
      }      
    //after update
    //when the employee type field value is chnaged, update the child's employee type field value and in description field
    //on child update both old and new employee type field value.
  
    if (Trigger.isAfter && Trigger.isUpdate){
        TCSEmployeeTriggerHandler.onAfterUpdateRec(Trigger.New,Trigger.OldMap);
        
        /*set<Id>parentEmpList = new set<Id>();
        for(TCS_Employee__c t:Trigger.New){
            if(Trigger.OldMap.get(t.Id).Employee_Type__c != Trigger.NewMap.get(t.Id).Employee_Type__c){
                parentEmpList.add(t.Id);
            }
        }
        
        List<TCS_Employee_Salary__c> empSalList = [SELECT Id ,Employee_Type__c, TCS_Employee__c FROM TCS_Employee_Salary__c WHERE TCS_Employee__c  IN :parentEmpList];
        for(TCS_Employee_Salary__c empSal : empSalList ){
            empSal.Employee_Type__c = Trigger.NewMap.get(empSal.TCS_Employee__c).Employee_Type__c;
        }
        update empSalList;*/
          
    }
    
    //BeforeDelete
    if (Trigger.isBefore && Trigger.isDelete){
        TCSEmployeeTriggerHandler.onBeforeDeleteRec(Trigger.Old);
        /*for (TCS_Employee__c t:Trigger.Old){
            if (t.Salary__c != null){
               t.addError('Since the Salary Field is Not Null This Cannot Be Deleted');
                
            }
        }*/
        
    }
    //BeforeDelete
    /*if (Trigger.isBefore && Trigger.isDelete){
        for (TCS_Employee__c active : Trigger.old){
            if(active.isActive__c==True){
                active.addError('You cannot delete an active subscription.');
            }
        }
    }*/               
    if (Trigger.isAfter && Trigger.isDelete){
        TCSEmployeeTriggerHandler.onAfterDeleteRec(Trigger.old);
        /*Set<Id> recordIds = new Set <Id>();
        for(TCS_Employee__c tcsEmp : Trigger.old){
            recordIds.add(tcsEmp.Id);
        }
        SendEmailMessage.sendEmail('testpurpose@yopmail.com', 'Alert! Record got deleted', 'There are some record which has been deleted from this org' + recordIds + UserInfo.getName());*/
    }
    
    //AfterUndelete
    
    if(Trigger.isAfter && Trigger.isUnDelete){
        TCSEmployeeTriggerHandler.onAfterUnDeleteRec(Trigger.New);
        
        /*List<TCS_Employee__c> toUpdate = new List<TCS_Employee__c>();
        for (TCS_Employee__c rec : [SELECT Id FROM TCS_Employee__c WHERE ID IN : Trigger.New ALL ROWS]){
            rec.Salary_Description__c = 'The Record has been restored from Recycle Bin';
            toUpdate.add(rec);
        }
        
        if (toUpdate.size()>0){
            Update toUpdate;
        }*/
            
    }

}