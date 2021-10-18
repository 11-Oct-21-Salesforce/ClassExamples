/*
    To publicly expose a property or method to a parent component, we use the api decorator. To
    use this decorator, we import it from the lwc core module.
*/
import { LightningElement, api } from 'lwc';

export default class Child extends LightningElement {
    /*
        To use a decorator, we use the @ symbol followed by the name of the decorator before the
        property or method we're applying it to.

        The api decorator is exposing the childPublicProperty property so that it's value
        can be set by the parent.
    */
    @api
    childPublicProperty;

    accessorPropertyValue;

    /*
        Accessor properties have getter and setter methods, where the name of the method is
        preceded by the get and set keywords, respectively.

        Getter methods should take no arguments and return the value of the property.
 
        Setter methods should take a single argument (the value to assign to the property)
        and return no values.

        We can apply the api decorator to either the getter or setter to expose them to
        parent components, but not both.

        Accessor properties allow us to implement encapsulation, controlling the ways in which
        parent components can access and assign to publicly exposed properties.
    */
    get publicAccessorProperty() {
        return this.accessorPropertyValue;
    }
    @api
    set publicAccessorProperty(value) {
        this.accessorPropertyValue = value;
    }
}