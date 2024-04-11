trigger ContactTrigger on Contact (after insert,after delete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContactTriggerHanlder.onInsertContactUpdatedRelatedAccount(Trigger.new);
        }
        if (Trigger.isDelete) {
            ContactTriggerHanlder.onInsertContactUpdatedRelatedAccount(Trigger.old);
        }
    }
}