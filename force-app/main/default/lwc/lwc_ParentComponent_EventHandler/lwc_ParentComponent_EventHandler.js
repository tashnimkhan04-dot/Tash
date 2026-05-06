import { LightningElement, track } from 'lwc';

export default class Lwc_ParentComponent_EventHandler extends LightningElement {
   @track messageFromChild = '';

    handleChildEvent(event) {
        this.messageFromChild = 'Message: ' + event.detail.message + ' | Name: ' + event.detail.name + ' | ID: ' + event.detail.id;
        console.log('Event received from child component:', this.messageFromChild);
    }
}