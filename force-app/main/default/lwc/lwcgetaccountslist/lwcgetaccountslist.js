import { LightningElement , wire } from 'lwc';
import getAccounts from '@salesforce/apex/ListOfAccountsLWC.getAccounts';

export default class Lwcgetaccountslist extends LightningElement {
    accounts;
    error;


    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }
    
    
}