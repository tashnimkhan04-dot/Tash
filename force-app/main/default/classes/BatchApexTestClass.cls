@isTest
public class BatchApexTestClass {
        @isTest 
        static void testBatch() {
        Account acc = new Account(Name = 'Test Account', Description = 'Test Desc');
        insert acc;
        
        Test.startTest();
        AsyncBatchApexAccountUpdate b = new AsyncBatchApexAccountUpdate();
        Database.executeBatch(b);
        Test.stopTest();
        
        acc = [SELECT Description FROM Account WHERE Id = :acc.Id];
        System.debug(null, acc.Description);
    }

}