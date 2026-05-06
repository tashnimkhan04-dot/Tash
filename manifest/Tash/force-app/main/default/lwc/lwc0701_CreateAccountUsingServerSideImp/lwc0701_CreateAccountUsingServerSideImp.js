import { LightningElement } from 'lwc';
import createAccountOnServer from '@salesforce/apex/Lwc0701_CreateAccountServerSideImp.createAccount';

export default class Lwc0701_CreateAccountUsingServerSideImp extends LightningElement {
    accName = '';
    accRating = '';
    accIndustry = '';

    handleAccountNameChange(event) {
        this.accName = event.target.value;
    }

    handleAccountRatingChange(event) {
        this.accRating = event.target.value;
    }

    handleAccountIndustryChange(event) {
        this.accIndustry = event.target.value;
    }
    
    createAccount() {
        console.log('Account Name: ' + this.accName);
        console.log('Account Rating: ' + this.accRating);
        console.log('Account Industry: ' + this.accIndustry);
        createAccountOnServer({ Name: this.accName, Rating: this.accRating, Industry: this.accIndustry })
            .then()
            .catch();
            
    }

}