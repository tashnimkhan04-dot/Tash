@isTest
public class Sep25MyFirstApexClassTest {
    
    @isTest
    private static void createAccountTest(){
        
        Test.startTest();
        Sep25MyFirstApexClass acc = new Sep25MyFirstApexClass();
        acc.createAccount();
        Test.stopTest();
    }
    
    @isTest
    
    private static void TCSEmployeeTest(){
        
        Test.startTest();
        Sep25MyFirstApexClass emp = new Sep25MyFirstApexClass();
        emp.TCSEmployee();
        Test.stopTest();
            
        }
    
    testMethod static void accList(){
        List<account> accLists = new List <account>();
       integer listSize = accLists.size();
        system.debug('list Size' +listSize);
            
   
    }

}