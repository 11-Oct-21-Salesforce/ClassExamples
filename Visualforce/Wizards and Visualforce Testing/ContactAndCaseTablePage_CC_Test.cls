/*
    The test class for the ContactAndCaseTablePage_CC Custom Controller. To test Visualforce pages, we create test classes for
    any custom controller code they use. We then simulate user interaction by invoking all getters, setters, and action methods from
    the controller and calling appropriate asserts.
*/
@isTest
private class ContactAndCaseTablePage_CC_Test {
    @testSetup
    static void testSetup() {
        /*
            We can use the Test.setCurrentPage() method to determine the Visualforce page that our test is operating in the context
            of. This is only necessary to do when our controller works with properties of the PageReference object, so we're
            just following this step for demonstration purposes here.
        */
        PageReference contactTablePage = Page.ContactTablePage;
        Test.setCurrentPage(contactTablePage);
        
        // Create test contacts and related cases
        List<Contact> testCons = new List<Contact>();
        String conName;
        
        for(Integer i = 0; i < 5; i++) {
            if(i < 4) {
                conName = 'Test ' + i;
            } else {
                conName = 'No Related Cases';
            }
            
            testCons.add(new Contact(LastName=conName, Email='test' + i + '@aol.com', Phone='1234567890'));
        }
        
        insert testCons;
        
        List<Case> testCases = new List<Case>();
        
        for(Contact c : testCons) {
            if(c.LastName != 'No Related Cases') {
                for(Integer i = 0; i < 5; i++) {
                    testCases.add(new Case(Status='New', Subject='Test ' + i, Priority='Medium', ContactId=c.Id));
                }
            }
        }
        
        insert testCases;
    }
    
    // Test proper navigation through the wizard
    @isTest
    static void testContactTablePageNavigation() {
        // Instantiate the Custom Controller
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        // Retrieve the contacts that were inserted by the testSetup() method
        List<Contact> testCons = [SELECT Name, Email, Phone FROM Contact];
        
        Test.startTest();
        
        /*
            Get the contacts from the cons property of the Custom Controller (which should've been populated when the constructor
            of the Custom Controller was invoked) and the contacts from the getRecords() method of the ssc property of the Custom
            Controller (which should've been populated when cons referenced ssc in the constructor of the Custom Controller).
        */
        List<Contact> consFromCustomController = customController.cons;
        List<Contact> contactsFromStandardSetController = (List<Contact>) customController.ssc.getRecords();
        Test.stopTest();
        
        // Assert that consFromCustomController and contactsFromStandardSetController are populated with the appropriate contacts
        System.assertEquals(testCons, consFromCustomController);
        System.assertEquals(testCons, contactsFromStandardSetController);
        
        // Get the wrapper objects from the contactCheckboxWrappers property of the Custom Controller
        List<ContactAndCaseTablePage_CC.ContactCheckboxWrapper> wrappersFromCustomController = customController.contactCheckboxWrappers;
        
        // Iterate through wrappersFromCustomController, "selecting" the checkboxes for the contacts named Test 0 and Test 1
        for(ContactAndCaseTablePage_CC.ContactCheckboxWrapper w : wrappersFromCustomController) {
            if((w.c.Name == 'Test 0') || (w.c.Name == 'Test 1')) {
                w.checkbox = true;
            }
        }
        
        // Invoke the getCases() method of the Custom Controller
        PageReference pageRefFromGetCases = customController.getCases();
        
        /*
            Ensure that the URL of the PageReference returned from the getCases() method is the URL of the RelatedCaseTablePage - 
            i.e. ensure that the getCases() method returned the PageReference for the RelatedCaseTablePage.
        */
        System.assertEquals(pageRefFromGetCases.getUrl(), Page.RelatedCaseTablePage.getUrl());
        
        // Get the cases related to the selected contacts from the relatedCases property of the custom controller
        List<Case> casesFromCustomController = customController.relatedCases;

        // Get the cases related to the Test 0 and Test 1 contacts
        List<Case> expectedCases = [SELECT Subject, Status, Priority, Contact.Name FROM Case WHERE Contact.LastName IN ('Test 0', 'Test 1')];
        
        /*
            Ensure that the two lists of cases are equal and that renderCaseTable has been set to true (i.e. that the
            <apex:pageBlockTable> on RelatedCaseTablePage would be rendered because the selected contacts had related cases).
        */
        System.assertEquals(expectedCases, casesFromCustomController);
        System.assert(customController.renderCaseTable);
    }
    

    /*
        Test the See Related Cases button being "pressed" without any contacts selected from the <apex:pageBlockTable> on 
        ContactTablePage
    */
    @isTest
    static void testNoContactsSelected() {
        // Instantiate the custom controller and retrieve the list of wrapper objects from contactCheckboxWrappers
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        List<ContactAndCaseTablePage_CC.ContactCheckboxWrapper> wrappersFromCustomController = customController.contactCheckboxWrappers;
        
        // Invoke the getCases() method of the Custom Controller
        PageReference getCasesPageReference = customController.getCases();
        
        /*
            Assert that the PageReference returned by the call to getCases() is null (this should be the case because of the logic
            in our action method).
        */
        System.assertEquals(null, getCasesPageReference);
        
        // Retrieve the message from the list of messages from the current page
        ApexPages.Message message = ApexPages.getMessages()[0];
        
        // Assert that the severity and message of the error message are equal to the expected values
        System.assertEquals('Please select at least one contact.', message.getSummary());
        System.assertEquals(ApexPages.Severity.ERROR, message.getSeverity());
    }
    
    /*
        Test the See Related Contacts button on ContactTablePage being "pressed" with only contacts that don't have related cases
        selected.
    */
    @isTest
    static void testContactWithNoCasesSelected() {
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        List<ContactAndCaseTablePage_CC.ContactCheckboxWrapper> wrappersFromCustomController = customController.contactCheckboxWrappers;
        
        // iterate through the wrapper objects, selecting only the contact that doesn't have any related cases
        for(ContactAndCaseTablePage_CC.ContactCheckboxWrapper w : wrappersFromCustomController) {
            if(w.c.Name == 'No Related Cases') {
                w.checkbox = true;
            }
        }
        
        PageReference getCasesPageReference = customController.getCases();
        
        // Assert that the getCases() method redirected us to RelatedCaseTablePage
        System.assertEquals(Page.RelatedCaseTablePage.getUrl(), getCasesPageReference.getUrl());
        

        // Retrieve the first item from the list of messages on the page
        ApexPages.Message message = ApexPages.getMessages()[0];
        
        // Assert that the severity and content of the message are equal to the expected values and that there are no related cases
        System.assertEquals('The selected contact(s) do not have any related cases.', message.getSummary());
        System.assertEquals(ApexPages.Severity.INFO, message.getSeverity());
        System.assertEquals(0, customController.relatedCases.size());
    }
    
    // Test navigation from RelatedCaseTablePage to ContactTablePage
    @isTest
    static void testRelatedCaseTablePageNavigation() {
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        PageReference relatedCaseTablePage = Page.RelatedCaseTablePage;
        Test.setCurrentPage(relatedCaseTablePage);
        
        // Manually populate relatedCases in the Custom Controller
        customController.relatedCases = [SELECT Priority, Subject, Status, Contact.Name FROM Case];
        
        // Invoke the returnToContacts() method of the Custom Controller
        PageReference returnToContactsReference = customController.returnToContacts();
        
        /*
            Assert that the returnToContacts() method returned the PageReference for the ContactTablePage and that the relatedCases
            property has been cleared.
        */
        System.assertEquals(Page.ContactTablePage.getUrl(), returnToContactsReference.getUrl());
        System.assertEquals(0, customController.relatedCases.size());
    }
}