// Write an Apex trigger to prohibit the creation of a new contact if the email is already used by a contact in the 
// system.
trigger ContactTrigger on Contact (before insert) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            ContactTriggerHelper.checkForDuplicateEmails(Trigger.new);
        }
    }
}