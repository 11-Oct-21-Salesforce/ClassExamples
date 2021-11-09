public class OpportunityTriggerHelper {
    public static void validateStage(List<Opportunity> oldOpps, Map<Id, Opportunity> newOppMap) {
        for(Opportunity o : oldOpps) {
            if((o.StageName == 'Closed Won') || (o.StageName == 'Closed Lost')) {
                newOppMap.get(o.Id).addError('Cannot update an opportunity with a stage of Closed Won or Closed Lost.');
            }
        }
    }
}