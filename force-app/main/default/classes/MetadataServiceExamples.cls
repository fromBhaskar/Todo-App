public with sharing class MetadataServiceExamples {
  // MetadataServiceExamples.deleteFlow();

  // MetadataServiceExamples.deleteFlow('ContactMultiChoiceHandler');
  @AuraEnabled
  public static void deleteFlow(String flowName) {
    MetadataService.MetadataPort service = createService();

    // Delete Flow
    handleDeleteResults(
      service.deleteMetadata('Flow', new List<String>{ flowName })[0]
    );
  }

  // MetadataServiceExamples.createObject('Account');
  public static String createObject(String objName) {
    List<SObject> sObjList;
    String customObjName = 'MP_' + objName.replaceAll('__c', '') + '__c';
    try {
      sObjList = Database.query('select id from ' + customObjName);
      System.debug(sObjList);
    } catch (System.QueryException e) {
      System.debug(e.getMessage());
    }
    if (sObjList == null) {
      MetadataService.MetadataPort service = createService();
      MetadataService.CustomObject customObject = new MetadataService.CustomObject();
      customObject.fullName = customObjName;
      customObject.label = objName.replaceAll('__c', '') + ' Picklist Values';
      customObject.pluralLabel =
        objName.replaceAll('__c', '') + ' Picklist Values';
      customObject.nameField = new MetadataService.CustomField();
      customObject.nameField.type_x = 'Text';
      customObject.nameField.label = 'MultiChoice Number';
      customObject.enableReports = true;
      customObject.deploymentStatus = 'Deployed';
      customObject.sharingModel = 'ReadWrite';
      List<MetadataService.SaveResult> results = service.createMetadata(
        new List<MetadataService.Metadata>{ customObject }
      );
      if (results[0] == null || results[0].success) {
        createLookupField(
          customObject.fullName,
          objName,
          objName.replaceAll('__c', '') + 'MPTypes'
        );
        createField(customObject.fullName, 'MP Type', 'MP_Type__c');
        createField(customObject.fullName, 'Value', 'MP_Value__c');

        DynamicApexController.assignPermissionsToAdmin(
          customObject.fullName,
          new List<String>{ 'MP_Type__c', 'MP_Value__c' }
        );
      }
      handleSaveResults(results[0]);
    }
    return customObjName;
  }

  public static void createLookupField(
    String objName,
    String parentObj,
    String lookupField
  ) {
    MetadataService.MetadataPort service = createService();
    MetadataService.CustomField customField = new MetadataService.CustomField();
    customField.fullName = objName + '.' + objName;
    customField.label = lookupField;
    customField.type_x = 'MasterDetail';
    customField.relationshipLabel = lookupField;
    customField.relationshipName = lookupField;
    customField.referenceTo = parentObj;
    List<MetadataService.SaveResult> results = service.createMetadata(
      new List<MetadataService.Metadata>{ customField }
    );

    handleSaveResults(results[0]);
  }

  public static void createField(
    String objName,
    String fieldlabel,
    String fieldApiName
  ) {
    MetadataService.MetadataPort service = createService();
    MetadataService.CustomField customField = new MetadataService.CustomField();
    customField.fullName = objName + '.' + fieldApiName;
    customField.label = fieldlabel;
    customField.type_x = 'Text';
    customField.length = 255;
    List<MetadataService.SaveResult> results = service.createMetadata(
      new List<MetadataService.Metadata>{ customField }
    );
    handleSaveResults(results[0]);
  }

  public class MetadataServiceExamplesException extends Exception {
  }

  public static MetadataService.MetadataPort createService() {
    MetadataService.MetadataPort service = new MetadataService.MetadataPort();
    service.SessionHeader = new MetadataService.SessionHeader_element();
    service.SessionHeader.sessionId = SessionIdHelper.getCurrentUserSessionId();
    return service;
  }

  /**
   * Example helper method to interpret a SaveResult, throws an exception if errors are found
   **/
  public static void handleSaveResults(MetadataService.SaveResult saveResult) {
    // Nothing to see?
    if (saveResult == null || saveResult.success)
      return;
    // Construct error message and throw an exception
    if (saveResult.errors != null) {
      List<String> messages = new List<String>();
      messages.add(
        (saveResult.errors.size() == 1 ? 'Error ' : 'Errors ') +
          'occured processing component ' +
          saveResult.fullName +
          '.'
      );
      for (MetadataService.Error error : saveResult.errors)
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
        throw new MetadataServiceExamplesException(String.join(messages, ' '));
    }
    if (!saveResult.success)
      throw new MetadataServiceExamplesException(
        'Request failed with no specified error.'
      );
  }

  /**
   * Example helper method to interpret a SaveResult, throws an exception if errors are found
   **/
  public static void handleDeleteResults(
    MetadataService.DeleteResult deleteResult
  ) {
    // Nothing to see?
    if (deleteResult == null || deleteResult.success)
      return;
    // Construct error message and throw an exception
    if (deleteResult.errors != null) {
      List<String> messages = new List<String>();
      messages.add(
        (deleteResult.errors.size() == 1 ? 'Error ' : 'Errors ') +
          'occured processing component ' +
          deleteResult.fullName +
          '.'
      );
      for (MetadataService.Error error : deleteResult.errors)
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
        throw new MetadataServiceExamplesException(String.join(messages, ' '));
    }
    if (!deleteResult.success)
      throw new MetadataServiceExamplesException(
        'Request failed with no specified error.'
      );
  }

  /**
   * Example helper method to interpret a UpsertResult, throws an exception if errors are found
   **/
  public static void handleUpsertResults(
    MetadataService.UpsertResult upsertResult
  ) {
    // Nothing to see?
    if (upsertResult == null || upsertResult.success)
      return;
    // Construct error message and throw an exception
    if (upsertResult.errors != null) {
      List<String> messages = new List<String>();
      messages.add(
        (upsertResult.errors.size() == 1 ? 'Error ' : 'Errors ') +
          'occured processing component ' +
          upsertResult.fullName +
          '.'
      );
      for (MetadataService.Error error : upsertResult.errors)
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
        throw new MetadataServiceExamplesException(String.join(messages, ' '));
    }
    if (!upsertResult.success)
      throw new MetadataServiceExamplesException(
        'Request failed with no specified error.'
      );
  }

  // MetadataServiceExamples.createObject();
}
