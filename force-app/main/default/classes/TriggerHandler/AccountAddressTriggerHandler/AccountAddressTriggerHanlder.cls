public with sharing class AccountAddressTriggerHanlder {
    public AccountAddressTriggerHanlder() {

    }

    public static void onAccountMatchBillingAddressCheck(List<Account> accList){
        for (Account acc : accList) {
            if (acc.Match_Billing_Address__c == True) 
                acc.ShippingPostalCode = acc.BillingPostalCode;               
    }
}
}