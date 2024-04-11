trigger TopXDesignationTrigger on Top_X_Designation__c (after insert) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            TopXDesignationTriggerHandler.onTopInsertUpdateRelatedOpp(Trigger.new);
        }
        
    }
}