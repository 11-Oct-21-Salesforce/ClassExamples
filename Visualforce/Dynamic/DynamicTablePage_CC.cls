public class DynamicTablePage_CC {

    /*
        Property for controlling whether the <apex:pageBlockTable> is rendered. Because it is a property, the framework 
        automatically invokes the getter when we data bind to an output component with the expression {!renderTable} and it
        automatically invokes the setter when we data bind to an output component with the same expression syntax.
    */
    public Boolean renderTable {
        get {
            if(renderTable == null) {
                renderTable = false;
            }
            return renderTable;
        }
        set;
    }
    
    // Property for storing the chosen radio button value
    public String selectedObject {
        get {
            if(selectedObject != null) {
                renderTable = true;
            }
            return selectedObject;
        }
        set;
    }
    
    // Property holding a list of opportunities
    public List<Opportunity> opps {
        get {
            if(opps == null) {
                opps = [SELECT Name, StageName, Amount, CloseDate FROM Opportunity];
            }
            return opps;
        }
        private set;
    }
    
    // Property holding a list of leads
    public List<Lead> leads {
        get {
            if(leads == null) {
                leads = [SELECT Name, Status, Email FROM Lead];
            }
            return leads;
        }
        private set;
    }
    
    // Lists to hold the names of fields we want to include as columns in our <apex:pageBlockTable>
    List<String> oppFields;
    List<String> leadFields;
    
    public DynamicTablePage_CC() {
        /*
            Populate oppFields and leadFields with the names of the fields selected in the SOQL queries on opportunity and lead, 
            respectively
        */
        oppFields = new List<String>();
        oppFields.add('Name');
        oppFields.add('StageName');
        oppFields.add('Amount');
        oppFields.add('CloseDate');
        
        leadFields = new List<String>();
        leadFields.add('Name');
        leadFields.add('Status');
        leadFields.add('Email');
    }
    
    /* 
        Each standard Visualforce component is represented by a corresponding Apex subclass of the Component class in the class in 
        the ApexPages namespace. The class for a given component follows the naming format 
        Component.ComponentNamespace.ComponentName

        Our data bound method (referenced with the expression syntax {!table}) returns an instance of one of these subclasses, in
        this case the class corresponding to the <apex:pageBlockTable> standard component.
    */
    public Component.Apex.PageBlockTable getTable() {
        // instantiate the class
        Component.Apex.PageBlockTable pageBlockTable = new Component.Apex.PageBlockTable();
        
        // list to hold the names of the columns of the table
        List<String> tableColumns = new List<String>();
        
        /*
            Check for the value of selectedObject (the value of the chosen radio button). If the user chose Opportunity, assign 
            oppFields to the tableColumns list and the list of opportunities to the value attribute. If the user chose Lead, assign 
            leadFields to the tableColumns list and the list of leads to the value attribute.
        */
        if(this.selectedObject == 'Opportunity') {
            /*
                To use expression syntax in an attribute value for a component instantiated in Apex, we use dot notation with
                the expressions property followed by the name of the attribute.
            */
            pageBlockTable.expressions.value = '{!opps}';
            tableColumns = this.oppFields;
        } else if(this.selectedObject == 'Lead') {
            pageBlockTable.expressions.value = '{!leads}';
            tableColumns = this.leadFields;
        } else {
            return null;
        }
		
        // Assign record as the value for the var attribute of the <apex:pageBlockTable>
        pageBlockTable.var = 'record';
        
        // Iterate through the tableColumns list
        for(String column : tableColumns) {
            /*
                We can instantiate more than just top-level components in Apex. Here, we instantiate the columns for the table with
                the use of the Component.Apex.Column class
            */
            Component.Apex.Column tc = new Component.Apex.Column();
            tc.headerValue = column;
            tc.expressions.value = '{!record.' + column + '}';

            // We can nest components inside of each other by calling the add() method on the childComponents property
            pageBlockTable.childComponents.add(tc);
        }
        
        // Return the dynamically created component (and dynamically created nested components)
        return pageBlockTable;
    }
}