public with sharing class MultiChoiceHandler {
  @InvocableMethod(label='MultiChoiceHandler' description='description')
  public static void execute(List<MultiChoice> multiChoice) {
    System.debug('MultiChoiceHandler');
    SObject record = multiChoice[0].record;
    SObject priorRecord = multiChoice[0].priorRecord;
    String sObjName = record.id.getSObjectType().getDescribe().getName();
    String objApiName='MP_'+sObjName.replaceAll('__c','')+'__c';

    List<Sobject> objToInsert=new List<Sobject>();
    try {
      List<String> multiPicklistFields = new List<String>();
      List<Multi_Picklist__c> pickValues=[SELECT id,object__c,flow__c,Fields__c FROM Multi_Picklist__c WHERE Object__c=:sObjName];
      if(pickValues.size()>0){
        multiPicklistFields=pickValues[0].Fields__c.split(',');
        Set<String> mpSet = new Set<String>(multiPicklistFields);
        for(String currentField:mpSet){
          if(priorRecord==null){
            if (record.get(currentField) != null) {
            for(String currentValue:((String)(record.get(currentField))).split(';')){
            sObject s=Schema.getGlobalDescribe().get(objApiName).newSObject();
            s.put('MP_Type__c',currentField);
            s.put('MP_Value__c', currentValue);
            s.put(objApiName, record.Id);
            objToInsert.add(s);
           // String sObjName = 'MP_Intern__c';
            }
          }
        }else if(priorRecord.get(currentField)!=record.get(currentField)){
          System.debug('on update');
          System.debug('SELECT id,MP_Value__c,MP_Type__c,MP_'+ sObjName.replaceAll('__c','')+'__c '+' FROM '+objApiName+' WHERE MP_Type__c = \''+currentField +'\' AND '+ objApiName +' = '+ record.id );

            String query ='SELECT id,MP_Value__c,MP_Type__c,MP_'+ sObjName.replaceAll('__c','')+'__c '+' FROM '+objApiName+' WHERE MP_Type__c = \''+currentField +'\' AND '+ objApiName +' = \''+ record.id +'\'' ;
            List<SObject> obj =  Database.query(query);

            
            delete obj;
            
            if (record.get(currentField) != null) {
              for(String currentValue:((String)(record.get(currentField))).split(';')){
                sObject s=Schema.getGlobalDescribe().get(objApiName).newSObject();
                s.put('MP_Type__c',currentField);
                s.put('MP_Value__c', currentValue);
                s.put(objApiName, record.Id);
                objToInsert.add(s);
              }
            }

          }
        }
        if(objToInsert.size()>0){
          insert objToInsert;
        }
      }
   
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  public class MultiChoice {
    @InvocableVariable()
    public SObject priorRecord;

    @InvocableVariable()
    public SObject record;
  }
}
