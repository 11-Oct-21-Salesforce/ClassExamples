public class ContactSearchService {
	@AuraEnabled(cacheable=true)
    public static List<String> getParentAccounts() {
        List<Account> accsWithContacts = [SELECT Name FROM Account WHERE Id IN (SELECT AccountId FROM Contact)];
        
        List<String> accNames = new List<String>();
        
        for(Account a : accsWithContacts) {
            if(!accNames.contains(a.Name)) accNames.add(a.Name);
        }
        
        return accNames;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchForContacts(String accName, String contactName) {
        String queryFilters = '';
        
        if(String.isNotBlank(accName)) {
            queryFilters = 'WHERE Account.Name=\'' + accName + '\'';
        }
        
        if(String.isNotBlank(contactName)) {
            if(queryFilters.contains('WHERE')) {
                queryFilters += ' AND ';
            } else {
                queryFilters = 'WHERE ';
            }
            
            queryFilters += 'Name LIKE \'%' + contactName + '%\'';
        }
        
        return Database.query('SELECT Id, Name, Account.Name, Phone, Email FROM Contact ' + queryFilters);
    }
}