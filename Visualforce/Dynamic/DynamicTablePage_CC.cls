public class DynamicTablePage_CC {    
    public Boolean renderTable {
        get {
            if(renderTable == null) {
                renderTable = false;
            }
            return renderTable;
        }
        set;
    }
    
    public String selectedObject {
        get {
            if(selectedObject != null) {
                renderTable = true;
            }
            return selectedObject;
        }
        set;
    }
    
    public List<Opportunity> opps {
        get {
            if(opps == null) {
                opps = [SELECT Name, StageName, Amount, CloseDate FROM Opportunity];
            }
            return opps;
        }
        private set;
    }
    
    public List<Lead> leads {
        get {
            if(leads == null) {
                leads = [SELECT Name, Status, Email FROM Lead];
            }
            return leads;
        }
        private set;
    }
    
    List<String> oppFields;
    List<String> leadFields;
    
    public DynamicTablePage_CC() {
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
    
    public Component.Apex.PageBlockTable getTable() {
        Component.Apex.PageBlockTable pageBlockTable = new Component.Apex.PageBlockTable();
        
        List<String> tableColumns = new List<String>();
        
        if(this.selectedObject == 'Opportunity') {
            pageBlockTable.expressions.value = '{!opps}';
            tableColumns = this.oppFields;
        } else if(this.selectedObject == 'Lead') {
            pageBlockTable.expressions.value = '{!leads}';
            tableColumns = this.leadFields;
        } else {
            return null;
        }
		
        pageBlockTable.var = 'record';
        
        for(String column : tableColumns) {
            Component.Apex.Column tc = new Component.Apex.Column();
            tc.headerValue = column;
            tc.expressions.value = '{!record.' + column + '}';
            pageBlockTable.childComponents.add(tc);
        }
        
        return pageBlockTable;
    }
}