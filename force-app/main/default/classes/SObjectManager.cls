public with sharing class SObjectManager {

    @AuraEnabled
    public static List<String> getAllSObjectNames() {
        List<String> standardObjectNames = new List<String>();

        for (Schema.SObjectType objectType : Schema.getGlobalDescribe().values()) {
            String objectName = objectType.getDescribe().getName();
        
                standardObjectNames.add(objectName);
          
        }

        return standardObjectNames;
    }


    @AuraEnabled
    public static List<String> getFieldsByObjectName(String objName) {
      try {
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe()
          .get(objName)
          .getDescribe();
          System.debug('describeResult  '+ describeResult);
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
       
        System.debug('field name describes>>>>>>>>>>>>'+ fieldMap);
        List<String> fieldNames = new List<String>();
        
        for (String fieldName : fieldMap.keySet()) {
          fieldNames.add(fieldName);
        }
          System.debug('field name describes>>>>>>>>>>>>'+ fieldNames);
        return fieldNames;
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }

    @AuraEnabled
    public static List<String> getSObjectMultiChoiceFields(String selectedObject) {

        List<String> reqFields = new List<String>();
        Map <String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(selectedObject);
        Schema.DescribeSObjectResult r = sobjType.getDescribe();
        Map<String, Schema.SObjectField> MapofField = r.fields.getMap();
        
        for(String fieldName : MapofField.keySet()) {
            Schema.SObjectField field = MapofField.get(fieldName);
            Schema.DescribeFieldResult F = field.getDescribe();
            System.debug('field-->'+field);
            System.debug('F-->'+F.getType()); //type of field

            if (F.getType().toString() == 'MULTIPICKLIST') {
	            reqFields.add(fieldName);       
            }
        }
        System.debug(reqFields);
        return reqFields;
        
    }
    
    @AuraEnabled
    public static Map<String,String> getAllObjects(){
        Map<String,String> objectMap = new Map<String,String>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
           String name = objTyp.getDescribe().getName();
           String label = objTyp.getDescribe().getLabel();
           if(!name.containsignorecase('history') && !name.containsignorecase('tag') &&
                !name.containsignorecase('share') && !name.containsignorecase('feed') && 
               	!name.containsignorecase('group') && !name.containsignorecase('public') &&
                !objTyp.getDescribe().isCustomSetting() && objTyp.getDescribe().isCreateable() &&
                objTyp.getDescribe().getRecordTypeInfos().size() > 0){      
                objectMap.put(name,label);
           }
        }
		System.debug(objectMap);
        if(objectMap != null && objectMap.size() > 0){
        	return objectMap;   
        }else{
            return null;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Multi_Picklist__c> getAllMultiPicklist(){
      try {
        System.debug('get all multipicklist records');
        List<Multi_Picklist__c> newMPList  = new List<Multi_Picklist__c>();
        for (Multi_Picklist__c record :  [SELECT id,object__c,flow__c,Fields__c,MP_Object_Name__c FROM Multi_Picklist__c]) {
          for (String newField : record.Fields__c.split(',')) {
            System.debug('name'+newField);
            Multi_Picklist__c newMP = new Multi_Picklist__c();
            newMP.id = record.Id;
            newMP.Object__c = record.Object__c;
            newMP.Flow__c = record.Flow__c;
            newMP.MP_Object_Name__c = record.MP_Object_Name__c;
            newMP.Fields__c = newField;
            newMPList.add(newMP);
          }

        }
        System.debug('List'+newMPList);
        return newMPList;
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }


   

    @AuraEnabled
    public static Multi_Picklist__c getMultiPicklist(String objectName){
      // try {
        System.debug('get all multipicklist records where object = '+ objectName);
        List<Multi_Picklist__c> record = [SELECT id,object__c,flow__c,Fields__c,MP_Object_Name__c FROM Multi_Picklist__c WHERE object__c = : objectName];
        return (record.size() != 0) ? record[0] : null;

      // } catch (Exception e) {
      //   throw new AuraHandledException(e.getMessage());
      // }
    }

    @AuraEnabled
    public static void deleteMultiPicklist(Multi_Picklist__c mp){
      System.debug('on delete mp');
      try {
        if (mp != null && getMultiPicklist(mp.Object__c).Fields__c.split(',').size() == 1) {
        delete mp;
        }else{
          updateMultiPicklist(mp.Object__c, mp.Fields__c);
        }
        
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }

    @AuraEnabled
    public static void deleteAllMultiPicklist(List<Multi_Picklist__c> mpList){
      System.debug('on delete mp');
      try {
        if (mpList.size() > 0 ) {
        delete mpList;
        }
        
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }


    //SObjectManager.updateMultiPicklist();
    @AuraEnabled
    public static void updateMultiPicklist(String objectName,String fieldValues){
      try {
        Multi_Picklist__c record = getMultiPicklist(objectName);
        System.debug('on update');
        System.debug(record);
        if(record != null){
        System.debug(record.Fields__c);
          if (record.Fields__c.length() >0 ) {
            List<String> fieldsList = record.Fields__c.split(',');
            String fields = record.Fields__c;
            System.debug('loop');
            if (fieldsList.size() == 1) {
              delete record;
            }else{
              if (record.Fields__c.contains(fieldValues+',')) {
                System.debug(fieldValues);
                record.Fields__c = fields.remove(fieldValues+',');
              }else{
                System.debug(fieldValues);
                record.Fields__c=fields.remove(','+fieldValues);
              }
              System.debug(record);
              update record;
            }

            
          }
          
        }
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }

    @AuraEnabled
    public static void createMultiPicklist(String objectName,String fieldValues){
      try {
        Multi_Picklist__c record = getMultiPicklist(objectName);
        if(record == null){
        String newObjectName = MetadataServiceExamples.createObject(objectName);
        String flowName = DynamicApexController.createMultiChoiceHandlerFlow(objectName);
        Multi_Picklist__c temp = new Multi_Picklist__c();
        temp.Object__c = objectName;
        temp.Fields__c=fieldValues;
        temp.Flow__c = flowName;
        temp.MP_Object_Name__c = newObjectName;
        insert temp;
        System.debug('new multipicklist record inserted ' +objectName);
        System.debug('new multipicklist record inserted ' +newObjectName);
        }else{
          record.Fields__c += ','+fieldValues;
          update record;
        }
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }
}