public class Sep25AbstractChildClass extends Spe25AbstractClass{
    
    //public Sep25AbstractChildClass(){
   //     system.debug('default Constructor');
  //  }
    
    string userName;
    
    public Sep25AbstractChildClass(string myName){
        system.debug ('Name: ' + myName);
        userName = myName;
        
    }
  
    
    public override void abstractMethod1(string firstName, Integer age){
        this.firstName = firstName;
        this.age = age;
    }
    
    public override void implimentMethod(){
        system.debug('name' + userName);
                
    }

}