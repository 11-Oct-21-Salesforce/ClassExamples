public class ContactAndCaseTablePage_CC {
    
    public ApexPages.StandardSetController ssc {
        get {
            if(ssc == null) {
                ssc = new ApexPages.StandardSetController(Database.getQueryLocator('SELECT Name, Phone, Email FROM Contact'));
            }
            return ssc;
        }
        private set;
    }
    
    public List<Contact> cons {get; set;}
    public List<Case> relatedCases {get;set;}
    
    public Boolean renderCaseTable {
        get {
            if(renderCaseTable == null) {
                renderCaseTable = false;
            }
            return renderCaseTable;
        }
        set;
    }
    
    public List<ContactCheckboxWrapper> contactCheckboxWrappers {
        get {
            if(contactCheckboxWrappers == null) {
                contactCheckboxWrappers = new List<ContactCheckboxWrapper>();
            }
            return contactCheckboxWrappers;
        }
        set;
    }
    
    public ContactAndCaseTablePage_CC() {
        this.cons = this.ssc.getRecords();
        
        for(Contact c : this.cons) {
            this.contactCheckboxWrappers.add(new ContactCheckboxWrapper(c));
        }
    }
    
    public class ContactCheckboxWrapper {
        public Contact c {get;set;}
        public Boolean checkbox {get;set;}
        
        public ContactCheckboxWrapper(Contact c) {
            this.c = c;
            this.checkbox = false;
        }
    }
    
    public PageReference getCases() {
        List<Id> contactIds = getSelectedContactIds();
        
        if(contactIds.size() > 0) {
            this.relatedCases = [SELECT Status, Subject, Priority, Contact.Name FROM Case WHERE ContactId IN :contactIds];

            if(this.relatedCases.size() > 0) {
                if(!this.renderCaseTable) {
                    this.renderCaseTable = true;
                }
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'The selected contact(s) do not have any related cases.'));
            }
            
            return Page.RelatedCaseTablePage;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select at least one contact.'));
            return null;
        }
    }
    
    public List<Id> getSelectedContactIds() {
        List<Id> contactIds = new List<Id>();
        
        for(ContactCheckboxWrapper ccw : contactCheckboxWrappers) {
            if(ccw.checkbox) {
                contactIds.add(ccw.c.Id);
            }
        }
        
        return contactIds;
    }
    
    public PageReference returnToContacts() {
        this.relatedCases.clear();
        return Page.ContactTablePage;
    }
}