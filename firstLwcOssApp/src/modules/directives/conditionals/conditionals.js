import { LightningElement } from 'lwc';

export default class Conditionals extends LightningElement {
    // When creating fields in our JS classes, we don't need to declare them with one of the three scope-enforcing keywords.
    displayMarkup = true;

    /* 
        the changeDisplay() event listener changes the value of the displayMarkup to the opposite Boolean (i.e. it changes true to
        false and false to true)
    */
    changeDisplay() {
        this.displayMarkup = !this.displayMarkup;
    }
}