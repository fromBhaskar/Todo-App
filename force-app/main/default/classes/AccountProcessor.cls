public with sharing class AccountProcessor {
   
    
    //system.debug(SessionIdHelper.getCurrentUserSessionId());
    @future 
   public static void countContacts(List<Id> idList){

    List<Account> newAccList = new List<Account>();
       System.debug(idList);
    List<Account> accList = [SELECT id, (SELECT id FROM Contacts) FROM Account WHERE id in :idList];

    for (Account acc : accList) {
        acc.Number_Of_Contacts__c = acc.Contacts.size();
        newAccList.add(acc);
    }

    if (!newAccList.isEmpty()) {
        update newAccList;
    }
   }
}