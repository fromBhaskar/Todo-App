public with sharing class ClosedOpportunityTriggerHandler {
    public ClosedOpportunityTriggerHandler() {

    }

    public static void onClosedOppCreateTask(List<Opportunity> oppList){
        List<Task> taskList = new List<Task>();
        for (Opportunity opp : oppList) {
            if (opp.StageName == 'Closed Won') {
                Task tempTask = new Task();
                tempTask.Subject = 'Follow Up Test Task';
                tempTask.WhatId = opp.Id;
                taskList.add(tempTask);
            }
        }
       if (!taskList.isEmpty()) {
        insert taskList;
       } 

    } 
}