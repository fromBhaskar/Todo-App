/*******************************************************************************************
/******************************************************************************************** 
* @Name         DynamicApexController 
* @Author       Erudite Works Pvt Ltd
* @Date         08/06/2023
* @description  This class handles all the creation of dynamic backend functionalities required for implementation of EW SnapShot
*               
*******************************************************************************************/
/* MODIFICATION LOG
 * Version          Developer                    Date               Description
 *-------------------------------------------------------------------------------------------
 *  1.0             Erudite Works Pvt Ltd        08/06/2023         Initial Development
 *******************************************************************************************/
public with sharing class DynamicApexController implements Metadata.DeployCallback {
  /** @description : Wrapper class to handle exceptions in MetaData deployment**/
  public class DynamicUtilityControllerException extends Exception {
  }

    /** @description This method assigns field permissions to Admins present in SnapShot_Admin_Permissions permission set
    *  @param objName String, fieldsToPermit List<String>  
    *  @return void */
    public static void assignPermissionsToAdmin(String objName,List<String> fieldsToPermit){
      try{
          DynamicMetadataService.MetadataPort service = createService();
          DynamicMetadataService.PermissionSet adminPs = new DynamicMetadataService.PermissionSet();
          List<DynamicMetadataService.PermissionSetFieldPermissions> fieldPermissions=new List<DynamicMetadataService.PermissionSetFieldPermissions>();
          if(!Test.isRunningTest()){
              adminPs= (DynamicMetadataService.PermissionSet) service.readMetadata('PermissionSet', new String[] { 'MP_Objects_Permisson' }).getRecords()[0];
              System.debug(adminPs);
              fieldPermissions=adminPs.fieldPermissions;
            }            
          
          for(String field:fieldsToPermit){
            System.debug(field);
              DynamicMetadataService.PermissionSetFieldPermissions newFieldPermission=new DynamicMetadataService.PermissionSetFieldPermissions();
              newFieldPermission.field=objName+'.'+field;
              System.debug('field '+newFieldPermission.field);
              newFieldPermission.readable=true;
              newFieldPermission.editable=true;
              fieldPermissions.add(newFieldPermission);
          }
          adminPs.fieldPermissions=fieldPermissions;
          // adminPs.objectPermissions = new List<DynamicMetadataService.PermissionSetObjectPermissions>{newObjectPermission};
          List<DynamicMetadataService.UpsertResult> results =
              service.upsertMetadata(
                  new DynamicMetadataService.Metadata[] { adminPs});
          handleUpsertResults(results[0]);
         
      }
      catch(Exception e){
          String classMethodName='DynamicApexController.assignPermissionsToAdmin()';
          try{
              // CustomExceptionHandler.exceptionHandler(e, classMethodName);
          } catch(Exception er) {
              String ErrorMsg= er.getMessage();
              ErrorMsg+=' in '+classMethodName;
              if(!Test.isRunningTest()){
                  //throw new AuraHandledException(ErrorMsg);
              }
          }
      }
  }

  // DynamicApexController.createMultiChoiceHandlerFlow('Contact');
  @AuraEnabled
  public static String createMultiChoiceHandlerFlow(String objName) {
    String objNameNew;
    if (objName.endsWithIgnoreCase('__c')) {
      objNameNew = objName.replace('__c', '');
    } else {
      objNameNew = objName;
    }
    String flowName =objNameNew + 'MultiChoiceHandler';

    List<FlowDefinitionView>  flows = [SELECT id,ApiName FROM FlowDefinitionView WHERE ApiName = : flowName ];

    if(flows.size() == 0){
    DynamicMetadataService.MetadataPort service = createService();
    // Create Flow
    DynamicMetadataService.Flow flow = new DynamicMetadataService.Flow();
    flow.fullName = objNameNew + 'MultiChoiceHandler';
    flow.description = 'This flow is used for MultiChoice picklist fileds';
    flow.label = objNameNew + 'MultiChoiceHandler';
    flow.processType = 'AutoLaunchedFlow';
    flow.status = 'Active';

    List<DynamicMetadataService.FlowMetadataValue> flowProcessValuesList = new List<DynamicMetadataService.FlowMetadataValue>();

    DynamicMetadataService.FlowElementReferenceOrValue processValue = new DynamicMetadataService.FlowElementReferenceOrValue();
    processValue.stringValue = 'LightningFlowBuilder';

    DynamicMetadataService.FlowElementReferenceOrValue processValueForCanvas = new DynamicMetadataService.FlowElementReferenceOrValue();
    processValueForCanvas.stringValue = 'AUTO_LAYOUT_CANVAS';

    DynamicMetadataService.FlowElementReferenceOrValue processValueForAutoLayout = new DynamicMetadataService.FlowElementReferenceOrValue();
    processValueForAutoLayout.stringValue = 'LightningFlowBuilder';

    DynamicMetadataService.FlowMetadataValue flowProcessValues = new DynamicMetadataService.FlowMetadataValue();
    flowProcessValues.name = 'BuilderType';
    flowProcessValues.value = processValue;
    flowProcessValuesList.add(flowProcessValues);

    DynamicMetadataService.FlowMetadataValue flowProcessValuesForCanvas = new DynamicMetadataService.FlowMetadataValue();
    flowProcessValuesForCanvas.name = 'BuilderType';
    flowProcessValuesForCanvas.value = processValueForCanvas;
    flowProcessValuesList.add(flowProcessValuesForCanvas);

    DynamicMetadataService.FlowMetadataValue flowProcessForAutoLayoutValues = new DynamicMetadataService.FlowMetadataValue();
    flowProcessForAutoLayoutValues.name = 'OriginBuilderType';
    flowProcessForAutoLayoutValues.value = processValueForAutoLayout;
    flowProcessValuesList.add(flowProcessForAutoLayoutValues);
    flow.processMetadataValues = flowProcessValuesList;

    DynamicMetadataService.FlowStart start = new DynamicMetadataService.FlowStart();
    start.locationX = 50;
    start.locationY = 0;
    start.object_x = objName;
    start.triggerType = 'RecordAfterSave';
    start.recordTriggerType = 'CreateAndUpdate';

    DynamicMetadataService.FlowConnector connect2 = new DynamicMetadataService.FlowConnector();
    connect2.targetReference = 'multiChoiceHandler';
    start.connector = connect2;
    flow.start = start;

    // create apex call
    List<DynamicMetadataService.FlowActionCall> flowactioncall = new List<DynamicMetadataService.FlowActionCall>();
    DynamicMetadataService.FlowActionCall action = new DynamicMetadataService.FlowActionCall();
    action.name = 'multiChoiceHandler';
    action.label = 'multiChoiceHandler';
    action.locationX = 179;
    action.locationY = 562;
    action.actionName = 'MultiChoiceHandler';
    action.actionType = 'apex';

    List<DynamicMetadataService.FlowDataTypeMapping> flowdatatypeList = new List<DynamicMetadataService.FlowDataTypeMapping>();
    DynamicMetadataService.FlowDataTypeMapping flowdata1 = new DynamicMetadataService.FlowDataTypeMapping();
    flowdata1.typeName = 'T__priorRecord';
    flowdata1.typeValue = objName;

    DynamicMetadataService.FlowDataTypeMapping flowdata2 = new DynamicMetadataService.FlowDataTypeMapping();
    flowdata2.typeName = 'T__record';
    flowdata2.typeValue = objName;
    flowdatatypeList.add(flowdata1);
    flowdatatypeList.add(flowdata2);
    action.dataTypeMappings = flowdatatypeList;
    action.flowTransactionModel = 'CurrentTransaction';

    List<DynamicMetadataService.FlowActionCallInputParameter> inputs = new List<DynamicMetadataService.FlowActionCallInputParameter>();
    DynamicMetadataService.FlowActionCallInputParameter inputValue1 = new DynamicMetadataService.FlowActionCallInputParameter();
    inputValue1.name = 'priorRecord';

    DynamicMetadataService.FlowActionCallInputParameter inputValue2 = new DynamicMetadataService.FlowActionCallInputParameter();
    inputValue2.name = 'record';

    DynamicMetadataService.FlowElementReferenceOrValue valueNew = new DynamicMetadataService.FlowElementReferenceOrValue();
    valueNew.elementReference = '$Record__Prior';
    inputValue1.value = valueNew;

    DynamicMetadataService.FlowElementReferenceOrValue valueNew2 = new DynamicMetadataService.FlowElementReferenceOrValue();
    valueNew2.elementReference = '$Record';
    inputValue2.value = valueNew2;

    inputs.add(inputValue1);
    inputs.add(inputValue2);
    action.inputParameters = inputs;
    flowactioncall.add(action);
    flow.actionCalls = flowactioncall;
    handleSaveResults(
      service.createMetadata(
        new List<DynamicMetadataService.Metadata>{ flow }
      )[0]
    );
    }
    return flowName;
  }

  /** @description This method is used to create custom metadata type
   *  @param metadataName String, label String, metadataFieldValueMap Map<String,String>
   *  @return void */
  @AuraEnabled
  public static void createCustomMetadata(
    String metdataName,
    String label,
    Map<String, String> metadataFieldValueMap,
    Boolean isDeleteable,
    Boolean isControllingFieldNotNeeded
  ) {
    try {
      String objNameNew;
      if (label.endsWithIgnoreCase('__c')) {
        objNameNew = label.replace('__c', '');
      } else {
        objNameNew = label;
      }
      String recordDevName = objNameNew.replaceAll(' ', '_');
      Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
      cMetadata.fullName = metdataName + '.' + recordDevName;
      cMetadata.label = label;
      for (String key : metadataFieldValueMap.keySet()) {
        Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
        cMetadataValue.Field = key;
        cMetadataValue.Value = metadataFieldValueMap.get(key);
        cMetadata.values.add(cMetadataValue);
      }

      Metadata.CustomMetadataValue isDeleteValue = new Metadata.CustomMetadataValue();
      isDeleteValue.Field = 'isDeleteable__c';
      isDeleteValue.Value = isDeleteable;
      cMetadata.values.add(isDeleteValue);

      Metadata.CustomMetadataValue isControllingNeeded = new Metadata.CustomMetadataValue();
      isControllingNeeded.Field = 'isControllingNeeded__c';
      isControllingNeeded.Value = !isControllingFieldNotNeeded;
      cMetadata.values.add(isControllingNeeded);

      Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
      mdContainer.addMetadata(cMetadata);
      DynamicApexController callback = new DynamicApexController();
      if (Test.isRunningTest() == false) {
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
      }
    } catch (Exception e) {
      String classMethodName = 'DynamicApexController.createCustomMetadata()';
      try {
        //  // CustomExceptionHandler.exceptionHandler(e, classMethodName);
      } catch (Exception er) {
        if (!Test.isRunningTest()) {
          //throw new AuraHandledException(er.getMessage()+' in '+classMethodName);
        }
      }
    }
  }

  /** @description This method is used to handle the deployment result of custom metadata type
   *  @param result Metadata.DeployResult, context Metadata.DeployCallbackContext
   *  @return void */
  public void handleResult(
    Metadata.DeployResult result,
    Metadata.DeployCallbackContext context
  ) {
    if (result.status == Metadata.DeployStatus.Succeeded) {
    } else {
    }
  }

  /** @description This method is used to establish a connection with Metadata Api
   *  @param
   *  @return DynamicMetadataService.MetadataPort */
  public static DynamicMetadataService.MetadataPort createService() {
    try {
      DynamicMetadataService.MetadataPort service = new DynamicMetadataService.MetadataPort();
      service.SessionHeader = new DynamicMetadataService.SessionHeader_element();
      service.SessionHeader.sessionId = SessionIdHelper.getCurrentUserSessionId();
      return service;
    } catch (Exception e) {
      String classMethodName = 'DynamicApexController.createService()';
      //  // CustomExceptionHandler.exceptionHandler(e, classMethodName);
      return null;
    }
  }

  public static void handleSaveResults(
    DynamicMetadataService.SaveResult saveResult
  ) {
    if (saveResult == null || saveResult.success)
      return;
    if (saveResult.errors != null) {
      List<String> messages = new List<String>();
      messages.add(
        (saveResult.errors.size() == 1 ? 'Error ' : 'Errors ') +
          'occured processing component ' +
          saveResult.fullName +
          '.'
      );
      for (DynamicMetadataService.Error error : saveResult.errors)
        messages.add(
          error.message +
            ' (' +
            error.statusCode +
            ').' +
            (error.fields != null &&
              error.fields.size() > 0
              ? ' Fields ' + String.join(error.fields, ',') + '.'
              : '')
        );
      if (messages.size() > 0)
        if (!test.isRunningTest()) {
          throw new DynamicUtilityControllerException(
            String.join(messages, ' ')
          );
        }
    }
    if (!saveResult.success)
      if (!test.isRunningTest()) {
        throw new DynamicUtilityControllerException(
          'Request failed with no specified error.'
        );
      }
  }

  /** @description This method is used to handle upsert of Metadata records
   *  @param upsertResult DynamicMetadataService.UpsertResult
   *  @return void */
  public static void handleUpsertResults(
    DynamicMetadataService.UpsertResult upsertResult
  ) {
    if (upsertResult == null || upsertResult.success)
      return;
    if (upsertResult.errors != null) {
      List<String> messages = new List<String>();
      messages.add(
        (upsertResult.errors.size() == 1 ? 'Error ' : 'Errors ') +
          'occured processing component ' +
          upsertResult.fullName +
          '.'
      );
      for (DynamicMetadataService.Error error : upsertResult.errors)
        messages.add(
          error.message +
            ' (' +
            error.statusCode +
            ').' +
            (error.fields != null &&
              error.fields.size() > 0
              ? ' Fields ' + String.join(error.fields, ',') + '.'
              : '')
        );
      if (messages.size() > 0) {
        if (!test.isRunningTest()) {
          throw new DynamicUtilityControllerException(
            String.join(messages, ' ')
          );
        }
      }

      if (!upsertResult.success) {
        if (!test.isRunningTest()) {
          throw new DynamicUtilityControllerException(
            String.join(messages, ' ')
          );
        }
      }
    }
  }
}
