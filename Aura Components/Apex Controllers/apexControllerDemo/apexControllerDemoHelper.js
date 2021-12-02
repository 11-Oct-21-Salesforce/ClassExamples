({
     // this function calls our Apex controller function that returns a list of the Ids of all open cases
	doInit : function(component) {
                
        /* here, we grab the getOpenCases method from our Apex controller
        because we're in the JS controller, the c value provider refers to the Apex controller
        since we declare the Apex controller in the view, we use the component.get() method to find it
        so our code is telling the system "retrieve the Apex method named getOpenCases, you can find it in the
        Apex class for our component, which we declared in the component file" */
		let action = component.get("c.getOpenCases");

                
        /* since getOpenCases doesn't have any parameters, we skip to setting the callback function

        a callback function is a function that's executed after another function returns

        here, we're saying "after this (which refers to the variable holding the getOpenCases Apex
        method reference) function returns, execute this callback function" */
        action.setCallback(this, function(response) {
            /* our server response contains a single JSON object, which we'll parse here
            the getState() method returns the state of the request, here we're checking for a successful request 
            */
            if(response.getState() === 'SUCCESS') {
                /* if our request was successful, we want to assign the returned list of Ids to our cases attribute
                in the view by using the getReturnValue() method

                the return value is simply the value that gets returned by our return statement in our Apex method
                */
                component.set("v.caseIds", response.getReturnValue());
            }
        });
        
        /* the last step is to enqueue the action
        
        if we don't enqueue it, it'll never make the call because we 
        haven't told it to do that before this point

        once our asynchronous server call is executed and returns, the callback function we defined with 
        the setCallback() method will execute */
        $A.enqueueAction(action);
	}
})