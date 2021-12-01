import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class Main extends LightningElement {

    search;

    @wire(getAccounts, { searchString : '$search' } )
    acc;

    handleChange(event) {

        this.search = event.target.value;
    }
}