// Triggers should be logicless as a best practice. This means we
// use the trigger itself to channel the operation to a handler class, which should contain the business logic we want to execute.

// The signature for a trigger is as follows:
// 		trigger triggerName on sObject (triggerEvents) {}

// Another trigger best practice is to have at most one trigger per object. To help keep this best practice at the forefront
// of our minds, it's standard to name a trigger with the format ObjectNameTrigger, e.g. AccountTrigger. Additionally,
// we may write a trigger that handles all seven trigger events, even if we don't yet have a requirement for all of them.
// This can help remind ourselves and others to extend this single trigger, rather than creating another, whenever we do
// have a use case for another trigger event.

// A trigger event is a combination of trigger type (before or after) and invoking DML operation. There are seven trigger events
// - before insert, before update, before delete, after insert, after update, after delete, and after undelete.
trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    // To determine the invoking trigger event when our trigger handles multiple trigger events, we use Trigger context
    // variables. The Boolean Trigger context variables (Trigger.isBefore, Trigger.isAfter, Trigger.isInsert, Trigger.isUpdate
    // Trigger.isDelete, and Trigger.isUndelete) are used for this purpose.
    if(Trigger.isBefore && Trigger.isDelete) {
        // Now that we've determined that this is a before delete trigger, we'll call a method from our helper class.
        // Because this is a delete trigger, Trigger.new is not available. We'll use Trigger.oldMap, which is a map of 
        // record Ids to the old versions of those records as an argument. Because the checkForActiveOpportunities() method
        // is static, we don't have to instantiate the AccountTriggerHelper class to call it.
        AccountTriggerHelper.checkForActiveOpportunities(Trigger.oldMap);
    }
    
    // Alternatively, we could use the Trigger.operationType enum with a switch statement, like the below commented-out code:

    // switch on Trigger.operationType {
    //    when BEFORE_DELETE {
    //        AccountTriggerHelper.checkForActiveOpportunities(Trigger.oldMap);
    //    }
    // }

    // The Trigger.operationType enum has seven possible values (one for each trigger event) - BEFORE_INSERT, BEFORE_UPDATE,
    // BEFORE_DELETE, AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE, and AFTER_UNDELETE.
}