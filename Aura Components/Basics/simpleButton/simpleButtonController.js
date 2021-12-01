({
   	/*
   		here's our controller file, it has the name of our component file followed by Controller.js

		the file is a JS object literal with symbols for keys and anonymous functions for values

		our functions take three parameters: the component, the event, and a reference to our helper file
			when the system invokes our action handlers (e.g. the show function), it automatically populates those
			values
    */
	handleClick : function(component, event, helper) {
       	/* 
       		we can use component.set() to change the value of an <aura:attribute>
				the first parameter of this method is the same as for component.get(), the second parameter is the new
				value to give to the attribute
        */
		component.set("v.buttonMessage", "that hurts");
	}
})