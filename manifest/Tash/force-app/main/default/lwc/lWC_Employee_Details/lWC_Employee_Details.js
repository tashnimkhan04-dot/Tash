import { LightningElement } from 'lwc';

export default class LWC_Employee_Details extends LightningElement {
    employeeName;
    employeeAge;
    Currency;
    employeeSalary;
    employeeName1;
    employeeAge1;
    Currency1;
    employeeSalary1;

    handleEmployeeNameChange(event) {
        this.employeeName = event.target.value;
    }  
    handleEmployeeAgeChange(event) {
        this.employeeAge = event.target.value;
    }

    handleEmployeeCurrencyChange(event) {
        this.Currency = event.target.value;
    }

    handleEmployeeSalaryChange(event) {
        const temp = (event.target.value);
        if(this.Currency == 'EUR') {
            this.employeeSalary = parseFloat(temp).toLocaleString('de-DE', {
                style: 'currency',
                currency: 'EUR'
            });
    
        } else if(this.Currency == 'INR') {
            this.employeeSalary = parseFloat(temp).toLocaleString('en-IN', {
                style: 'currency',
                currency: 'INR'
            });
        } else {
            this.employeeSalary = parseFloat(temp).toLocaleString('en-US', {
                style: 'currency',
                currency: 'USD'
           });
        }

    }

    saveEmployeeDetails() {
        this.employeeName1 = this.employeeName;
        this.employeeAge1 = this.employeeAge;
        this.Currency1 = this.Currency;
        this.employeeSalary1 = this.employeeSalary;
        
        console.log('Employee Name: ', this.employeeName);
        console.log('Employee Age: ', typeof parseInt(this.employeeAge));
        console.log('Employee Salary:  ', typeof parseFloat(this.employeeSalary));
    }  
}