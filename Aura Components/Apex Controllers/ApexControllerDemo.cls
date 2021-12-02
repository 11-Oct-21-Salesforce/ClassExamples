public class ApexControllerDemo {
      /* in order to make an Apex method we can call from an Aura component, we must annotate it with the @AuraEnabled
    annotation and it must be public and static

    because a method cannot be more exposed than the class that contains it, the containing class must be public
    or global

    our function here will return a list of the Ids of all open cases */
	@AuraEnabled
    public static List<Id> getOpenCases() {
        // grab all the open (i.e. not closed) cases
        Map<Id, Case> caseMap = new Map<Id, Case>([SELECT Id FROM Case WHERE Status != 'Closed']);

        /* populate a list of the Ids of the returned cases and return that list */
        List<Id> caseIds = new List<Id>();
        for(Id caseId : caseMap.keySet()) {
            caseIds.add(caseId);
        }
        return caseIds;
    }
}