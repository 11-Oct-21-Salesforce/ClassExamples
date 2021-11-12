import { LightningElement, api } from 'lwc';

export default class ObjectSelect extends LightningElement {
    @api chosenObject;
    @api objectOptions;

    handleComboChange(event) {
        const objectSelected = new CustomEvent(
            'objectselected',
            {detail: event.detail.value}
        );

        this.dispatchEvent(objectSelected);
    }
}