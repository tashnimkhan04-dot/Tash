import { LightningElement } from 'lwc';

export default class LWC_Variables extends LightningElement {
    myString;
    handleInputChange(event) {
        this.myString = event.target.value;
    }
}