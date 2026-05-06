public class AsyncApexFuture {
    
    @Future
    public static void myFutureMethod1(Id AccountId){
        Account acc1 = [SELECT Id, Name FROM Account WHERE ID =:AccountId LIMIT 1];
        acc1.Description = acc1.Name;
        acc1.Name = 'Test Acc12 - Future';
        Update acc1;
        
        
    }
    
    @Future
    public static void TCSEmpFutureMethod(Id EmpId){
        TCS_Employee__c newEmp = [SELECT Id,Name FROM TCS_Employee__c WHERE ID =:EmpId LIMIT 1];
        newEmp.Salary_Description__c = newEmp.Name;
        newEmp.Name = 'Future Method 1';
        Update newEmp;
        

    }

}