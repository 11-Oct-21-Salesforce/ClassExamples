import { LightningElement, wire } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getContacts from '@salesforce/apex/ContactService.getContacts';

import CONTACT_OBJECT from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class ContactDataTable extends LightningElement {
    data = [];
    columns = [
        {label: NAME_FIELD.fieldApiName, fieldName: NAME_FIELD.fieldApiName},
        {label: EMAIL_FIELD.fieldApiName, fieldName: EMAIL_FIELD.fieldApiName, type: 'email'},
        {label: PHONE_FIELD.fieldApiName, fieldName: PHONE_FIELD.fieldApiName, type: 'phone'}
    ];

    @wire(getContacts)
    populateTableData({error, data}) {
        if(data) {
            this.data = data;
        } else if(error) {
            const toastEvent = new ShowToastEvent({
                title: 'Error',
                message: error,
                variant: 'error'
            });

            this.dispatchEvent(toastEvent);
        }
    }
}