trigger AccountTrigger on Account (before insert,after insert,before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            AccountTriggerHandler.onInsertAccountAddPhone(Trigger.new);

        }
        if (Trigger.isUpdate) {
            AccountTriggerHandler.onUpdateAccountUpdatedItsPhone(Trigger.new);
        }
        
    }
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            AccountTriggerHandler.onAccountInsertCreateRealtedOpp(Trigger.new);
        }
    }

}