public with sharing class ContactService {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getContacts() {
        return [SELECT Name, Phone, Email FROM Contact];
    }
}
