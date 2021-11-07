// Write an Apex trigger on the Opportunity object. If the Stage field of an Opportunity has a value of "Closed Won" or 
// "Closed Lost", no changes should be able to made to its Close Date.
public class OpportunityTriggerHelperSolution {
    public static void validateStageAndDate(List<Opportunity> oldOpps, Map<Id, Opportunity> newOppMap) {
		for(Opportunity o : oldOpps) {
            if((o.StageName == 'Closed Won') || (o.StageName == 'Closed Lost')) {
                if(o.CloseDate != newOppMap.get(o.Id).CloseDate) {
                    newOppMap.get(o.Id).CloseDate.addError('The Close Date field cannot be changed for opportunities with a ' +
                                                           'stage of Closed Won or Closed Lost.');
                }
            }
        }
    }
}