// It's common to end the name of an Apex class that's serving as a Custom Controller for a Visualforce page with the suffix _CC
public class TransientDemo_CC {

    // When we don't assign an access modifier to a variable or method in a class, it defaults to private
    // We're defining two DateTime variables, with the second also being transient
	DateTime nonTransientVariable;
    transient DateTime transientVariable;
    
    // getter for nonTransientVariable
    public String getNonTransientVariable() {

        /* 
            lazy loading nonTransientVariable - it won't be instantiated until it's referenced. When it's referenced, the framework
            will invoke the getter. If it has yet to be instantiated, assign it the current date time retrieved from a call to
            System.now().
        */
        if(this.nonTransientVariable == null) {
            this.nonTransientVariable = System.now();
        }
        
        // Return nonTransientVariable as a string through string concatenation with an empty string
        return '' + this.nonTransientVariable;
    }
    
    /* 
        The getter for transientVariable is the same as the getter for nonTransientVariable. However, since transientVariable is
        transient, it's not included in the view state, so the framework reinstantiates it every time a server call is made.
    */
    public String getTransientVariable() {
        if(this.transientVariable == null) {
            this.transientVariable = System.now();
        }
        
        return '' + this.transientVariable;
    }
    
    // Method to action bind to our <apex:commandButton> to force a server call
    public void refresh(){}
}