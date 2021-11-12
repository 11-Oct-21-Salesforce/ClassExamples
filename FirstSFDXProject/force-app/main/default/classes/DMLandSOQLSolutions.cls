public class DMLandSOQLSolutions {
    // One Account Per Original Pokemon
	// Create a class in the Developer Console that has a method to add 151 accounts to your org.
	
	// These accounts should have unique names.
    public static void addAccounts() {
        List<Account> accs = new List<Account>();
        for(Integer i = 0; i < 151; i++) {
            accs.add(new Account(Name='Solution ' + i));
        }
        insert accs;
    }
    
    // Query for the accounts you made, and then remove them from the database.
    public static void removeAccounts() {
        delete [SELECT Id FROM Account WHERE Name LIKE 'Solution%'];
    }
    
    // Query for all contacts that do not have a phone number associated with them, and provide default data for those fields.
    public static void populateDefaults() {
        List<Contact> cons = [SELECT Id, Phone, Account.Phone FROM Contact WHERE Phone = null AND AccountId != null];
        
        for(Contact c : cons) {
            if(c.Account.Phone != null) {
                c.Phone = c.Account.Phone;
            }
        }
        
        update cons;
    }
    
    // Create 200 new contacts, plus update all existing contacts first names to bob. In a single DML update and and add the new
    // contacts.
    public static void bobUpsert() {
        List<Contact> cons = [SELECT Id FROM Contact];
        
        Integer numIterations = 200 + cons.size();
        
        for(Integer i = 0; i < numIterations; i++) {
            if(i < cons.size()) {
                cons[i].FirstName = 'Bob';
            }
            else {
                cons.add(new Contact(FirstName='Bob', LastName='Solution ' + i));
            }
        }
        
        upsert cons;
    }
    
    // Create a method that creates N number of accounts, within it call a second method that creates N contacts.
    // Relate the newly created contacts to the newly created accounts. 
    
    // As a part of this fill out the following fields for each account:
    // 		Name, annual revenue, phone, and site.

	// Also fill out the following fields for each contact: 
	//		Last name, first name, phone, and email.

	// Once these are created ensure they are inserted into the database.
    public static void createNAccounts(Integer n) {
        List<Account> accs = new List<Account>();
        
        for(Integer i = 0; i < n; i++) {
            accs.add(new Account(Name='Solution ' + i, AnnualRevenue=i, Phone='1234567890', Site='solution' + i + '.aol.com'));
        }
        
        insert accs;
        
        createNContacts(accs);
    }
    
    public static void createNContacts(List<Account> accs) {
        List<Contact> cons = new List<Contact>();
        
        for(Integer i = 0; i < accs.size(); i++) {
            cons.add(new Contact(FirstName='Solution', LastName=String.valueOf(i), Phone='1234567890', Email='solution' + i
                                + '@aol.com', AccountId=accs[i].Id));
        }
        
        insert cons;
    }

	// Create a third method that gets all child contacts from the account using a relationship query, and then changes the 
	// contact phone number to the account phone number.

	// Persist these changes.
    public static void updateContactPhone(Account acc) {
        List<Contact> cons = [SELECT Id, Phone, Account.Phone FROM Contact WHERE AccountId = :acc.Id];
        
        for(Contact c : cons) {
            if(Account.Phone != null) {
            	c.Phone = c.Account.Phone;
            }
        }
        
        update cons;
    }

	// Query for contacts and retrieve each contacts first and last name, and then the related account name, phone, and site. 
	// Using system.debug display each of these in a debug log.
    public static void displayContactsAndAccounts() {
        List<Contact> cons = [SELECT FirstName, LastName, Account.Name, Account.Phone, Account.Site FROM Contact];
        
        for(Contact c : cons) {
            String debugString = c.FirstName + ' ' + c.LastName;
            if(c.Account.Name != null) {
                debugString += ' is related to ' + c.Account.Name + '.';
            }
            
            if(c.Account.Phone != null) {
                debugString += ' ' + c.Account.Name + '\'s phone number is ' + c.Account.Phone + '.';
            }
            
            if((c.Account.Site != null) && (debugString.contains('phone number'))) {
                debugString = debugString.substring(0, debugString.length() - 2) + ' and their website is ' + c.Account.Site +
                    '.';
            } else if(c.Account.Site != null) {
                debugString += ' ' + c.Account.Name + '\'s website is ' + c.Account.Site + '.';
            }
               
            System.debug(debugString);
        }
    }
}