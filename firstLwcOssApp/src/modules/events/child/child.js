import { LightningElement } from 'lwc';

export default class EventChild extends LightningElement {
    handleButtonClick() {
        /*
            To communicate from a child component to a parent component, we fire a custom event
            from the child component and have the parent component handle it. We first 
            instantiate a CustomEvent object, passing the name of our event as an argument to the
            constructor.
        */
        let event = new CustomEvent("buttonclick");

        /*
            To fire our event, we call the dispatchEvent() method, passing the event as an
            argument.
        */
        this.dispatchEvent(event);
    }
}