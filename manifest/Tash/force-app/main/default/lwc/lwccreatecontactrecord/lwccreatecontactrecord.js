import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CreateContact from '@salesforce/apex/lwcCreateContactRecord.createContact';
export default class Lwccreatecontactrecord extends LightningElement {
    firstName = '';
    lastName = '';
    email = '';

    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handleSave() {
        if (!this.firstName || !this.lastName) {
            this.ShowToastEvent('error', 'Error', 'First Name and Last Name are required.');
            return;
        }
        
        CreateContact({ firstName: this.firstName, lastName: this.lastName, email: this.email })
            .then(result => {
                this.ShowToastEvent('success', 'Success', 'Contact created successfully.');
                this.firstName = '';
                this.lastName = '';
                this.email = '';
            })
            .catch(error => {
                this.ShowToastEvent('error', 'Error', error.body.message);
            });
            ShowToastEvent(type, title, message); {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: type,
        });
        this.dispatchEvent(event);
        }   
   }
    
}