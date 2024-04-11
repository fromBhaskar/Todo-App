public with sharing class ContactSearch {
    public ContactSearch() {

    }

    public static  List<Contact> searchForContacts(String contactLastName,String mailCode){

        List<Contact> conList = [SELECT ID, Name FROM Contact WHERE LastName =: contactLastName AND MailingPostalCode =: mailCode];
        return conList;
    }

}