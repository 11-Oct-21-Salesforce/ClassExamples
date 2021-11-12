import { LightningElement, track } from 'lwc';

export default class ChildLifecycleHookDemo extends LightningElement {
    numberOfHooksInvoked = 0;
    renderedCallbackInvokedPreviously = false;

    @track
    lifecycleHookMethodsInvoked = [];

    constructor() {
        super();
        this.numberOfHooksInvoked += 1;
        this.lifecycleHookMethodsInvoked.push('constructor() of ChildLifecycleHookDemo');
        console.log('constructor() of ChildLifecycleHookDemo');
    }

    connectedCallback() {
        this.numberOfHooksInvoked += 1;
        this.lifecycleHookMethodsInvoked.push('connectedCallback() of ChildLifecycleHookDemo');
        console.log('connectedCallback() of ChildLifecycleHookDemo');
    }

    renderedCallback() {
        if(!this.renderedCallbackInvokedPreviously) {
            this.numberOfHooksInvoked += 1;
            this.lifecycleHookMethodsInvoked.push('renderedCallback() of ChildLifecycleHookDemo');
            console.log('renderedCallback() of ChildLifecycleHookDemo');
            this.renderedCallbackInvokedPreviously = true;
        }
    }
}