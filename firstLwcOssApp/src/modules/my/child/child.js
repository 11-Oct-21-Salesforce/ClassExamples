import { LightningElement, api } from 'lwc';

export default class Child extends LightningElement {
    @api
    childPublicProperty;

    accessorPropertyValue;

    get publicAccessorProperty() {
        return this.accessorPropertyValue;
    }
    @api
    set publicAccessorProperty(value) {
        this.accessorPropertyValue = value;
    }
}