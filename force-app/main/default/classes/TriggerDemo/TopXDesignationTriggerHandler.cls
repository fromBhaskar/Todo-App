public with sharing class TopXDesignationTriggerHandler {
    public TopXDesignationTriggerHandler() {
    }

    public static void onTopInsertUpdateRelatedOpp(List<Top_X_Designation__c> topDesList){

        List<Opportunity> oppList  = new List<Opportunity>();
        Set<Id> oppSet = new Set<Id>();
        for (Top_X_Designation__c top : topDesList) {
            if (top.Opportunity__c != null && top.Document_Attached__c == True && top.Type__c == 'Contract Flow Down' || top.Type__c == 'Handoff') {
                oppSet.add(top.Opportunity__c);
            }
        }

        for (Opportunity opp : [SELECT ID from Opportunity WHERE Handoff_Attached__c != 'Yes' AND id in : oppSet]) {
            opp.Handoff_Attached__c = 'Yes';
            oppList.add(opp);
        }

        

        if (!oppList.isEmpty()) {
        update oppList;
            
        }

    }
}