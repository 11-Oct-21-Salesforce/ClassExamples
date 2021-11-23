import { LightningElement, wire, api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getRecords from '@salesforce/apex/RecordService.getRecords';

import CONTACT_NAME_FIELD from '@salesforce/schema/Contact.Name';
import CONTACT_EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import CONTACT_PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import LEAD_NAME_FIELD from '@salesforce/schema/Lead.Name';
import LEAD_EMAIL_FIELD from '@salesforce/schema/Lead.Email';
import LEAD_PHONE_FIELD from '@salesforce/schema/Lead.Phone';

import PERSONDATATABLECHANNEL from '@salesforce/messageChannel/PersonDataTableChannel__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class ContactDataTable extends LightningElement {
    data = [];
    columns = [];
    @api chosenObject;
    displayTable;
    leadColumns = [
        {label: LEAD_NAME_FIELD.fieldApiName, fieldName: LEAD_NAME_FIELD.fieldApiName},
        {label: LEAD_EMAIL_FIELD.fieldApiName, fieldName: LEAD_EMAIL_FIELD.fieldApiName, type: 'email'},
        {label: LEAD_PHONE_FIELD.fieldApiName, fieldName: LEAD_PHONE_FIELD.fieldApiName, type: 'phone'}
    ];
    contactColumns = [
        {label: CONTACT_NAME_FIELD.fieldApiName, fieldName: CONTACT_NAME_FIELD.fieldApiName},
        {label: CONTACT_EMAIL_FIELD.fieldApiName, fieldName: CONTACT_EMAIL_FIELD.fieldApiName, type: 'email'},
        {label: CONTACT_PHONE_FIELD.fieldApiName, fieldName: CONTACT_PHONE_FIELD.fieldApiName, type: 'phone'}
    ];

    @wire(MessageContext)
    messageContext;

    @wire(getRecords, {objectToQuery: '$chosenObject'})
    populateTableData({error, data}) {
        if(data) {
            this.data = data;
            console.log(JSON.parse(JSON.stringify(data)));
            if(this.chosenObject === 'Contact') {
                this.columns = this.contactColumns;
            } else if(this.chosenObject === 'Lead') {
                this.columns = this.leadColumns;
            }

            this.template.querySelector('lightning-datatable').selectedRows = [];

            if(!this.displayTable) {
                this.displayTable = true;
            }
        } else if(error) {
            const toastEvent = new ShowToastEvent({
                title: 'Error',
                message: error,
                variant: 'error'
            });

            this.dispatchEvent(toastEvent);
        }
    }

    handleRowSelection(event) {
        let selectedRows = event.detail.selectedRows;
        if(selectedRows[0]) {
            
            const message = {
                chosenObject: this.chosenObject,
                chosenRecord: event.detail.selectedRows[0].Id,
            }

            publish(this.messageContext, PERSONDATATABLECHANNEL, message);
        }
    }
}