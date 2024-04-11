trigger OrgBAccountTrigger on Account (after insert, after update, after delete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            OrgBAccountTriggerHandler.createAccount(Trigger.new[0].Id);
        }

        if (checkRecursion.runOnce()){
            System.debug('running on Account update');
            if (Trigger.isUpdate) {
                System.debug(Trigger.new[0].Name !=  Trigger.old[0].Name);
                if ( Trigger.new[0].Connected_Account_Id__c != null && Trigger.new[0].Name != Trigger.old[0].Name ) {
                    System.debug(Trigger.new[0]);
                    System.debug('running on Account update & Connected_Account_Id__c != null '+ Trigger.new[0].Connected_Account_Id__c);
                    OrgBAccountTriggerHandler.updateAccount(Trigger.new[0].Id);
                }
               
            }
        }

        if (Trigger.isDelete) {
            if (Trigger.old[0].Connected_Account_Id__c != null) {
            OrgBAccountTriggerHandler.onDeleteAccount(Trigger.old[0].Connected_Account_Id__c);
                
            }
        }

        
    }

}