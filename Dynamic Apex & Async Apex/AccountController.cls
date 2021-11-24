public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchString){
       
        String search = '%' + searchString + '%';

        /*
        return [SELECT Name
                FROM Account
                WHERE Name LIKE :search];

                */

        
        String query = 'SELECT Name FROM Account WHERE Name LIKE :search';
        return Database.query(String.escapeSingleQuotes(query));


        // SOSL - Search.query()
        // A SOSL query with binds in all possible clauses

        /*
        String myString1 = 'aaa';
        String myString2 = 'bbb';
        Integer myInt3 = 11;
        String myString4 = 'ccc';
        Integer myInt5 = 22;

        List<List<SObject>> searchList = [FIND :myString1 IN ALL FIELDS 
                                        RETURNING 
                                            Account (Id, Name WHERE Name LIKE :myString2
                                                    LIMIT :myInt3), 
                                            Contact, 
                                            Opportunity, 
                                            Lead 
                                        WITH DIVISION =:myString4 
                                        LIMIT :myInt5];

        */
    }
}
