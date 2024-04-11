public with sharing class CreateTask {
    
    @AuraEnabled
    public static Id createTask(Id objId , String subject, String status,
     String taskPriority,Id conId ){


        try {
            Id userId = UserInfo.getUserId();
               
                Task temp = new Task();
                
                temp.OwnerId = userId;
                temp.Subject = subject;
                temp.Status = status;
                temp.Priority = taskPriority;

                if (objId != null) 
                temp.WhatId = objId;
    
                if (conId != null) 
                temp.WhoId = conId;
    
                insert temp;

                System.debug('Task inserted'+ temp.Id);
    
                return temp.Id;
            } catch (Exception e){
                throw new AuraHandledException(e.getMessage());

            }
 
            
        }
       

    


        @AuraEnabled
          public  static List<Task> getTaskRecs() {
             try {
                 return [SELECT id, Subject, Priority, CreatedDate, WhatId FROM Task  ORDER BY CreatedDate DESC LIMIT 10];
             
             } catch (Exception e) {
                 throw new AuraHandledException(e.getMessage());
             }
         }

}