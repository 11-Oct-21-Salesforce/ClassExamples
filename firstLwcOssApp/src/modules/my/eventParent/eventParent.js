import { LightningElement } from 'lwc';

export default class EventParent extends LightningElement {
    numberOfEvents = 0;

    handleButtonClick() {
        this.numberOfEvents += 1;
    }
}