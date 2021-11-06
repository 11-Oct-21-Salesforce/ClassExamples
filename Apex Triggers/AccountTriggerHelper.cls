public class AccountTriggerHelper {
    // This method checks for active children Opportunity records (those with a stage that has any value other than Closed Won 
    // or Closed Lost) for the account(s) being deleted. If such opportunities exist, we'll prevent the parent account from
    // being deleted.
    
    // Because Apex collections (e.g. Trigger.oldMap) are passed by reference, we don't have to return any values from
    // our method - any changes we make will have already been made to the records within the collection passed as an
    // argument to our method.
    public static void checkForActiveOpportunities(Map<Id, Account> oldAccMap) {
        // Create a List of non-active opportunity stages to use as a query filter.
        List<String> closedStages = new List<String>{'Closed Won', 'Closed Lost'};
            
        // Execute a SOQL query to retrieve the StageName and AccountId from all opportunities that match our filters.
        // We use the keySet() method of the Map class to get back all keys from the oldAccMap parameter. Because oldAccMap
        // is populated with Trigger.oldMap, calling keySet() will return the Ids of all accounts involved in the delete
        // operation. We use this value to ensure we only return opportunities related to the accounts currently undergoing
        // the delete operation.
        
        // We also use the closedStages List to ensure that we only return opportunities with an active stage. Both filters
        // use the IN operator, which checks to see if a record's value for a field matches one of the values in a collection.
        List<Opportunity> opps = [SELECT StageName, AccountId FROM Opportunity WHERE AccountId IN :oldAccMap.keySet()
                                 	AND StageName NOT IN :closedStages];
        
        // We want to know which Account records we need to prevent from being deleted and we want to bulkify our trigger so
        // it can handle multiple records at once, so we'll create a Set to hold the Ids of the accounts that we need
        // to add an error to and populate it by iterating through our List of opportunities from the above query and adding
        // the value of the AccountId of each opportunity to our Set. If there are multiple opportunities related to the same
        // account, the add() method will ignore the duplicate values.
        Set<Id> invalidAccIds = new Set<Id>();
        for(Opportunity o : opps) {
            invalidAccIds.add(o.AccountId);
        }
        
        // Now that we know which accounts to fail, we'll iterate through the List of Ids corresponding to those accounts.
        for(Id invalidId : invalidAccIds) {
            // On each iteration, we'll use the get() method of the oldAccMap parameter to retrieve the sObject corresponding
            // to that Id and call the addError() method on that sObject, passing a string to serve as our error message.
            // Any sObjects that have had addError() called on themselves or one of their fields will fail the validation
            // step that immediately follows the before triggers in the Order of Execution.
            oldAccMap.get(invalidId).addError('Accounts with active opportunities cannot be deleted.');
        }
    }
}