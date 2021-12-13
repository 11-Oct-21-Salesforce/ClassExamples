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
            of.
        */
        PageReference contactTablePage = Page.ContactTablePage;
        Test.setCurrentPage(contactTablePage);
        
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
    
    @isTest
    static void testContactTablePageNavigation() {
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        List<Contact> testCons = [SELECT Name, Email, Phone FROM Contact];
        
        Test.startTest();
        List<Contact> consFromCustomController = customController.cons;
        List<Contact> contactsFromStandardSetController = (List<Contact>) customController.ssc.getRecords();
        Test.stopTest();
        
        System.assertEquals(testCons, consFromCustomController);
        System.assertEquals(testCons, contactsFromStandardSetController);
        
        List<ContactAndCaseTablePage_CC.ContactCheckboxWrapper> wrappersFromCustomController = customController.contactCheckboxWrappers;
        
        for(ContactAndCaseTablePage_CC.ContactCheckboxWrapper w : wrappersFromCustomController) {
            if((w.c.Name == 'Test 0') || (w.c.Name == 'Test 1')) {
                w.checkbox = true;
            }
        }
        
        PageReference pageRefFromGetCases = customController.getCases();
        
        System.assertEquals(pageRefFromGetCases.getUrl(), Page.RelatedCaseTablePage.getUrl());
        
        List<Case> casesFromCustomController = customController.relatedCases;
        List<Case> expectedCases = [SELECT Subject, Status, Priority, Contact.Name FROM Case WHERE Contact.LastName IN ('Test 0', 'Test 1')];
        
        System.assertEquals(expectedCases, casesFromCustomController);
        System.assert(customController.renderCaseTable);
    }
    
    @isTest
    static void testNoContactsSelected() {
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        List<ContactAndCaseTablePage_CC.ContactCheckboxWrapper> wrappersFromCustomController = customController.contactCheckboxWrappers;
        
        PageReference getCasesPageReference = customController.getCases();
        
        System.assertEquals(null, getCasesPageReference);
        
        ApexPages.Message message = ApexPages.getMessages()[0];
        
        System.assertEquals('Please select at least one contact.', message.getSummary());
        System.assertEquals(ApexPages.Severity.ERROR, message.getSeverity());
    }
    
    @isTest
    static void testContactWithNoCasesSelected() {
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        List<ContactAndCaseTablePage_CC.ContactCheckboxWrapper> wrappersFromCustomController = customController.contactCheckboxWrappers;
        
        for(ContactAndCaseTablePage_CC.ContactCheckboxWrapper w : wrappersFromCustomController) {
            if(w.c.Name == 'No Related Cases') {
                w.checkbox = true;
            }
        }
        
        PageReference getCasesPageReference = customController.getCases();
        
        System.assertEquals(Page.RelatedCaseTablePage.getUrl(), getCasesPageReference.getUrl());
        
        ApexPages.Message message = ApexPages.getMessages()[0];
        
        System.assertEquals('The selected contact(s) do not have any related cases.', message.getSummary());
        System.assertEquals(ApexPages.Severity.INFO, message.getSeverity());
        System.assertEquals(0, customController.relatedCases.size());
    }
    
    @isTest
    static void testRelatedCaseTablePageNavigation() {
        ContactAndCaseTablePage_CC customController = new ContactAndCaseTablePage_CC();
        
        PageReference relatedCaseTablePage = Page.RelatedCaseTablePage;
        Test.setCurrentPage(relatedCaseTablePage);
        
        customController.relatedCases = [SELECT Priority, Subject, Status, Contact.Name FROM Case];
        
        PageReference returnToContactsReference = customController.returnToContacts();
        
        System.assertEquals(Page.ContactTablePage.getUrl(), returnToContactsReference.getUrl());
        System.assertEquals(0, customController.relatedCases.size());
    }
}