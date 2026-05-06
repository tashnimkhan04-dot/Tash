public class Sep25MyFirstApexClass {
    
    
       String descriptionOfEveryRecords = 'This is my test creation of record';
          
    public void createAccount(){
        Account acc = new Account();
        acc.Name = 'Sample Account2';
        acc.Rating = 'Cold';
        acc.Industry = 'Energy';
        acc.Description = 'Hi,There!';
        Insert acc;    
    }

    public void TCSEmployee(){
        TCS_Employee__c newEmployee = new TCS_Employee__c();
        newEmployee.Name='Tash';
        newEmployee.Confidential_ID__c = '123456';
        newEmployee.Skills__c = 'SQL ; Java ; Salesforce';
        newEmployee.Salary__c = 2500;
        newEmployee.Employee_Location__Latitude__s = 12.9716;
        newEmployee.Employee_Location__Longitude__s = 77.5946;
        Insert newEmployee;
 
    }
    
    public void createContact(string firstName, string lastName, string Email){
        Contact cont = new Contact();
        cont.FirstName = firstName;
        cont.LastName = lastName;
        cont.Email = Email;
        cont.Description = descriptionOfEveryRecords;
        Insert cont;
        
    }
    
    public static void createConcert(){
        Concert__c newConcert = new Concert__c();
        newConcert.Name = 'Shreya Ghoshal';
        newConcert.Place__c = 'Mumbai';
        newConcert.Date_of_the_Concert__c = Date.newInstance(2025, 3, 12);
        system.debug (newConcert);
        insert newConcert;
    }

}