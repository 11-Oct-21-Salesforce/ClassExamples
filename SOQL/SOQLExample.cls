// Optional SOQL Clauses

//LIMIT
// Limit limits the number of records returned
// Example 
// [SELECT lastname FROM Contact LIMIT 1]
// Returns one record, the first record.

//OFFSET
// Offset determines the starting row returned of the query
// Commonly used for pagination. 
// Example
// [SELECT lastname FROM Contact LIMIT 100 OFFSET 50]
// This returns records 51-150 of the query results.

//WITH
// Although similar to WHERE, with has distinct uses.
// To filter records based on their categorization. Such as WITH DATA CATEGORY.
// To query and retrieve record changes tracked in a user profile feed. See Custom Object__Feed in the Object Reference for Salesforce .
// To filter records based on user access permissions on fields or objects being queried within Apex code. 
// See Filter SOQL Queries Using WITH SECURITY_ENFORCED in the Apex Developer Guide
// Example
// [SELECT lastname FROM Contact WITH SECURITY_ENFORCED]

//AGGREGATE
// Aggregate functions lets you get back aggregate results from a query.
// AVG() returns the average value of a numeric field. 
// COUNT() returns the number of matching results. COUNT_DISTINCT() Returns non-null matching results.
// MIN(), MAX(). Returns the minimum or maximum value of a numeric field.
// SUM() returns the sum of a numeric field.

//GROUP BY
// Group by lets you group records by specific values.
// Example
// [SELECT Count(lastname), account.name FROM Contact group by account.name]
// Groups the aggregate results by account, showing number of contacts per each.

//HAVING
// Having lets you filter the results of an aggregate function.
// Example
// [SELECT COUNT(lastname), account.name FROM Contact GROUP BY account.name HAVING COUNT(lastname) > 2]
// Will return only those accounts that have more than two contacts.

//DATE FUNCTIONS
// Date functions allow you to parse date fields to get specific information. Must be used with aggregates.
// Example
// [SELECT COUNT_DISTINCT(lastname), CALENDAR_YEAR(createddate) from Contact GROUP BY CALENDAR_YEAR(CreatedDate)]
// Returns the number of unique contact last names and the year they were created.

//FORMAT
// Format is used to format number, date, time, and currency fields based on localized settings.
// For example, dates in the US are Month, Day, Year. Whereas in europe they would be Day, Month Year.
// Example
// [SELECT FORMAT(lastmodifieddate) FROM Contact]
// Returns the last modified date in the localized format.

//FOR REFERENCE
// For reference is used when you are querying something 
// for reference in a custom interface, such as a visualforce page.
// This in turn will update the last referenced date accordingly.
// Example
// [SELECT lastname FROM Contact LIMIT 1 FOR REFERENCE]
// The record returned's last referenced date is updated.

//FOR UPDATE
// For update is used to lock a record during the current transaction.
// This prevents any other processes from updating the record while it 
// is being currently worked with.
// Example
// [SELECT lastname FROM Contact FOR UPDATE]
// Locks the returned records until the transaction completes.

public class SOQLExample {
    
    // This method demonstrates the use of the SOQL for loop.
    public static void soqlForLoop() {
        // Following our best practices for working with DML, we'll create a List of accounts to hold the records
        // we'll insert. We'll populate this List in a for loop, and then execute the insert statement on the List
        // OUTSIDE of the for loop. This ensures that we're operating on collections, rather than individual records, which
        // helps reduce the amount of DML operations we invoke.
        List<Account> exampleAccs = new List<Account>();
        for(Integer i = 0; i < 456; i++) {
            exampleAccs.add(new Account(Name='gogle ' + i));
        }
        insert exampleAccs;
        
        // The SOQL for loop takes the following format:
        // 		for(List<ObjectName> objs : [SELECT fieldName FROM objectName]) {}
        
        // The SOQL for loop is beneficial because it allows us to operate on the records returned from our query in smaller
        // chunks, decreasing our chances of violating the governor limit on heap size, while still only counting as one
        // SOQL query for the purposes of the governor limit on the number of SOQL queries that can be executed in a single
        // transaction. It achieves this by breaking the query results into batches of up to 200 records and iterating once
        // per batch. Only the batch that is being used in the current iteration is loaded into local memory and therefore
        // only the current batch counts toward our heap size.
        for(List<Account> accs : [SELECT Name FROM Account WHERE Name LIKE 'gogle%']) {
            // Because we inserted 456 accounts earlier, we should expect the SOQL for loop to have three iterations, which
            // debug 200, 200, and 56, respectively.
            System.debug(accs.size());
            
            // We'll frequently want to still iterate through each individual record returned from our query, so we can
            // nest an enhanced for loop inside of our SOQL for loop like the following commented-out code to do so.
            // for(Account a : accs) {}
        }
    }
    
    public static void aggregateFunctions() {
        // When executing a SOQL query that uses an aggregate function, the return type of the query is List<AggregateResult>
        // UNLESS the only member of the SELECT clause is the COUNT() function without any arguments and there is no grouping
        // in the query (in this latter case, the query's return type is Integer).
         
        // The name of the property holding our aggregate function result will be exprN, where N starts at 0 for the leftmost
        // aggregate function in the SELECT clause and increments by one for each subsequent aggregate function. But we can
        // provide an alias to give a more readable/understandable name. To alias a field in a SOQL query, we include the
        // alias name before either the comma that before the next field (if there are more fields in the SELECT clause) or
        // the FROM clause (if we're aliasing the last field in the SELECT clause). 
        
        // Any field listed in the SELECT clause of a query using an aggregate function must have an aggregate function
        // acting on it or be used for grouping, so we'll group the results of our query by industry with the GROUP BY clause.
        // We use the HAVING clause to filter our results based on the result of an aggregate function, in this case to ensure
        // that we only retrieve results for industries with an annual revenue greater than 0.
        List<AggregateResult> revenueByIndustry = [SELECT SUM(AnnualRevenue) sumAnnRev, Industry FROM Account GROUP BY Industry
                                                   HAVING SUM(AnnualRevenue) > 0];
        
        // Iterate through the List<AggregateResult>.
        for(AggregateResult ar : revenueByIndustry) {
            // We can't reference the properties of an AggregateResult with dot notation, rather we do so by calling the 
            // get() method, which takes the name of the field or alias to retrieve the value of. We'll use a couple methods
            // from the Double class (valueOf() and format()) to pretty up our sums before we print them to the debug log.
            System.debug(ar.get('industry') + ': $' + Double.valueOf(ar.get('sumAnnRev')).format());
        }
    }
}