import { LightningElement, wire } from 'lwc';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import CLOSE_DATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';

export default class OpportunityFormWithFLS extends LightningElement {
    objectApiName = OPPORTUNITY_OBJECT;
    fields = [];
    flsChecked;
    fieldsToCheck = [NAME_FIELD, CLOSE_DATE_FIELD, STAGE_FIELD, AMOUNT_FIELD];

    @wire(getObjectInfo, {objectApiName : OPPORTUNITY_OBJECT})
    checkFieldLevelSecurity({error, data}) {
        if(data) {
            let describedFields = data.fields;
            for(let fieldToCheck of this.fieldsToCheck) {
                if(describedFields[fieldToCheck.fieldApiName].createable) {
                    this.fields.push(fieldToCheck);
                }
            }

            this.flsChecked = true;
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