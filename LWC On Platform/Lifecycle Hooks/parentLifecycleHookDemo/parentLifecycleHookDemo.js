import { LightningElement, track } from 'lwc';

export default class ParentLifecycleHookDemo extends LightningElement {
    numberOfHooksInvoked = 0;
    renderedCallbackInvokedPreviously = false;

    @track 
    lifecycleHookMethodsInvoked = [];

    constructor() {
        super();
        this.numberOfHooksInvoked += 1;
        this.lifecycleHookMethodsInvoked.push('constructor() of ParentLifecycleHookDemo');
        console.log('constructor() of ParentLifecycleHookDemo');
    }

    connectedCallback() {
        this.numberOfHooksInvoked += 1;
        this.lifecycleHookMethodsInvoked.push('connectedCallback() of ParentLifecycleHookDemo');
        console.log('connectedCallback() of ParentLifecycleHookDemo');
    }

    renderedCallback() {
        if(!this.renderedCallbackInvokedPreviously) {
            this.numberOfHooksInvoked += 1;
            this.lifecycleHookMethodsInvoked.push('renderedCallback() of ParentLifecycleHookDemo');
            console.log('renderedCallback() of ParentLifecycleHookDemo');
            this.renderedCallbackInvokedPreviously = true;
        }
    }

    handleHookMethodEvent(event) {
        this.numberOfHooksInvoked += 1;
        this.lifecycleHookMethodsInvoked.push(event.detail);
    }
}