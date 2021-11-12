// Write an APEX Trigger to prevent the update of an opportunity if its stage is closed won or closed lost.
trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            OpportunityTriggerHelper.validateStage(Trigger.old, Trigger.newMap);
        }
    }
}