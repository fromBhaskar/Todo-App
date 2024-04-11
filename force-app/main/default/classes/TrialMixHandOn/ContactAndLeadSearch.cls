public with sharing class ContactAndLeadSearch {
    public ContactAndLeadSearch() {

    }

    public static List<List< sObject>> searchContactsAndLeads(String name){

        return [FIND :name IN ALL FIELDS RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName) ];
    }
}