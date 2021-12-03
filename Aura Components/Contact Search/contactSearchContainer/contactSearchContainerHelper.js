({
	doInit : function(component) {
		let getParentAccounts = component.get("c.getParentAccounts");
        
        getParentAccounts.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                component.set("v.accNames", response.getReturnValue());
            } else {
                this.handleError(response.getError()[0]);
            }
        });
        
        $A.enqueueAction(getParentAccounts);
        
       	component.set("v.tableColumns", [
            {label: 'Name', fieldName: 'Name'},
            {label: 'Account Name', fieldName: 'AccountName'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Email', fieldName: 'Email', type: 'email'}
        ]);
	},
    
    handleError : function(errorMessage) {
        if($A.get("e.force:showToast")) {
            let showToast = $A.get("e.force:showToast");
            showToast.setParams({
                "message": errorMessage,
                "type": "error",
                "title": "Something Went Wrong"
            });
            showToast.fire();
        }
    },
    
    handleSelectChange : function(component, event) {
        component.set("v.accName", event.getParam("newSelectValue"));
    },
    
    handleSearchInputChange : function(component, event) {
        component.set("v.contactName", event.getParam("newSearchInput"));
    },
    
    contactSearch : function(component) {
        let searchForContacts = component.get("c.searchForContacts");
        
        searchForContacts.setParams({
            "accName" : component.get("v.accName"),
            "contactName": component.get("v.contactName")
        });
        
        searchForContacts.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                let searchResults = response.getReturnValue();
                
                for(let result of searchResults) {
                    if(result.Account) {
                        result.AccountName = result.Account.Name;
                    }
                }
                
                component.set("v.tableData", searchResults);
                
                if(!component.get("v.displayTable")) {
                    component.set("v.displayTable", true);
                }
            } else {
                this.handleError(response.getError()[0]);
            }
        });
        
        $A.enqueueAction(searchForContacts);
    }
})