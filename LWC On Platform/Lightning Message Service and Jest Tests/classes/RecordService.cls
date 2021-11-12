public with sharing class RecordService {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getRecords(String objectToQuery) {
        List<sObject> queryResults = new List<sObject>();
        
        if(objectToQuery == 'Contact') {
            queryResults = [SELECT Name, Phone, Email FROM Contact];
        } else if(objectToQuery == 'Lead') {
            queryResults = [SELECT Name, Phone, Email FROM Lead];
        }

        return queryResults;
    }
}
