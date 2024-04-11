public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {

    }


   public static void onUpdateAccountUpdatedItsPhone(List<Account> accList){
        if (accList != null) {
            for (Account acc : accList) {
                
                acc.Phone = '0234567890';
            }
        }
    }

    public static void onInsertAccountAddPhone(List<Account> accList){
        if (accList != null) {
            for (Account acc : accList) {
                acc.Phone = '1234567890';
            }
        }
    }

    public static void onAccountInsertCreateRealtedOpp(List<Account> accList){

        List<Opportunity> oppList = new List<Opportunity>();
        if (accList != null) {
            for (Account acc : accList) {
                Opportunity temp = new Opportunity();
                temp.AccountId = acc.Id;
                temp.Name = 'Mainsh';
                temp.CloseDate = System.today();
                temp.StageName = 'Prospecting';

                oppList.add(temp);
                
            }
        }

        if (!oppList.isEmpty()) {
        insert oppList;
        }
    }


}