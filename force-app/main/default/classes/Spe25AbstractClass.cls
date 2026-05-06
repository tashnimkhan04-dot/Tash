//parent class

public abstract class Spe25AbstractClass {
    
    public Spe25AbstractClass(){
        system.debug('default contructor');
    }
    
    public string firstName;
    public Integer age;
    
    public abstract void abstractMethod1(string firstName, Integer age);
    
    public abstract void implimentMethod();
    
        
}