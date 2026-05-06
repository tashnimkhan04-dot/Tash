@isTest
public class TCSEmployeeTriggerTestClass {
    
    @isTest
    Static void beforeInsertTest(){
        Test.StartTest();
        TCS_Employee__c tcsEmp = new TCS_Employee__c();
        tcsEmp.Name = 'Test 456';
        
        Insert tcsEmp;
        
        Test.StopTest();
    	
    }
    
    @isTest
    Static void beforeUpdateTest(){
        TCS_Employee__c tcsEmp = new TCS_Employee__c();
        tcsEmp.Name = 'Test 456';
        Insert tcsEmp;
        
        Test.StartTest();
        tcsEmp.Name = 'Test 234';
        tcsEmp.Employee_Type__c = 'Contract';
        Update tcsEmp;
                
        Test.StopTest();
    	
    }
    @isTest
	static void beforeDeleteTest() {
        TCS_Employee__c tcsEmp = new TCS_Employee__c();
        tcsEmp.Name = 'Test new';
        tcsEmp.Salary__c = 10000;
        insert tcsEmp;
        
        Test.startTest();
        tcsEmp.addError('Since the Salary Field is Not Null This Cannot Be Deleted--Trigger Handler');
        delete tcsEmp;
        Test.stopTest();
    }
     
   @isTest
    static void testOnAfterUnDeleteRec() {
        TCS_Employee__c tcsEmp = new TCS_Employee__c(Name = 'Test Emp');
        insert tcsEmp;
        delete tcsEmp;

        Test.startTest();
        undelete tcsEmp;
        Test.stopTest();
    }
}