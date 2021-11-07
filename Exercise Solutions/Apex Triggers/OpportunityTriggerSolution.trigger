// Write an Apex trigger on the Opportunity object. If the Stage field of an Opportunity has a value of "Closed Won" or 
// "Closed Lost", no changes should be able to made to its Close Date.
trigger OpportunityTriggerSolution on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            OpportunityTriggerHelperSolution.validateStageAndDate(Trigger.old, Trigger.newMap);
        }
    }
}