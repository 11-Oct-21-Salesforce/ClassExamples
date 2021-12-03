({
	handleSelectChange : function(component) {
		let selectChange = component.getEvent("selectChange");
        
        selectChange.setParams({
            "newSelectValue" : component.get("v.selectValue")
        });
        
        selectChange.fire();
	},
    
    handleSearchInput : function(component) {
        let searchInputChange = component.getEvent("searchInputChange");
        
        searchInputChange.setParams({
            "newSearchInput" : component.get("v.searchInput")
        });
        
        searchInputChange.fire();
    }
})