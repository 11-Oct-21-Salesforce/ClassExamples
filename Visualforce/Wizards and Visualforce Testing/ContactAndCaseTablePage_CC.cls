/* 
    Because we're creating a wizard, this one class serves as the Custom Controller for both ContactTablePage and
    RelatedCaseTablePage.
*/
public class ContactAndCaseTablePage_CC {
    
    /* 
        Even though we created a Custom Controller, we can still instantiate the ApexPages.StandardSetController class, which
        represents the standard controller, to make use of its prebuilt functionality
    */
    public ApexPages.StandardSetController ssc {
        get {
            if(ssc == null) {
                ssc = new ApexPages.StandardSetController(Database.getQueryLocator('SELECT Name, Phone, Email FROM Contact'));
            }
            return ssc;
        }
        private set;
    }

    /*
        variables to hold the list of contacts from the Standard Set Controller instance and the cases related to those contacts, 
        respectively
    */
    public List<Contact> cons {get; set;}
    public List<Case> relatedCases {get;set;}
    
    // Boolean property to control the rendering of the <apex:pageBlockTable> in RelatedCaseTablePage
    public Boolean renderCaseTable {
        get {
            if(renderCaseTable == null) {
                renderCaseTable = false;
            }
            return renderCaseTable;
        }
        set;
    }
    
    // a list of wrapper class objects to populate the rows of the <apex:pageBlockTable> in ContactTablePage
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

        // Instantiate the Standard Set Controller object and assign its resulting records to cons
        this.cons = this.ssc.getRecords();
        
        /* 
            Iterate through each contact in cons, creating a ContactCheckboxWrapper object for each and adding those to 
            contactCheckboxWrappers
        */
        for(Contact c : this.cons) {
            this.contactCheckboxWrappers.add(new ContactCheckboxWrapper(c));
        }
    }

    /*
        A wrapper class. Wrapper classes are used to combine entities of multiple data types into a single object (e.g. combining
        a Boolean value for a checkbox and a Contact record into one object). This allows us to create a custom data type and a list
        of records that can be passed to attributes like the value attribute on <apex:pageBlockTable>, which takes a single list
        of objects specifying the rows of the table.
    */
    public class ContactCheckboxWrapper {
        public Contact c {get;set;}
        public Boolean checkbox {get;set;}
        
        public ContactCheckboxWrapper(Contact c) {
            this.c = c;
            this.checkbox = false;
        }
    }
    
    /*
        The method that's action bound to the See Related Cases button on ContactTablePage. Because we're creating a wizard, methods
        to navigate to other wizard steps (i.e. pages), should return a PageReference object specifying that page.
    */
    public PageReference getCases() {
        /*
            Call a helper method to get the Ids of the contact records corresponding to the selected rows in the 
            <apex:pageBlockTable> in ContactTablePage.
        */
        List<Id> contactIds = getSelectedContactIds();
        
        // As long as the user selected at least one contact....
        if(contactIds.size() > 0) {
            // Query for the cases related to that contact
            this.relatedCases = [SELECT Status, Subject, Priority, Contact.Name FROM Case WHERE ContactId IN :contactIds];

            /*
                If the selected contact(s) had at least one related case (collectively), make sure that the property controlling
                the rendering of the <apex:pageBlockTable> on RelatedCaseTablePage is true.
            */
            if(this.relatedCases.size() > 0) {
                if(!this.renderCaseTable) {
                    this.renderCaseTable = true;
                }
            } else {
                /*
                    If the selected contact(s) did not have any related cases, add an informational message informing the user
                    of this. To add a message to a Visualforce page that includes an <apex:addMessage> component, we call the 
                    ApexPages.addMessage() method, passing an ApexPages.Message object. The constructor for ApexPages.Message
                    takes two arguments - an ApexPages.Severity enum (which can take a value of CONFIRM, ERROR, FATAL, INFO, or
                    WARNING and determines the styling of our message) and a string holding the message to display.

                */
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'The selected contact(s) do not have any related cases.'));
            }
            
            /*
                Redirect the user to RelatedCaseTablePage, the next page in the wizard. To get the PageReference for a Visualforce 
                page, we follow the format Page.VisualforcePageName, where VisualforcePageName is the name of the Visualforce page
                representing the next step in the wizard
            */
            return Page.RelatedCaseTablePage;
        } else {
            /*
                If the user didn't select any contacts, display an error message prompting them to do so and don't redirect them (we
                can keep a user on the current page by returning a null value from a method that returns a PageReference).
            */
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select at least one contact.'));
            return null;
        }
    }
    
    /* 
        Helper method to iterate through contactCheckboxWrappers and return a list of Ids of all contacts corresponding to the
        selected rows
    */
    public List<Id> getSelectedContactIds() {
        List<Id> contactIds = new List<Id>();
        
        for(ContactCheckboxWrapper ccw : contactCheckboxWrappers) {
            if(ccw.checkbox) {
                contactIds.add(ccw.c.Id);
            }
        }
        
        return contactIds;
    }
    
    /*
        The method that's action bound to the Return to Contacts button on RelatedCaseTablePage. This method clears the 
        relatedCases list and redirects the user to ContactTablePage, the first step in the wizard.
    */
    public PageReference returnToContacts() {
        this.relatedCases.clear();
        return Page.ContactTablePage;
    }
}