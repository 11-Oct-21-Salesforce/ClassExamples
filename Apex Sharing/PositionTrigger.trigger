trigger PositionTrigger on Position__c (after insert) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            PositionTriggerHandler.shareWithHiringManager(Trigger.new);
        }
    }
}