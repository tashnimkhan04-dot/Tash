public class MyClass {
    public static void processUserInput(String name, Integer age) {
        System.debug('User Name: ' + name);
        System.debug('User Age: ' + age);
    }


    public void processUserInput1(String name, Integer age) {
    	System.debug('User Name: ' + name);
        System.debug('User Age: ' + age);
    }
    
    public static void userNumber(Integer Num1, Integer Num2){
        System.debug('Sum: ' + Num1 + Num2);
    }
    
    public static Integer userNumber1(Integer Num1, Integer Num2){
        return Num1 + Num2;
    }
    
}