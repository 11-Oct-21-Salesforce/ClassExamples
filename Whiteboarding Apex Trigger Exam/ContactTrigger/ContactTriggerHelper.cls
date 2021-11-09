public class ContactTriggerHelper {
    public static void checkForDuplicateEmails(List<Contact> newContacts) {
        Set<String> newEmails = new Set<String>();
        for(Contact c : newContacts) {
            if(c.Email != null) {
            	newEmails.add(c.Email);
            }
        }
        
        List<Contact> existingCons = [SELECT Id, Email FROM Contact WHERE Email IN :newEmails];
        
        Set<String> existingEmails = new Set<String>();
        for(Contact c : existingCons) {
            existingEmails.add(c.Email);
        }
        
        for(Contact c : newContacts) {
            if(existingEmails.contains(c.Email)) {
                c.Email.addError('Can\'t create contact because the email provided is already associated with an ' +
                                 'existing contact.');
            }
        }
    }
}