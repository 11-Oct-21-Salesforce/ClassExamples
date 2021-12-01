public class PositionTriggerHandler {
    public static void shareWithHiringManager(List<Position__c> newPositions) {
        // We create a list of Position__Share records, because we want to operate dml on collections.
        List<Position__Share> positionShares = new List<Position__Share>();
        
        // We iterate over the new positions.
        for(Position__c p : newPositions) {
            // We declare a new Position__Share record and add it to the list
            positionShares.add(new Position__Share(AccessLevel='Edit', UserOrGroupId=p.Hiring_Manager__c, ParentId=p.Id,
                                                   RowCause='Manual'));
        }
        
        // We insert the new share records.
        insert positionShares;
    }
}