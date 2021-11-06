// DML statements
// 	insert
// 		This statement creates new records with the data given.
// 	update
// 		This statement updates existing records with the data given, requires the record ID's.
// 	upsert
// 		This statement updates records where it can, and otherwise creates new records with the data given.
// 	delete
// 		This statement deletes the records given, and places them in the recycle bin.
// 	undelete
// 		This statement restores the deleted files from the recycle bin.

// Database Class Methods
// The database class can also be used for DML statements.
// For each of the above statements we also have a database method.
// Ex: database.insert(sObjectOrSObjectsToInsert, AllOrNone);

// In the above example we use the optional second parameter, this allows us to choose if we want the operation to be all or 
// none like the default DML statements. If we choose to set this to false it allows for partial success, meaning it will insert
// all valid records it can. Normally upon hitting a single failure the entire operation is aborted.
public class DMLExample {
    
    // This method demonstrates the allOrNone behavior of DML statements.
    public static void DMLStatements() {
        // As a best practice, we want to keep DML operations OUT of loops and operate on collections of records rather than
        // individual records, so we'll do so by creating a list, populating it within a loop, and then executing a single
        // DML operation on that list outside of the loop. This helps us avoid the governor on the number of DML operations
        // that can be executed in a single transaction.
        List<Contact> cons = new List<Contact>();
        for(Integer i = 0; i < 20; i++) {
            if(i == 19) {
                // The LastName field is a required field for the Contact object, so this sObject will have an error when
                // we attempt to insert it.
                cons.add(new Contact());
            } else {
                // This sObjects should be error free because we've populated all required fields.
                cons.add(new Contact(LastName='Test ' + i));
            }
        }
        
        // The standalone DML statement is allOrNone, meaning that either every record in the operation is successful, or none
        // of them are. If even a single record in the collection has an error (no matter where in the collection it is), the 
        // transaction will fail and none of the changes to any records will persist (even if those records didn't have errors).
        // Because one sObject in the list doesn't have a value for a required field, it will fail the operation, raising a 
        // DMLException and causing none of our records to be committed.
        insert cons;
    }
    
    // This method demonstrates how the Database class methods behave identically to DML statements (i.e. they're allOrNone)
    // when the allOrNone parameter isn't passed an argument. If we explicitly set the allOrNone parameter to true
    // (i.e. Database.insert(cons, true)), we'd see the same behavior.
    public static void databaseClassAllOrNone() {
        List<Contact> cons = new List<Contact>();
        for(Integer i = 0; i < 20; i++) {
            if(i == 19) {
                cons.add(new Contact());
            } else {
                cons.add(new Contact(LastName='Test ' + i));
            }
        }
        
        Database.insert(cons);
    }
    
    // This method demonstrates the partial completion functionality of the Database class methods.
    public static void databaseClassPartialCompletion() {
        // We start as we did our previous two methods.
        List<Contact> cons = new List<Contact>();
        for(Integer i = 0; i < 20; i++) {
            if(i == 19) {
                cons.add(new Contact());
            } else {
                cons.add(new Contact(LastName='Test ' + i));
            }
        }
        
        // This time, we explicitly set the allOrNone parameter of the Database class method to false, allowing for
        // partial completion. Now, only records that have errors will fail the operation; error-free records will be committed,
        // regardless of the status of other records. Each Database class method returns a Result object or a List of Result
        // objects, e.g. Database.insert() returns a Database.SaveResult or List<Database.SaveResult>.
        List<Database.SaveResult> results = Database.insert(cons, false);
        
        // We'll iterate through the results to find out which records failed and which succeeded.
        for(Database.SaveResult dsr : results) {
            
            // Each Result object shares methods including the isSuccess() and getId() methods. isSuccess() returns a Boolean
            // indicating if the operation was successful for that particular record. getId() returns the Id of a particular 
            // record. If a record was inserted successfully, we'll output that information (along with its new record Id)
            // to the debug logs.
            if(dsr.isSuccess()) {
                System.debug('Contact record created with the following Id: ' + dsr.getId());
            } else {
                // If a record failed, we'll output its errors. We'll retrieve the errors through a call to another method
                // shared by the Result classes - getErrors(), which returns a List of Database.Error objects.
                for(Database.Error de : dsr.getErrors()) {
                    // The Database.Error class has getStatusCode(), getMessage(), and getFields() methods, which
                    // return the status code of the error, the associated error message, and the field or fields that
                    // had an error, respectively.
                    System.debug(de.getStatusCode() + ': ' + de.getMessage() + ' on ' + de.getFields());
                }
            }
        }
    }
}