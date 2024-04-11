trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    ClosedOpportunityTriggerHandler.onClosedOppCreateTask(Trigger.new);
}