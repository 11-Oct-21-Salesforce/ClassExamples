import { LightningElement } from 'lwc';

export default class EventParent extends LightningElement {
    numberOfEvents = 0;

    /*
        Event listener to increment the number of handled events. Because we action bound this
        method to the onbuttonclick attribute of the child component in our markup, this method
        is invoked when the child component fires the buttonclick event.
    */
    handleButtonClick() {
        this.numberOfEvents += 1;
    }
}