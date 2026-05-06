import { LightningElement , api} from 'lwc';
import DeleteRecord from '@salesforce/apex/Lwc0901_Delete_Record_LWC.deleteAccount';

export default class Lwc0901_DeleteRecord extends LightningElement {
    @api recordId;

    deleteRecord() {
        DeleteRecord({ recordId: this.recordId })
            .then(() => {
                alert('Record Deleted Successfully!');
            })
            .catch((error) => {
                alert('Error in deleting record: ' + error.body.message);
            });

    }
}