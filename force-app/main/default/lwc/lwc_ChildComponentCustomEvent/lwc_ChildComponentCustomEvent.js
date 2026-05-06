import { LightningElement } from 'lwc';

export default class lwc_ChildComponentCustomEvent extends LightningElement {
    employeeName = 'Tashnim Kausar';
    employeeId = 'EMP123';

    handleClick() {
        const customEvent = new CustomEvent("selected", {
            detail: {
                message: "LWC Component message from Child Component",
                name: this.employeeName,
                id: this.employeeId
            }
        });
        this.dispatchEvent(customEvent);
    }
}