@isTest
public class AsyncFutureTestClass {
    @isTest
    static void myFutureMethod1() {
        Account acc = new Account(Name = 'FutureTestAcc');
        insert acc;
        
        Test.startTest();
        AsyncApexFuture.myFutureMethod1(acc.Id);
        Test.stopTest();
    }


}