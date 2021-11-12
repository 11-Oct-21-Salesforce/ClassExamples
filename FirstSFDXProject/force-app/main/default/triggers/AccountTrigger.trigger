// Write an APEX Trigger to relate an existing contact to a newly created account. For this exercise assume the last name
// of the contact matches the account name.
trigger AccountTrigger on Account (after insert) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            AccountTriggerHelper.relateContactsToNewAccounts(Trigger.new);
        }
    }
}