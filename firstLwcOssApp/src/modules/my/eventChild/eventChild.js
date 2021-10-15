import { LightningElement } from 'lwc';

export default class EventChild extends LightningElement {
    handleButtonClick() {
        let event = new CustomEvent("buttonclick");
        this.dispatchEvent(event);
    }
}