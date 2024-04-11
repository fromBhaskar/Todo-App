public with sharing class ContactTriggerHanlder {
    public ContactTriggerHanlder() {

    }

    public static void onInsertContactUpdatedRelatedAccount(List<Contact> conList){

        List<Account> accList = new List<Account>();
        Set<Id> conIDs = new Set<Id>();
        for (Contact con : conList) {
            if (con.AccountId != null) 
            conIDs.add(con.AccountId);
        }

        for (Account acc : [SELECT id FROM Account WHERE id IN :conIDs ]) {
            acc.Description = 'Total Contacts = '+acc.Contacts.size();
            accList.add(acc);
        }
        
        if (!accList.isEmpty()) {
            update accList;
        }


    }

}