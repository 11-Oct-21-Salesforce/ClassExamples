public class AccountTriggerHelper {
    public static void relateContactsToNewAccounts(List<Account> newAccounts) {
        Map<String, String> accNameIdMap = new Map<String, String>();
        for(Account a : newAccounts) {
            accNameIdMap.put(a.Name, a.Id);
        }
        
        List<Contact> cons = [SELECT LastName FROM Contact WHERE LastName IN :accNameIdMap.keySet()];
        
        for(Contact c : cons) {
            c.AccountId = accNameIdMap.get(c.LastName);
        }
        
        update cons;
    }
}