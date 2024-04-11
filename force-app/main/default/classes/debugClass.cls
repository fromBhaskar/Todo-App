public with sharing class debugClass {
    
   @AuraEnabled(cacheable = true)
     public  static List<Account> getAccountRecs() {
        try {
            return [SELECT id, Name,Phone FROM Account LIMIT 10];
        
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}