import { LightningElement } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import SOURCE_FIELD from '@salesforce/schema/Account.AccountSource';

export default class RecordFormDemo extends LightningElement {
    objectName = ACCOUNT_NAME;
    fields = [NAME_FIELD, INDUSTRY_FIELD, SOURCE_FIELD];
}