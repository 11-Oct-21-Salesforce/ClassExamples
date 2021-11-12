import { LightningElement, wire } from 'lwc';

import PERSONDATATABLECHANNEL from '@salesforce/messageChannel/PersonDataTableChannel__c';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';

export default class PersonRecordForm extends LightningElement {
    objectApiName;
    recordId;
    displayForm;
    subscription;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscription = subscribe(this.messageContext, PERSONDATATABLECHANNEL, (message) => this.handleRecordSelected(message));
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
    }

    handleRecordSelected(message) {
        this.objectApiName = message.chosenObject;
        this.recordId = message.chosenRecord;
        this.displayForm = true;
    }
}