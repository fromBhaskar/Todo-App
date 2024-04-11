public with sharing class OppRelatedToAccountFromFlows {
    public OppRelatedToAccountFromFlows() {

    }

    @InvocableMethod
    public static void onCreateAccountCreateRelatedOpp(List<Id> accId){

        Opportunity opp = new Opportunity(Name = 'Manish',CloseDate = System.today(), StageName = 'Prospecting', AccountId = accId[0]);
        insert opp;
    }
}