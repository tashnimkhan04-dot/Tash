import { LightningElement , api} from 'lwc';

export default class LWC_1912_Greatest_Number extends LightningElement {
    firstNumber;
    secondNumber;
    thirdNumber;
    greatestNumber;
    @api recordId;
    
    handleFirstNumberChange(event) {
        this.firstNumber = event.target.value;
    }  
    handleSecondNumberChange(event) {
        this.secondNumber = event.target.value;
    }

    handleThirdNumberChange(event) {
        this.thirdNumber = event.target.value
    }

    findGreatestNumber() {
        console.log('first number type:', typeof parseInt(this.firstNumber));
        
        if (parseInt(this.firstNumber) > parseInt(this.secondNumber) && parseInt(this.firstNumber) > parseInt(this.thirdNumber)) {
            this.greatestNumber = this.firstNumber;
        }
        else if (parseInt(this.secondNumber) > parseInt(this.firstNumber) && parseInt(this.secondNumber) > parseInt(this.thirdNumber)) {
            this.greatestNumber = this.secondNumber;
        }
        else {
            this.greatestNumber = parseInt(this.thirdNumber);
        }
        alert('Greatest Number is: ' + this.greatestNumber);



    }
}