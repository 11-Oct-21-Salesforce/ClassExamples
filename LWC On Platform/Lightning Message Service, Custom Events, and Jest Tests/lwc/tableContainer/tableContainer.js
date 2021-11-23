import { LightningElement } from 'lwc';

import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LEAD_OBJECT from '@salesforce/schema/Lead';

export default class TableContainer extends LightningElement {
    chosenObject = CONTACT_OBJECT.objectApiName;
    objectOptions = [
        {label: CONTACT_OBJECT.objectApiName, value: CONTACT_OBJECT.objectApiName},
        {label: LEAD_OBJECT.objectApiName, value: LEAD_OBJECT.objectApiName}
    ];

    handleObjectSelected(event) {
        this.chosenObject = event.detail;
    }
}