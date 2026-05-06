@isTest
public class CalculatorTest {
    
    @isTest
    private static void addTest(){
        
        Test.startTest();
        Calculator.Add(5,6);
        Test.stopTest();
        
        }
    
    @isTest
    private static void subTest(){
        
		Test.startTest();
        Calculator.subs(12345,634567);
        Test.stopTest();
        
    }
        

}