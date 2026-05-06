import { LightningElement, api, wire} from 'lwc';
import { getRecord , getFieldValue} from 'lightning/uiRecordApi';

import Name_Field from '@salesforce/schema/Account.Name';
import Phone_Field from '@salesforce/schema/Account.Phone';
import Industry_Field from '@salesforce/schema/Account.Industry';

const FIELDS = [Name_Field,Phone_Field,Industry_Field];
    
export default class DiplayRecord extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;
    get name() {
        return getFieldValue(this.account?.data, Name_Field);
    }
    get phone() {
        return getFieldValue(this.account?.data, Phone_Field);
    }
    get industry() {
        return getFieldValue(this.account?.data, Industry_Field);
    }
}