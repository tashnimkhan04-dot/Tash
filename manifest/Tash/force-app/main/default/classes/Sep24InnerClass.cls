public class Sep24InnerClass {
    public class PersonalInformation {
        public String studentRollNo;
        public PersonalInfo personalDetails;
    }

    public class PersonalInfo {
        public Name nameInfo;
        public Address addressInfo;  
        public Others otherInfo;  
    }

    public class Name {
        public String firstName;
        public String lastName;
    }

    public class Address {
        public String addressLine1;
        public String addressLine2;
        public String addressLine3;
    }

    public class Others {
        public Integer age;
        public String nationality;
    }

    // This method demonstrates assigning and accessing values for PersonalInformation class
    public void demonstrateInnerClassUsage() {
        ////////////////////////// Assigning Values //////////////////////////////////////////
        // Initialize Outer Class
        PersonalInformation personalInfo = new PersonalInformation();
         
        // Fill Name class details
        Name nameCls = new Name();
        nameCls.firstName = 'Arunkumar';
        nameCls.lastName = 'R';
         
        // Fill Address class details
        Address addressCls = new Address();
        addressCls.addressLine1 = 'Address 1';
        addressCls.addressLine2 = 'Address 2';
        addressCls.addressLine3 = 'Address 3';
         
        // Fill Others class details
        Others othersCls = new Others();
        othersCls.age = 25;
        othersCls.nationality = 'Indian';
         
        // Initialize the container class
        PersonalInfo personalInf = new PersonalInfo();
        personalInf.nameInfo = nameCls;
        personalInf.addressInfo = addressCls;
        personalInf.otherInfo = othersCls;
         
        // Assign values to the Outer class variables
        personalInfo.studentRollNo = 'LE30088';
        personalInfo.personalDetails = personalInf;
         
        System.debug('## Personal Info Class: ' + personalInfo);
         
        ////////////////////////// Accessing Values //////////////////////////////////////////
        // Accessing parent class Student Roll Number Value
        System.debug('Student Roll Number: ' + personalInfo.studentRollNo);
         
        // Accessing Name inner class details from the container class instance
        Name nameDetails = personalInfo.personalDetails.nameInfo;
        System.debug('First Name: ' + nameDetails.firstName);
        System.debug('Last Name: ' + nameDetails.lastName);
         
        // Accessing Address inner class details from the container class instance
        Address addressDetails = personalInfo.personalDetails.addressInfo;
        System.debug('Address Line 1: ' + addressDetails.addressLine1);
         
        // Accessing Others inner class details from the container class instance
        Others otherDetails = personalInfo.personalDetails.otherInfo;
        System.debug('Age: ' + otherDetails.age);
        System.debug('Nationality: ' + otherDetails.nationality);
    }
}