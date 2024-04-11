/*******************************************************************************************
/******************************************************************************************** 
* @Name         DynamicMetadataService 
* @Author       Erudite Works Pvt Ltd
* @Date         08/06/2023
* @description  This class handles all the callouts required for creating dynamic metadata,
                includes: custom fields, record types, page layouts, flows, report type. '
                It also allows to handle functionalities like assigning field permissions,
                assign record type to page layout.
*               
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0             Erudite Works Pvt Ltd        08/06/2023         Initial Development
*******************************************************************************************/
public with sharing class DynamicMetadataService {
    public static String SOAP_M_URI = 'http://soap.sforce.com/2006/04/metadata';

/** @description : Wrapper class to handle column translation in Report Type**/
public class ReportTypeColumnTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}

/** @description : Wrapper class to handle report filter item in Report Type**/    
public class ReportFilterItem {
    public String column;
    public Boolean columnToColumn;
    public Boolean isUnlocked;
    public String operator;
    public String snapshot;
    public String value;
    private String[] column_type_info = new String[]{'column',SOAP_M_URI,null,'1','1','false'};
    private String[] columnToColumn_type_info = new String[]{'columnToColumn',SOAP_M_URI,null,'0','1','false'};
    private String[] isUnlocked_type_info = new String[]{'isUnlocked',SOAP_M_URI,null,'0','1','false'};
    private String[] operator_type_info = new String[]{'operator',SOAP_M_URI,null,'1','1','false'};
    private String[] snapshot_type_info = new String[]{'snapshot',SOAP_M_URI,null,'0','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'column','columnToColumn','isUnlocked','operator','snapshot','value'};
}

/** @description : Wrapper class to handle element reference or value in flow**/
public class FlowElementReferenceOrValue {
    public Boolean booleanValue;
    public DateTime dateTimeValue;
    public Date dateValue;
    public String elementReference;
    public Double numberValue;
    public String stringValue;
    private String[] booleanValue_type_info = new String[]{'booleanValue',SOAP_M_URI,null,'0','1','true'};
    private String[] dateTimeValue_type_info = new String[]{'dateTimeValue',SOAP_M_URI,null,'0','1','false'};
    private String[] dateValue_type_info = new String[]{'dateValue',SOAP_M_URI,null,'0','1','false'};
    private String[] elementReference_type_info = new String[]{'elementReference',SOAP_M_URI,null,'0','1','false'};
    private String[] numberValue_type_info = new String[]{'numberValue',SOAP_M_URI,null,'0','1','true'};
    private String[] stringValue_type_info = new String[]{'stringValue',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'booleanValue','dateTimeValue','dateValue','elementReference','numberValue','stringValue'};
}

/** @description : Wrapper class to handle wait event output parameter in flow**/
public class FlowWaitEventOutputParameter extends FlowBaseElement {
    public String type = 'FlowWaitEventOutputParameter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String assignToReference;
    public String name;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'assignToReference','name'};
}



/** @description : Wrapper class to handle the results returned by create, update metadata**/
public class SaveResult {
    public DynamicMetadataService.Error[] errors;
    public String fullName;
    public Boolean success;
    private String[] errors_type_info = new String[]{'errors',SOAP_M_URI,null,'0','-1','false'};
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'1','1','false'};
    private String[] success_type_info = new String[]{'success',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'errors','fullName','success'};
}

/** @description : Wrapper class to handle extended error details in MetaData deployment**/
public class ExtendedErrorDetails {
    public String extendedErrorCode;
    private String[] extendedErrorCode_type_info = new String[]{'extendedErrorCode',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'extendedErrorCode'};
}

/** @description : Wrapper class to establish session settings in MetaData deployment**/
public class SessionSettings {
    public Boolean disableTimeoutWarning;
    public Boolean enableCSPOnEmail;
    public Boolean enableCSRFOnGet;
    public Boolean enableCSRFOnPost;
    public Boolean enableCacheAndAutocomplete;
    public Boolean enableClickjackNonsetupSFDC;
    public Boolean enableClickjackNonsetupUser;
    public Boolean enableClickjackNonsetupUserHeaderless;
    public Boolean enableClickjackSetup;
    public Boolean enableContentSniffingProtection;
    public Boolean enablePostForSessions;
    public Boolean enableSMSIdentity;
    public Boolean enableUpgradeInsecureRequests;
    public Boolean enableXssProtection;
    public Boolean enforceIpRangesEveryRequest;
    public Boolean forceLogoutOnSessionTimeout;
    public Boolean forceRelogin;
    public Boolean hstsOnForcecomSites;
    public Boolean identityConfirmationOnEmailChange;
    public Boolean identityConfirmationOnTwoFactorRegistrationEnabled;
    public Boolean lockSessionsToDomain;
    public Boolean lockSessionsToIp;
    public String logoutURL;
    public Boolean redirectionWarning;
    public Boolean referrerPolicy;
    public Boolean requireHttpOnly;
    public Boolean requireHttps;
    public Boolean securityCentralKillSession;
    public String sessionTimeout;
    private String[] disableTimeoutWarning_type_info = new String[]{'disableTimeoutWarning',SOAP_M_URI,null,'0','1','false'};
    private String[] enableCSPOnEmail_type_info = new String[]{'enableCSPOnEmail',SOAP_M_URI,null,'0','1','false'};
    private String[] enableCSRFOnGet_type_info = new String[]{'enableCSRFOnGet',SOAP_M_URI,null,'0','1','false'};
    private String[] enableCSRFOnPost_type_info = new String[]{'enableCSRFOnPost',SOAP_M_URI,null,'0','1','false'};
    private String[] enableCacheAndAutocomplete_type_info = new String[]{'enableCacheAndAutocomplete',SOAP_M_URI,null,'0','1','false'};
    private String[] enableClickjackNonsetupSFDC_type_info = new String[]{'enableClickjackNonsetupSFDC',SOAP_M_URI,null,'0','1','false'};
    private String[] enableClickjackNonsetupUser_type_info = new String[]{'enableClickjackNonsetupUser',SOAP_M_URI,null,'0','1','false'};
    private String[] enableClickjackNonsetupUserHeaderless_type_info = new String[]{'enableClickjackNonsetupUserHeaderless',SOAP_M_URI,null,'0','1','false'};
    private String[] enableClickjackSetup_type_info = new String[]{'enableClickjackSetup',SOAP_M_URI,null,'0','1','false'};
    private String[] enableContentSniffingProtection_type_info = new String[]{'enableContentSniffingProtection',SOAP_M_URI,null,'0','1','false'};
    private String[] enablePostForSessions_type_info = new String[]{'enablePostForSessions',SOAP_M_URI,null,'0','1','false'};
    private String[] enableSMSIdentity_type_info = new String[]{'enableSMSIdentity',SOAP_M_URI,null,'0','1','false'};
    private String[] enableUpgradeInsecureRequests_type_info = new String[]{'enableUpgradeInsecureRequests',SOAP_M_URI,null,'0','1','false'};
    private String[] enableXssProtection_type_info = new String[]{'enableXssProtection',SOAP_M_URI,null,'0','1','false'};
    private String[] enforceIpRangesEveryRequest_type_info = new String[]{'enforceIpRangesEveryRequest',SOAP_M_URI,null,'0','1','false'};
    private String[] forceLogoutOnSessionTimeout_type_info = new String[]{'forceLogoutOnSessionTimeout',SOAP_M_URI,null,'0','1','false'};
    private String[] forceRelogin_type_info = new String[]{'forceRelogin',SOAP_M_URI,null,'0','1','false'};
    private String[] hstsOnForcecomSites_type_info = new String[]{'hstsOnForcecomSites',SOAP_M_URI,null,'0','1','false'};
    private String[] identityConfirmationOnEmailChange_type_info = new String[]{'identityConfirmationOnEmailChange',SOAP_M_URI,null,'0','1','false'};
    private String[] identityConfirmationOnTwoFactorRegistrationEnabled_type_info = new String[]{'identityConfirmationOnTwoFactorRegistrationEnabled',SOAP_M_URI,null,'0','1','false'};
    private String[] lockSessionsToDomain_type_info = new String[]{'lockSessionsToDomain',SOAP_M_URI,null,'0','1','false'};
    private String[] lockSessionsToIp_type_info = new String[]{'lockSessionsToIp',SOAP_M_URI,null,'0','1','false'};
    private String[] logoutURL_type_info = new String[]{'logoutURL',SOAP_M_URI,null,'0','1','false'};
    private String[] redirectionWarning_type_info = new String[]{'redirectionWarning',SOAP_M_URI,null,'0','1','false'};
    private String[] referrerPolicy_type_info = new String[]{'referrerPolicy',SOAP_M_URI,null,'0','1','false'};
    private String[] requireHttpOnly_type_info = new String[]{'requireHttpOnly',SOAP_M_URI,null,'0','1','false'};
    private String[] requireHttps_type_info = new String[]{'requireHttps',SOAP_M_URI,null,'0','1','false'};
    private String[] securityCentralKillSession_type_info = new String[]{'securityCentralKillSession',SOAP_M_URI,null,'0','1','false'};
    private String[] sessionTimeout_type_info = new String[]{'sessionTimeout',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'disableTimeoutWarning','enableCSPOnEmail','enableCSRFOnGet','enableCSRFOnPost','enableCacheAndAutocomplete','enableClickjackNonsetupSFDC','enableClickjackNonsetupUser','enableClickjackNonsetupUserHeaderless','enableClickjackSetup','enableContentSniffingProtection','enablePostForSessions','enableSMSIdentity','enableUpgradeInsecureRequests','enableXssProtection','enforceIpRangesEveryRequest','forceLogoutOnSessionTimeout','forceRelogin','hstsOnForcecomSites','identityConfirmationOnEmailChange','identityConfirmationOnTwoFactorRegistrationEnabled','lockSessionsToDomain','lockSessionsToIp','logoutURL','redirectionWarning','referrerPolicy','requireHttpOnly','requireHttps','securityCentralKillSession','sessionTimeout'};
}

/** @description : Wrapper class to read metadata response in MetaData deployment**/
public class readMetadataResponse_element {
    public DynamicMetadataService.ReadResult result;
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to manage mini layout of page layout**/
public class MiniLayout {
    public String[] fields;
    public DynamicMetadataService.RelatedListItem[] relatedLists;
    private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
    private String[] relatedLists_type_info = new String[]{'relatedLists',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'fields','relatedLists'};
}

/** @description : Wrapper class to handle field value**/
public class FieldValue {
    public String name;
    public String value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'1','1','true'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'name','value'};
}

/** @description : Wrapper class to handle upsert result in MetaData deployment**/
public class UpsertResult {
    public Boolean created;
    public DynamicMetadataService.Error[] errors;
    public String fullName;
    public Boolean success;
    private String[] created_type_info = new String[]{'created',SOAP_M_URI,null,'1','1','false'};
    private String[] errors_type_info = new String[]{'errors',SOAP_M_URI,null,'0','-1','false'};
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'1','1','false'};
    private String[] success_type_info = new String[]{'success',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'created','errors','fullName','success'};
}

 /** @description : Wrapper class to handle delete results in MetaData deployment**/
 public class DeleteResult {
    public DynamicMetadataService.Error[] errors;
    public String fullName;
    public Boolean success;
    private String[] errors_type_info = new String[]{'errors',SOAP_M_URI,null,'0','-1','false'};
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'1','1','false'};
    private String[] success_type_info = new String[]{'success',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'errors','fullName','success'};
}

/** @description : Wrapper class to handle report parameters in report type**/
public class ReportParam {
    public String name;
    public String value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'name','value'};
}

/** @description : Wrapper class to handle related list item in page layout**/
public class RelatedListItem {
    public String[] customButtons;
    public String[] excludeButtons;
    public String[] fields;
    public String relatedList;
    public String sortField;
    public String sortOrder;
    private String[] customButtons_type_info = new String[]{'customButtons',SOAP_M_URI,null,'0','-1','false'};
    private String[] excludeButtons_type_info = new String[]{'excludeButtons',SOAP_M_URI,null,'0','-1','false'};
    private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
    private String[] relatedList_type_info = new String[]{'relatedList',SOAP_M_URI,null,'1','1','false'};
    private String[] sortField_type_info = new String[]{'sortField',SOAP_M_URI,null,'0','1','false'};
    private String[] sortOrder_type_info = new String[]{'sortOrder',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'customButtons','excludeButtons','fields','relatedList','sortField','sortOrder'};
}

/** @description : Wrapper class to describe the metadata object**/
public class DescribeMetadataObject {
    public String[] childXmlNames;
    public String directoryName;
    public Boolean inFolder;
    public Boolean metaFile;
    public String suffix;
    public String xmlName;
    private String[] childXmlNames_type_info = new String[]{'childXmlNames',SOAP_M_URI,null,'0','-1','false'};
    private String[] directoryName_type_info = new String[]{'directoryName',SOAP_M_URI,null,'1','1','false'};
    private String[] inFolder_type_info = new String[]{'inFolder',SOAP_M_URI,null,'1','1','false'};
    private String[] metaFile_type_info = new String[]{'metaFile',SOAP_M_URI,null,'1','1','false'};
    private String[] suffix_type_info = new String[]{'suffix',SOAP_M_URI,null,'0','1','false'};
    private String[] xmlName_type_info = new String[]{'xmlName',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'childXmlNames','directoryName','inFolder','metaFile','suffix','xmlName'};
}

/** @description : Wrapper class to handle All or None Header element**/
public class AllOrNoneHeader_element {
    public Boolean allOrNone;
    private String[] allOrNone_type_info = new String[]{'allOrNone',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'allOrNone'};
}

/** @description : Wrapper class to handle category item in flow**/
public class FlowCategoryItems {
    public String flow;
    private String[] flow_type_info = new String[]{'flow',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'flow'};
}

/** @description : Wrapper class to handle record delete in flow**/
public class FlowRecordDelete extends FlowNode {
    public String type = 'FlowRecordDelete';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowRecordFilter[] filters;
    public String inputReference;
    public String object_x;
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] filters_type_info = new String[]{'filters',SOAP_M_URI,null,'0','-1','false'};
    private String[] inputReference_type_info = new String[]{'inputReference',SOAP_M_URI,null,'0','1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'connector','faultConnector','filters','inputReference','object_x'};
}

/** @description : Wrapper class to handle screenfield translation in flow**/
public class FlowScreenFieldTranslation {
    public String fieldText;
    public String helpText;
    public String name;
    public DynamicMetadataService.FlowInputValidationRuleTranslation validationRule;
    private String[] fieldText_type_info = new String[]{'fieldText',SOAP_M_URI,null,'0','1','false'};
    private String[] helpText_type_info = new String[]{'helpText',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] validationRule_type_info = new String[]{'validationRule',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'fieldText','helpText','name','validationRule'};
}

/** @description : Wrapper class to handle console components in page layout**/
public class CustomConsoleComponents {
    public DynamicMetadataService.PrimaryTabComponents primaryTabComponents;
    public DynamicMetadataService.SubtabComponents subtabComponents;
    private String[] primaryTabComponents_type_info = new String[]{'primaryTabComponents',SOAP_M_URI,null,'0','1','false'};
    private String[] subtabComponents_type_info = new String[]{'subtabComponents',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'primaryTabComponents','subtabComponents'};
}

/** @description : Wrapper class to handle tab components in page layout**/
public class PrimaryTabComponents {
    public DynamicMetadataService.Container[] containers;
    private String[] containers_type_info = new String[]{'containers',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'containers'};
}

/** @description : Wrapper class to handle Subtab components in page layout**/
public class SubtabComponents {
    public DynamicMetadataService.Container[] containers;
    private String[] containers_type_info = new String[]{'containers',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'containers'};
}

/** @description : Wrapper class to handle container in page layout**/
public class Container {
    public Integer height;
    public Boolean isContainerAutoSizeEnabled;
    public String region;
    public DynamicMetadataService.SidebarComponent[] sidebarComponents;
    public String style;
    public String unit;
    public Integer width;
    private String[] height_type_info = new String[]{'height',SOAP_M_URI,null,'0','1','false'};
    private String[] isContainerAutoSizeEnabled_type_info = new String[]{'isContainerAutoSizeEnabled',SOAP_M_URI,null,'1','1','false'};
    private String[] region_type_info = new String[]{'region',SOAP_M_URI,null,'1','1','false'};
    private String[] sidebarComponents_type_info = new String[]{'sidebarComponents',SOAP_M_URI,null,'0','-1','false'};
    private String[] style_type_info = new String[]{'style',SOAP_M_URI,null,'1','1','false'};
    private String[] unit_type_info = new String[]{'unit',SOAP_M_URI,null,'1','1','false'};
    private String[] width_type_info = new String[]{'width',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'height','isContainerAutoSizeEnabled','region','sidebarComponents','style','unit','width'};
}

/** @description : Wrapper class to handle sidebar components in page layout**/
public class SidebarComponent {
    public String componentType;
    public String createAction;
    public Boolean enableLinking;
    public Integer height;
    public String label;
    public String lookup;
    public String page_x;
    public DynamicMetadataService.RelatedList[] relatedLists;
    public String unit;
    public String updateAction;
    public Integer width;
    private String[] componentType_type_info = new String[]{'componentType',SOAP_M_URI,null,'1','1','false'};
    private String[] createAction_type_info = new String[]{'createAction',SOAP_M_URI,null,'0','1','false'};
    private String[] enableLinking_type_info = new String[]{'enableLinking',SOAP_M_URI,null,'0','1','false'};
    private String[] height_type_info = new String[]{'height',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] lookup_type_info = new String[]{'lookup',SOAP_M_URI,null,'0','1','false'};
    private String[] page_x_type_info = new String[]{'page',SOAP_M_URI,null,'0','1','false'};
    private String[] relatedLists_type_info = new String[]{'relatedLists',SOAP_M_URI,null,'0','-1','false'};
    private String[] unit_type_info = new String[]{'unit',SOAP_M_URI,null,'0','1','false'};
    private String[] updateAction_type_info = new String[]{'updateAction',SOAP_M_URI,null,'0','1','false'};
    private String[] width_type_info = new String[]{'width',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'componentType','createAction','enableLinking','height','label','lookup','page_x','relatedLists','unit','updateAction','width'};
}

/** @description : Wrapper class to handle platform action list**/
public class PlatformActionList {
    public String actionListContext;
    public DynamicMetadataService.PlatformActionListItem[] platformActionListItems;
    public String relatedSourceEntity;
    private String[] actionListContext_type_info = new String[]{'actionListContext',SOAP_M_URI,null,'1','1','false'};
    private String[] platformActionListItems_type_info = new String[]{'platformActionListItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] relatedSourceEntity_type_info = new String[]{'relatedSourceEntity',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'actionListContext','platformActionListItems','relatedSourceEntity'};
}

/** @description : Wrapper class to handle platform action list item**/
public class PlatformActionListItem {
    public String actionName;
    public String actionType;
    public Integer sortOrder;
    public String subtype;
    private String[] actionName_type_info = new String[]{'actionName',SOAP_M_URI,null,'1','1','false'};
    private String[] actionType_type_info = new String[]{'actionType',SOAP_M_URI,null,'1','1','false'};
    private String[] sortOrder_type_info = new String[]{'sortOrder',SOAP_M_URI,null,'1','1','false'};
    private String[] subtype_type_info = new String[]{'subtype',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'actionName','actionType','sortOrder','subtype'};
}

/** @description : Wrapper class to handle quick action list in page layout**/
public class QuickActionList {
    public DynamicMetadataService.QuickActionListItem[] quickActionListItems;
    private String[] quickActionListItems_type_info = new String[]{'quickActionListItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'quickActionListItems'};
}

/** @description : Wrapper class to handle quick action list item in page layout**/
public class QuickActionListItem {
    public String quickActionName;
    private String[] quickActionName_type_info = new String[]{'quickActionName',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'quickActionName'};
}

/** @description : Wrapper class to handle flow translation**/
public class FlowTranslation {
    public DynamicMetadataService.FlowChoiceTranslation[] choices;
    public String fullName;
    public String label;
    public DynamicMetadataService.FlowScreenTranslation[] screens;
    private String[] choices_type_info = new String[]{'choices',SOAP_M_URI,null,'0','-1','false'};
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'1','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] screens_type_info = new String[]{'screens',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'choices','fullName','label','screens'};
}

/** @description : Wrapper class to create page layout**/
public class Layout extends Metadata {
    public String type = 'Layout';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public String[] customButtons;
    public DynamicMetadataService.CustomConsoleComponents customConsoleComponents;
    public Boolean emailDefault;
    public String[] excludeButtons;
    public DynamicMetadataService.FeedLayout feedLayout;
    public String[] headers;
    public DynamicMetadataService.LayoutSection[] layoutSections;
    public DynamicMetadataService.MiniLayout miniLayout;
    public String[] multilineLayoutFields;
    public DynamicMetadataService.PlatformActionList platformActionList;
    public DynamicMetadataService.QuickActionList quickActionList;
    public DynamicMetadataService.RelatedContent relatedContent;
    public DynamicMetadataService.RelatedListItem[] relatedLists;
    public String[] relatedObjects;
    public Boolean runAssignmentRulesDefault;
    public Boolean showEmailCheckbox;
    public Boolean showHighlightsPanel;
    public Boolean showInteractionLogPanel;
    public Boolean showKnowledgeComponent;
    public Boolean showRunAssignmentRulesCheckbox;
    public Boolean showSolutionSection;
    public Boolean showSubmitAndAttachButton;
    public DynamicMetadataService.SummaryLayout summaryLayout;
    private String[] customButtons_type_info = new String[]{'customButtons',SOAP_M_URI,null,'0','-1','false'};
    private String[] customConsoleComponents_type_info = new String[]{'customConsoleComponents',SOAP_M_URI,null,'0','1','false'};
    private String[] emailDefault_type_info = new String[]{'emailDefault',SOAP_M_URI,null,'0','1','false'};
    private String[] excludeButtons_type_info = new String[]{'excludeButtons',SOAP_M_URI,null,'0','-1','false'};
    private String[] feedLayout_type_info = new String[]{'feedLayout',SOAP_M_URI,null,'0','1','false'};
    private String[] headers_type_info = new String[]{'headers',SOAP_M_URI,null,'0','-1','false'};
    private String[] layoutSections_type_info = new String[]{'layoutSections',SOAP_M_URI,null,'0','-1','false'};
    private String[] miniLayout_type_info = new String[]{'miniLayout',SOAP_M_URI,null,'0','1','false'};
    private String[] multilineLayoutFields_type_info = new String[]{'multilineLayoutFields',SOAP_M_URI,null,'0','-1','false'};
    private String[] platformActionList_type_info = new String[]{'platformActionList',SOAP_M_URI,null,'0','1','false'};
    private String[] quickActionList_type_info = new String[]{'quickActionList',SOAP_M_URI,null,'0','1','false'};
    private String[] relatedContent_type_info = new String[]{'relatedContent',SOAP_M_URI,null,'0','1','false'};
    private String[] relatedLists_type_info = new String[]{'relatedLists',SOAP_M_URI,null,'0','-1','false'};
    private String[] relatedObjects_type_info = new String[]{'relatedObjects',SOAP_M_URI,null,'0','-1','false'};
    private String[] runAssignmentRulesDefault_type_info = new String[]{'runAssignmentRulesDefault',SOAP_M_URI,null,'0','1','false'};
    private String[] showEmailCheckbox_type_info = new String[]{'showEmailCheckbox',SOAP_M_URI,null,'0','1','false'};
    private String[] showHighlightsPanel_type_info = new String[]{'showHighlightsPanel',SOAP_M_URI,null,'0','1','false'};
    private String[] showInteractionLogPanel_type_info = new String[]{'showInteractionLogPanel',SOAP_M_URI,null,'0','1','false'};
    private String[] showKnowledgeComponent_type_info = new String[]{'showKnowledgeComponent',SOAP_M_URI,null,'0','1','false'};
    private String[] showRunAssignmentRulesCheckbox_type_info = new String[]{'showRunAssignmentRulesCheckbox',SOAP_M_URI,null,'0','1','false'};
    private String[] showSolutionSection_type_info = new String[]{'showSolutionSection',SOAP_M_URI,null,'0','1','false'};
    private String[] showSubmitAndAttachButton_type_info = new String[]{'showSubmitAndAttachButton',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryLayout_type_info = new String[]{'summaryLayout',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'customButtons','customConsoleComponents','emailDefault','excludeButtons','feedLayout','headers','layoutSections','miniLayout','multilineLayoutFields','platformActionList','quickActionList','relatedContent','relatedLists','relatedObjects','runAssignmentRulesDefault','showEmailCheckbox','showHighlightsPanel','showInteractionLogPanel','showKnowledgeComponent','showRunAssignmentRulesCheckbox','showSolutionSection','showSubmitAndAttachButton','summaryLayout'};
}

/** @description : Wrapper class to handle definition translation in flow**/
public class FlowDefinitionTranslation {
    public DynamicMetadataService.FlowTranslation[] flows;
    public String fullName;
    public String label;
    private String[] flows_type_info = new String[]{'flows',SOAP_M_URI,null,'0','-1','false'};
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'1','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'flows','fullName','label'};
}

/** @description : Wrapper class to handle flow wait event in flow**/
public class FlowWaitEvent extends FlowElement {
    public String type = 'FlowWaitEvent';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String conditionLogic;
    public DynamicMetadataService.FlowCondition[] conditions;
    public DynamicMetadataService.FlowConnector connector;
    public String eventType;
    public DynamicMetadataService.FlowWaitEventInputParameter[] inputParameters;
    public String label;
    public DynamicMetadataService.FlowWaitEventOutputParameter[] outputParameters;
    private String[] conditionLogic_type_info = new String[]{'conditionLogic',SOAP_M_URI,null,'0','1','false'};
    private String[] conditions_type_info = new String[]{'conditions',SOAP_M_URI,null,'0','-1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'1','1','false'};
    private String[] eventType_type_info = new String[]{'eventType',SOAP_M_URI,null,'1','1','false'};
    private String[] inputParameters_type_info = new String[]{'inputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] outputParameters_type_info = new String[]{'outputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'conditionLogic','conditions','connector','eventType','inputParameters','label','outputParameters'};
}

/** @description : Wrapper class to handle assignment component in flow**/
public class FlowAssignment extends FlowNode {
    public String type = 'FlowAssignment';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowAssignmentItem[] assignmentItems;
    public DynamicMetadataService.FlowConnector connector;
    private String[] assignmentItems_type_info = new String[]{'assignmentItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'assignmentItems','connector'};
}

/** @description : Wrapper class to handle input validation rule in flow**/
public class FlowInputValidationRule {
    public String errorMessage;
    public String formulaExpression;
    private String[] errorMessage_type_info = new String[]{'errorMessage',SOAP_M_URI,null,'1','1','false'};
    private String[] formulaExpression_type_info = new String[]{'formulaExpression',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'errorMessage','formulaExpression'};
}

/** @description : Wrapper class to handle screen field in flow**/
public class FlowScreenField extends FlowElement {
    public String type = 'FlowScreenField';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String[] choiceReferences;
    public String dataType;
    public String defaultSelectedChoiceReference;
    public DynamicMetadataService.FlowElementReferenceOrValue defaultValue;
    public String extensionName;
    public String fieldText;
    public String fieldType;
    public String helpText;
    public DynamicMetadataService.FlowScreenFieldInputParameter[] inputParameters;
    public Boolean isRequired;
    public Boolean isVisible;
    public DynamicMetadataService.FlowScreenFieldOutputParameter[] outputParameters;
    public Integer scale;
    public DynamicMetadataService.FlowInputValidationRule validationRule;
    private String[] choiceReferences_type_info = new String[]{'choiceReferences',SOAP_M_URI,null,'0','-1','false'};
    private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'0','1','false'};
    private String[] defaultSelectedChoiceReference_type_info = new String[]{'defaultSelectedChoiceReference',SOAP_M_URI,null,'0','1','false'};
    private String[] defaultValue_type_info = new String[]{'defaultValue',SOAP_M_URI,null,'0','1','false'};
    private String[] extensionName_type_info = new String[]{'extensionName',SOAP_M_URI,null,'0','1','false'};
    private String[] fieldText_type_info = new String[]{'fieldText',SOAP_M_URI,null,'0','1','false'};
    private String[] fieldType_type_info = new String[]{'fieldType',SOAP_M_URI,null,'1','1','false'};
    private String[] helpText_type_info = new String[]{'helpText',SOAP_M_URI,null,'0','1','false'};
    private String[] inputParameters_type_info = new String[]{'inputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] isRequired_type_info = new String[]{'isRequired',SOAP_M_URI,null,'0','1','false'};
    private String[] isVisible_type_info = new String[]{'isVisible',SOAP_M_URI,null,'0','1','false'};
    private String[] outputParameters_type_info = new String[]{'outputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] scale_type_info = new String[]{'scale',SOAP_M_URI,null,'0','1','false'};
    private String[] validationRule_type_info = new String[]{'validationRule',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'choiceReferences','dataType','defaultSelectedChoiceReference','defaultValue','extensionName','fieldText','fieldType','helpText','inputParameters','isRequired','isVisible','outputParameters','scale','validationRule'};
}

/** @description : Wrapper class to create custom metadata**/
public class CustomMetadata extends Metadata {
    public String type = 'CustomMetadata';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public String description;
    public String label;
    public Boolean protected_x;
    public DynamicMetadataService.CustomMetadataValue[] values;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] protected_x_type_info = new String[]{'protected',SOAP_M_URI,null,'0','1','false'};
    private String[] values_type_info = new String[]{'values',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'description','label','protected_x','values'};
}

/** @description : Wrapper class to handle flow node in flow**/
public virtual class FlowNode extends FlowElement {
    public String label;
    public Integer locationX;
    public Integer locationY;
}

/** @description : Wrapper class to handle time frame filter in report type**/
public class ReportTimeFrameFilter {
    public String dateColumn;
    public Date endDate;
    public String interval;
    public Date startDate;
    private String[] dateColumn_type_info = new String[]{'dateColumn',SOAP_M_URI,null,'1','1','false'};
    private String[] endDate_type_info = new String[]{'endDate',SOAP_M_URI,null,'0','1','false'};
    private String[] interval_type_info = new String[]{'interval',SOAP_M_URI,null,'1','1','false'};
    private String[] startDate_type_info = new String[]{'startDate',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'dateColumn','endDate','interval','startDate'};
}

/** @description : Wrapper class to handle column in report type**/
public class ReportTypeColumn {
    public Boolean checkedByDefault;
    public String displayNameOverride;
    public String field;
    public String table;
    private String[] checkedByDefault_type_info = new String[]{'checkedByDefault',SOAP_M_URI,null,'1','1','false'};
    private String[] displayNameOverride_type_info = new String[]{'displayNameOverride',SOAP_M_URI,null,'0','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] table_type_info = new String[]{'table',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'checkedByDefault','displayNameOverride','field','table'};
}

/** @description : Wrapper class to handle translation in report type**/
public class RecordTypeTranslation {
    public String description;
    public String label;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'description','label','name'};
}

/** @description : Wrapper class to handle input field assignment in flow**/
public class FlowInputFieldAssignment extends FlowBaseElement {
    public String type = 'FlowInputFieldAssignment';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String field;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'field','value'};
}

/** @description : Wrapper class to handle filter item in report type**/
public class FilterItem {
    public String field;
    public String operation;
    public String value;
    public String valueField;
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] operation_type_info = new String[]{'operation',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] valueField_type_info = new String[]{'valueField',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'field','operation','value','valueField'};
}

/** @description : Wrapper class to handle chart component layout item in report type**/
public class ReportChartComponentLayoutItem {
    public Boolean cacheData;
    public String contextFilterableField;
    public String error;
    public Boolean hideOnError;
    public Boolean includeContext;
    public String reportName;
    public Boolean showTitle;
    public String size;
    private String[] cacheData_type_info = new String[]{'cacheData',SOAP_M_URI,null,'0','1','false'};
    private String[] contextFilterableField_type_info = new String[]{'contextFilterableField',SOAP_M_URI,null,'0','1','false'};
    private String[] error_type_info = new String[]{'error',SOAP_M_URI,null,'0','1','false'};
    private String[] hideOnError_type_info = new String[]{'hideOnError',SOAP_M_URI,null,'0','1','false'};
    private String[] includeContext_type_info = new String[]{'includeContext',SOAP_M_URI,null,'0','1','false'};
    private String[] reportName_type_info = new String[]{'reportName',SOAP_M_URI,null,'1','1','false'};
    private String[] showTitle_type_info = new String[]{'showTitle',SOAP_M_URI,null,'0','1','false'};
    private String[] size_type_info = new String[]{'size',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'cacheData','contextFilterableField','error','hideOnError','includeContext','reportName','showTitle','size'};
}

/** @description : Wrapper class to handle tab permissions in permission set**/
public class PermissionSetTabSetting {
    public String tab;
    public String visibility;
    private String[] tab_type_info = new String[]{'tab',SOAP_M_URI,null,'1','1','false'};
    private String[] visibility_type_info = new String[]{'visibility',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'tab','visibility'};
}

/** @description : Wrapper class to handle historical selector in report type**/
public class ReportHistoricalSelector {
    public String[] snapshot;
    private String[] snapshot_type_info = new String[]{'snapshot',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'snapshot'};
}

/** @description : Wrapper class to handle related content item in page layout**/
public class RelatedContentItem {
    public DynamicMetadataService.LayoutItem layoutItem;
    private String[] layoutItem_type_info = new String[]{'layoutItem',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'layoutItem'};
}

/** @description : Wrapper class to handle output field assignment in flow**/
public class FlowOutputFieldAssignment extends FlowBaseElement {
    public String type = 'FlowOutputFieldAssignment';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String assignToReference;
    public String field;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'assignToReference','field'};
}

/** @description : Wrapper class to handle apex plugin call output parameter in flow**/
public class FlowApexPluginCallOutputParameter extends FlowBaseElement {
    public String type = 'FlowApexPluginCallOutputParameter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String assignToReference;
    public String name;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'assignToReference','name'};
}

/** @description : Wrapper class to handle summary layout item in page layout**/
public class SummaryLayoutItem {
    public String customLink;
    public String field;
    public Integer posX;
    public Integer posY;
    public Integer posZ;
    private String[] customLink_type_info = new String[]{'customLink',SOAP_M_URI,null,'0','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'0','1','false'};
    private String[] posX_type_info = new String[]{'posX',SOAP_M_URI,null,'1','1','false'};
    private String[] posY_type_info = new String[]{'posY',SOAP_M_URI,null,'0','1','false'};
    private String[] posZ_type_info = new String[]{'posZ',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'customLink','field','posX','posY','posZ'};
}

/** @description : Wrapper class to handle quick action layout item in page layout**/
public class QuickActionLayoutItem {
    public Boolean emptySpace;
    public String field;
    public String uiBehavior;
    private String[] emptySpace_type_info = new String[]{'emptySpace',SOAP_M_URI,null,'0','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'0','1','false'};
    private String[] uiBehavior_type_info = new String[]{'uiBehavior',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'emptySpace','field','uiBehavior'};
}

/** @description : Wrapper class to handle wait event input parameter in flow**/
public class FlowWaitEventInputParameter extends FlowBaseElement {
    public String type = 'FlowWaitEventInputParameter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String name;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'name','value'};
}

/** @description : Wrapper class to handle session header**/
public class SessionHeader_element {
    public String sessionId;
    private String[] sessionId_type_info = new String[]{'sessionId',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'sessionId'};
}

/** @description : Wrapper class to handle flow elements**/
public virtual class FlowElement extends FlowBaseElement {
    public String description;
    public String name;
}

/** @description : Wrapper class to handle custom permissions in profile**/
public class ProfileCustomPermissions {
    public Boolean enabled;
    public String name;
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'enabled','name'};
}

/** @description : Wrapper class to handle screen field input parameter in flow**/
public class FlowScreenFieldInputParameter {
    public String name;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'name','value'};
}

/** @description : Wrapper class to handle screen rule in flow**/
public class FlowScreenRule {
    public String conditionLogic;
    public DynamicMetadataService.FlowCondition[] conditions;
    public String label;
    public DynamicMetadataService.FlowScreenRuleAction[] ruleActions;
    private String[] conditionLogic_type_info = new String[]{'conditionLogic',SOAP_M_URI,null,'0','1','false'};
    private String[] conditions_type_info = new String[]{'conditions',SOAP_M_URI,null,'0','-1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] ruleActions_type_info = new String[]{'ruleActions',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'conditionLogic','conditions','label','ruleActions'};
}

/** @description : Wrapper class to handle application visibility in profile**/
public class ProfileApplicationVisibility {
    public String application;
    public Boolean default_x;
    public Boolean visible;
    private String[] application_type_info = new String[]{'application',SOAP_M_URI,null,'1','1','false'};
    private String[] default_x_type_info = new String[]{'default',SOAP_M_URI,null,'1','1','false'};
    private String[] visible_type_info = new String[]{'visible',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'application','default_x','visible'};
}

/** @description : Wrapper class to handle category group visibility in profile**/
public class ProfileCategoryGroupVisibility {
    public String[] dataCategories;
    public String dataCategoryGroup;
    public String visibility;
    private String[] dataCategories_type_info = new String[]{'dataCategories',SOAP_M_URI,null,'0','-1','false'};
    private String[] dataCategoryGroup_type_info = new String[]{'dataCategoryGroup',SOAP_M_URI,null,'1','1','false'};
    private String[] visibility_type_info = new String[]{'visibility',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'dataCategories','dataCategoryGroup','visibility'};
}

/** @description : Wrapper class to handle apex class access in profile**/
public class ProfileApexClassAccess {
    public String apexClass;
    public Boolean enabled;
    private String[] apexClass_type_info = new String[]{'apexClass',SOAP_M_URI,null,'1','1','false'};
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'apexClass','enabled'};
}

/** @description : Wrapper class to handle login IP range in profile**/
public class ProfileLoginIpRange {
    public String description;
    public String endAddress;
    public String startAddress;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] endAddress_type_info = new String[]{'endAddress',SOAP_M_URI,null,'1','1','false'};
    private String[] startAddress_type_info = new String[]{'startAddress',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'description','endAddress','startAddress'};
}

/** @description : Wrapper class to handle external data source access in profile**/
public class ProfileExternalDataSourceAccess {
    public Boolean enabled;
    public String externalDataSource;
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] externalDataSource_type_info = new String[]{'externalDataSource',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'enabled','externalDataSource'};
}

/** @description : Wrapper class to handle field level security in profile**/
public class ProfileFieldLevelSecurity {
    public Boolean editable;
    public String field;
    public Boolean readable;
    private String[] editable_type_info = new String[]{'editable',SOAP_M_URI,null,'1','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] readable_type_info = new String[]{'readable',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'editable','field','readable'};
}

/** @description : Wrapper class to handle login hours of profile**/
public class ProfileLoginHours {
    public String fridayEnd;
    public String fridayStart;
    public String mondayEnd;
    public String mondayStart;
    public String saturdayEnd;
    public String saturdayStart;
    public String sundayEnd;
    public String sundayStart;
    public String thursdayEnd;
    public String thursdayStart;
    public String tuesdayEnd;
    public String tuesdayStart;
    public String wednesdayEnd;
    public String wednesdayStart;
    private String[] fridayEnd_type_info = new String[]{'fridayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] fridayStart_type_info = new String[]{'fridayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] mondayEnd_type_info = new String[]{'mondayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] mondayStart_type_info = new String[]{'mondayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] saturdayEnd_type_info = new String[]{'saturdayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] saturdayStart_type_info = new String[]{'saturdayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] sundayEnd_type_info = new String[]{'sundayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] sundayStart_type_info = new String[]{'sundayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] thursdayEnd_type_info = new String[]{'thursdayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] thursdayStart_type_info = new String[]{'thursdayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] tuesdayEnd_type_info = new String[]{'tuesdayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] tuesdayStart_type_info = new String[]{'tuesdayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] wednesdayEnd_type_info = new String[]{'wednesdayEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] wednesdayStart_type_info = new String[]{'wednesdayStart',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'fridayEnd','fridayStart','mondayEnd','mondayStart','saturdayEnd','saturdayStart','sundayEnd','sundayStart','thursdayEnd','thursdayStart','tuesdayEnd','tuesdayStart','wednesdayEnd','wednesdayStart'};
}

/** @description : Wrapper class to handle apex page access in profile**/
public class ProfileApexPageAccess {
    public String apexPage;
    public Boolean enabled;
    private String[] apexPage_type_info = new String[]{'apexPage',SOAP_M_URI,null,'1','1','false'};
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'apexPage','enabled'};
}

/** @description : Wrapper class to handle app profile action override**/
public class AppProfileActionOverride {
    public String profile;
    private String[] profile_type_info = new String[]{'profile',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'profile'};
}

/** @description : Wrapper class to handle action override in profile**/
public class ProfileActionOverride {
    public String actionName;
    public String content;
    public String formFactor;
    public String pageOrSobjectType;
    public String recordType;
    public String type_x;
    private String[] actionName_type_info = new String[]{'actionName',SOAP_M_URI,null,'1','1','false'};
    private String[] content_type_info = new String[]{'content',SOAP_M_URI,null,'0','1','false'};
    private String[] formFactor_type_info = new String[]{'formFactor',SOAP_M_URI,null,'1','1','false'};
    private String[] pageOrSobjectType_type_info = new String[]{'pageOrSobjectType',SOAP_M_URI,null,'1','1','false'};
    private String[] recordType_type_info = new String[]{'recordType',SOAP_M_URI,null,'0','1','false'};
    private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'actionName','content','formFactor','pageOrSobjectType','recordType','type_x'};
}

/** @description : Wrapper class to handle user permissions in profile**/
public class ProfileUserPermission {
    public Boolean enabled;
    public String name;
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'enabled','name'};
}    
/** @description : Wrapper class to handle tab components in page layout**/
public class Profile extends Metadata {
    public String type = 'Profile';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public DynamicMetadataService.ProfileApplicationVisibility[] applicationVisibilities;
    public DynamicMetadataService.ProfileCategoryGroupVisibility[] categoryGroupVisibilities;
    public DynamicMetadataService.ProfileApexClassAccess[] classAccesses;
    public Boolean custom;
    public DynamicMetadataService.ProfileCustomPermissions[] customPermissions;
    public String description;
    public DynamicMetadataService.ProfileExternalDataSourceAccess[] externalDataSourceAccesses;
    public DynamicMetadataService.ProfileFieldLevelSecurity[] fieldPermissions;
    public DynamicMetadataService.ProfileLayoutAssignment[] layoutAssignments;
    public DynamicMetadataService.ProfileLoginHours loginHours;
    public DynamicMetadataService.ProfileLoginIpRange[] loginIpRanges;
    public DynamicMetadataService.ProfileObjectPermissions[] objectPermissions;
    public DynamicMetadataService.ProfileApexPageAccess[] pageAccesses;
    public DynamicMetadataService.ProfileActionOverride[] profileActionOverrides;
    public DynamicMetadataService.ProfileRecordTypeVisibility[] recordTypeVisibilities;
    public DynamicMetadataService.ProfileTabVisibility[] tabVisibilities;
    public String userLicense;
    public DynamicMetadataService.ProfileUserPermission[] userPermissions;
    private String[] applicationVisibilities_type_info = new String[]{'applicationVisibilities',SOAP_M_URI,null,'0','-1','false'};
    private String[] categoryGroupVisibilities_type_info = new String[]{'categoryGroupVisibilities',SOAP_M_URI,null,'0','-1','false'};
    private String[] classAccesses_type_info = new String[]{'classAccesses',SOAP_M_URI,null,'0','-1','false'};
    private String[] custom_type_info = new String[]{'custom',SOAP_M_URI,null,'0','1','false'};
    private String[] customPermissions_type_info = new String[]{'customPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] externalDataSourceAccesses_type_info = new String[]{'externalDataSourceAccesses',SOAP_M_URI,null,'0','-1','false'};
    private String[] fieldPermissions_type_info = new String[]{'fieldPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] layoutAssignments_type_info = new String[]{'layoutAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] loginHours_type_info = new String[]{'loginHours',SOAP_M_URI,null,'0','1','false'};
    private String[] loginIpRanges_type_info = new String[]{'loginIpRanges',SOAP_M_URI,null,'0','-1','false'};
    private String[] objectPermissions_type_info = new String[]{'objectPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] pageAccesses_type_info = new String[]{'pageAccesses',SOAP_M_URI,null,'0','-1','false'};
    private String[] profileActionOverrides_type_info = new String[]{'profileActionOverrides',SOAP_M_URI,null,'0','-1','false'};
    private String[] recordTypeVisibilities_type_info = new String[]{'recordTypeVisibilities',SOAP_M_URI,null,'0','-1','false'};
    private String[] tabVisibilities_type_info = new String[]{'tabVisibilities',SOAP_M_URI,null,'0','-1','false'};
    private String[] userLicense_type_info = new String[]{'userLicense',SOAP_M_URI,null,'0','1','false'};
    private String[] userPermissions_type_info = new String[]{'userPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'applicationVisibilities','categoryGroupVisibilities','classAccesses','custom','customPermissions','description','externalDataSourceAccesses','fieldPermissions','layoutAssignments','loginHours','loginIpRanges','objectPermissions','pageAccesses','profileActionOverrides','recordTypeVisibilities','tabVisibilities','userLicense','userPermissions'};
}

/** @description : Wrapper class to handle tab visibility in profile**/
public class ProfileTabVisibility {
    public String tab;
    public String visibility;
    private String[] tab_type_info = new String[]{'tab',SOAP_M_URI,null,'1','1','false'};
    private String[] visibility_type_info = new String[]{'visibility',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'tab','visibility'};
}

/** @description : Wrapper class to handle user input in flow**/
public class FlowChoiceUserInput extends FlowBaseElement {
    public String type = 'FlowChoiceUserInput';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public Boolean isRequired;
    public String promptText;
    public DynamicMetadataService.FlowInputValidationRule validationRule;
    private String[] isRequired_type_info = new String[]{'isRequired',SOAP_M_URI,null,'0','1','false'};
    private String[] promptText_type_info = new String[]{'promptText',SOAP_M_URI,null,'0','1','false'};
    private String[] validationRule_type_info = new String[]{'validationRule',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'isRequired','promptText','validationRule'};
}

/** @description : Wrapper class to handle field permissions in permission set**/
public class PermissionSetFieldPermissions {
    public Boolean editable;
    public String field;
    public Boolean readable;
    private String[] editable_type_info = new String[]{'editable',SOAP_M_URI,null,'1','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] readable_type_info = new String[]{'readable',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'editable','field','readable'};
}

/** @description : Wrapper class to handle object relationship in report type**/
public class ObjectRelationship {
    public DynamicMetadataService.ObjectRelationship join_x;
    public Boolean outerJoin;
    public String relationship;
    private String[] join_x_type_info = new String[]{'join',SOAP_M_URI,null,'0','1','false'};
    private String[] outerJoin_type_info = new String[]{'outerJoin',SOAP_M_URI,null,'1','1','false'};
    private String[] relationship_type_info = new String[]{'relationship',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'join_x','outerJoin','relationship'};
}

/** @description : Wrapper class to handle layout section in report type**/
public class ReportLayoutSection {
    public DynamicMetadataService.ReportTypeColumn[] columns;
    public String masterLabel;
    private String[] columns_type_info = new String[]{'columns',SOAP_M_URI,null,'0','-1','false'};
    private String[] masterLabel_type_info = new String[]{'masterLabel',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'columns','masterLabel'};
}

/** @description : Wrapper class to handle dynamic choice set in flow**/
public class FlowDynamicChoiceSet extends FlowElement {
    public String type = 'FlowDynamicChoiceSet';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String dataType;
    public String displayField;
    public DynamicMetadataService.FlowRecordFilter[] filters;
    public Integer limit_x;
    public String object_x;
    public DynamicMetadataService.FlowOutputFieldAssignment[] outputAssignments;
    public String picklistField;
    public String picklistObject;
    public String sortField;
    public String sortOrder;
    public String valueField;
    private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'1','1','false'};
    private String[] displayField_type_info = new String[]{'displayField',SOAP_M_URI,null,'1','1','false'};
    private String[] filters_type_info = new String[]{'filters',SOAP_M_URI,null,'0','-1','false'};
    private String[] limit_x_type_info = new String[]{'limit',SOAP_M_URI,null,'0','1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'1','1','false'};
    private String[] outputAssignments_type_info = new String[]{'outputAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] picklistField_type_info = new String[]{'picklistField',SOAP_M_URI,null,'0','1','false'};
    private String[] picklistObject_type_info = new String[]{'picklistObject',SOAP_M_URI,null,'0','1','false'};
    private String[] sortField_type_info = new String[]{'sortField',SOAP_M_URI,null,'0','1','false'};
    private String[] sortOrder_type_info = new String[]{'sortOrder',SOAP_M_URI,null,'0','1','false'};
    private String[] valueField_type_info = new String[]{'valueField',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'dataType','displayField','filters','limit_x','object_x','outputAssignments','picklistField','picklistObject','sortField','sortOrder','valueField'};
}

/** @description : Wrapper class to handle related content in page layout**/
public class RelatedContent {
    public DynamicMetadataService.RelatedContentItem[] relatedContentItems;
    private String[] relatedContentItems_type_info = new String[]{'relatedContentItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'relatedContentItems'};
}

/** @description : Wrapper class to handle start of flow**/
public class FlowStart{
    // Restriction enumeration: SortCollectionProcessor, RecommendationMapCollectionProcessor, FilterCollectionProcessor, DateWait, AttributeWait, DurationWait, InteractiveStep, BackgroundStep, ManagedContentRoleInteractiveStep
    public String elementSubtype;
    public String label;
    public Integer locationX;
    public Integer locationY;
    private transient String[] elementSubtype_type_info = new String[]{'elementSubtype',SOAP_M_URI,'FlowElementSubtype','0','1','false'};
    private transient String[] label_type_info = new String[]{'label',SOAP_M_URI,'string','0','1','false'};
    private transient String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,'int','1','1','false'};
    private transient String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,'int','1','1','false'};
    public String description;
    public String name;
    private transient String[] description_type_info = new String[]{'description',SOAP_M_URI,'string','0','1','false'};
    private transient String[] name_type_info = new String[]{'name',SOAP_M_URI,'string','0','1','false'};
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private transient String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,'FlowMetadataValue','0','-1','false'};
    public DynamicMetadataService.FlowConnector connector;
    public Boolean doesRequireRecordChangedToMeetCriteria;
    public String filterFormula;
    public String filterLogic;
    public DynamicMetadataService.FlowRecordFilter[] filters;
    public String object_x;
    public String objectContainer;
    // Restriction enumeration: Update, Create, CreateAndUpdate, Delete, None
    public String recordTriggerType;		
    public String segment;
    // Restriction enumeration: None, Scheduled, RecordBeforeSave, RecordBeforeDelete, RecordAfterSave, PlatformEvent, EventDrivenJourney, Segment
    public String triggerType;
    private transient String[] connector_type_info = new String[]{'connector',SOAP_M_URI,'FlowConnector','0','1','false'};
    private transient String[] doesRequireRecordChangedToMeetCriteria_type_info = new String[]{'doesRequireRecordChangedToMeetCriteria',SOAP_M_URI,'boolean','0','1','false'};
    private transient String[] filterFormula_type_info = new String[]{'filterFormula',SOAP_M_URI,'string','0','1','false'};
    private transient String[] filterLogic_type_info = new String[]{'filterLogic',SOAP_M_URI,'string','0','1','false'};
    private transient String[] filters_type_info = new String[]{'filters',SOAP_M_URI,'FlowRecordFilter','0','-1','false'};
    private transient String[] object_x_type_info = new String[]{'object',SOAP_M_URI,'string','0','1','false'};
    private transient String[] recordTriggerType_type_info = new String[]{'recordTriggerType',SOAP_M_URI,'RecordTriggerType','0','1','false'};
    private transient String[] triggerType_type_info = new String[]{'triggerType',SOAP_M_URI,'FlowTriggerType','0','1','false'};
    private transient String[] objectContainer_type_info = new String[]{'objectContainer',SOAP_M_URI,'string','0','1','false'};
    private transient String[] segment_type_info = new String[]{'segment',SOAP_M_URI,'string','0','1','false'};
    private transient String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private transient String[] field_order_type_info = new String[]{'elementSubtype','label','locationX','locationY','description','name','processMetadataValues','connector','doesRequireRecordChangedToMeetCriteria','filterFormula','filterLogic','filters','object_x','objectContainer','recordTriggerType','segment','triggerType'};
} 

/** @description : Wrapper class to handle flow creation**/
public class Flow extends Metadata {
    public String status;
    public String type = 'Flow';
    public String fullName;
    public Double apiVersion;
    public String[] environments;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    private transient String[] status_type_info = new String[]{'status',SOAP_M_URI,'FlowVersionStatus','0','1','false'};
    public DynamicMetadataService.FlowActionCall[] actionCalls;
    public DynamicMetadataService.FlowApexPluginCall[] apexPluginCalls;
    public DynamicMetadataService.FlowAssignment[] assignments;
    public DynamicMetadataService.FlowChoice[] choices;
    public DynamicMetadataService.FlowConstant[] constants;
    public DynamicMetadataService.FlowDecision[] decisions;
    public DynamicMetadataService.FlowStart start;
    public String description;
    public DynamicMetadataService.FlowDynamicChoiceSet[] dynamicChoiceSets;
    public DynamicMetadataService.FlowFormula[] formulas;
    public String interviewLabel;
    public String label;
    public DynamicMetadataService.FlowLoop[] loops;
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    public String processType;
    public DynamicMetadataService.FlowRecordCreate[] recordCreates;
    public DynamicMetadataService.FlowRecordDelete[] recordDeletes;
    public DynamicMetadataService.FlowRecordLookup[] recordLookups;
    public DynamicMetadataService.FlowRecordUpdate[] recordUpdates;
    public DynamicMetadataService.FlowScreen[] screens;
    public DynamicMetadataService.FlowStage[] stages;
    public String startElementReference;
    public DynamicMetadataService.FlowStep[] steps;
    public DynamicMetadataService.FlowSubflow[] subflows;
    public DynamicMetadataService.FlowTextTemplate[] textTemplates;
    public DynamicMetadataService.FlowVariable[] variables;
    public DynamicMetadataService.FlowWait[] waits;
    private String[] start_type_info = new String[]{'start',SOAP_M_URI,null,'0','1','false'};
    private String[] actionCalls_type_info = new String[]{'actionCalls',SOAP_M_URI,null,'0','-1','false'};
    private String[] apexPluginCalls_type_info = new String[]{'apexPluginCalls',SOAP_M_URI,null,'0','-1','false'};
    private String[] assignments_type_info = new String[]{'assignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] choices_type_info = new String[]{'choices',SOAP_M_URI,null,'0','-1','false'};
    private String[] constants_type_info = new String[]{'constants',SOAP_M_URI,null,'0','-1','false'};
    private String[] decisions_type_info = new String[]{'decisions',SOAP_M_URI,null,'0','-1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] dynamicChoiceSets_type_info = new String[]{'dynamicChoiceSets',SOAP_M_URI,null,'0','-1','false'};
    private String[] formulas_type_info = new String[]{'formulas',SOAP_M_URI,null,'0','-1','false'};
    private String[] interviewLabel_type_info = new String[]{'interviewLabel',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] loops_type_info = new String[]{'loops',SOAP_M_URI,null,'0','-1','false'};
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    private String[] processType_type_info = new String[]{'processType',SOAP_M_URI,null,'0','1','false'};
    private String[] recordCreates_type_info = new String[]{'recordCreates',SOAP_M_URI,null,'0','-1','false'};
    private String[] recordDeletes_type_info = new String[]{'recordDeletes',SOAP_M_URI,null,'0','-1','false'};
    private String[] recordLookups_type_info = new String[]{'recordLookups',SOAP_M_URI,null,'0','-1','false'};
    private String[] recordUpdates_type_info = new String[]{'recordUpdates',SOAP_M_URI,null,'0','-1','false'};
    private String[] screens_type_info = new String[]{'screens',SOAP_M_URI,null,'0','-1','false'};
    private String[] stages_type_info = new String[]{'stages',SOAP_M_URI,null,'0','-1','false'};
    private String[] startElementReference_type_info = new String[]{'startElementReference',SOAP_M_URI,null,'0','1','false'};
    private String[] steps_type_info = new String[]{'steps',SOAP_M_URI,null,'0','-1','false'};
    private String[] subflows_type_info = new String[]{'subflows',SOAP_M_URI,null,'0','-1','false'};
    private String[] textTemplates_type_info = new String[]{'textTemplates',SOAP_M_URI,null,'0','-1','false'};
    private String[] variables_type_info = new String[]{'variables',SOAP_M_URI,null,'0','-1','false'};
    private String[] waits_type_info = new String[]{'waits',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'actionCalls','apexPluginCalls','assignments','choices','constants','decisions','description','dynamicChoiceSets','formulas','interviewLabel','label','loops','processMetadataValues','processType','recordCreates','recordDeletes','recordLookups','recordUpdates','screens','stages','start','status','startElementReference','steps','subflows','textTemplates','variables','waits'};		
}

/** @description : Wrapper class to handle custom metadata value**/
public class CustomMetadataValue {
    public String field;
    public String value;
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'1','1','true'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'field','value'};
}

/** @description : Wrapper class to handle section translation in page layout**/
public class LayoutSectionTranslation {
    public String label;
    public String section;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] section_type_info = new String[]{'section',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','section'};
}

/** @description : Wrapper class to handle action call output parameter in flow**/
public class FlowActionCallOutputParameter extends FlowBaseElement {
    public String type = 'FlowActionCallOutputParameter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String assignToReference;
    public String name;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'assignToReference','name'};
}

/** @description : Wrapper class to handle record trigger in flow**/
public class FlowRecordCreate extends FlowNode {
    public String type = 'FlowRecordCreate';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public String assignRecordIdToReference;
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowInputFieldAssignment[] inputAssignments;
    public String inputReference;
    public String object_x;
    private String[] assignRecordIdToReference_type_info = new String[]{'assignRecordIdToReference',SOAP_M_URI,null,'0','1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] inputAssignments_type_info = new String[]{'inputAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] inputReference_type_info = new String[]{'inputReference',SOAP_M_URI,null,'0','1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'assignRecordIdToReference','connector','faultConnector','inputAssignments','inputReference','object_x'};
}

/** @description : Wrapper class to handle metadata data upsert **/
public class upsertMetadataResponse_element {
    public DynamicMetadataService.UpsertResult[] result;
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to handle record type visibility in permission set**/
public class PermissionSetRecordTypeVisibility {
    public String recordType;
    public Boolean visible;
    private String[] recordType_type_info = new String[]{'recordType',SOAP_M_URI,null,'1','1','false'};
    private String[] visible_type_info = new String[]{'visible',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'recordType','visible'};
}

/** @description : Wrapper class to handle application visibility in permission set**/
public class PermissionSetApplicationVisibility {
    public String application;
    public Boolean visible;
    private String[] application_type_info = new String[]{'application',SOAP_M_URI,null,'1','1','false'};
    private String[] visible_type_info = new String[]{'visible',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'application','visible'};
}

/** @description : Wrapper class to handle user permission in permission set**/
public class PermissionSetUserPermission {
    public Boolean enabled;
    public String name;
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'enabled','name'};
}

/** @description : Wrapper class to handle external data source access in permission set**/
public class PermissionSetExternalDataSourceAccess {
    public Boolean enabled;
    public String externalDataSource;
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] externalDataSource_type_info = new String[]{'externalDataSource',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'enabled','externalDataSource'};
}

/** @description : Wrapper class to create permission set**/
public class PermissionSet extends Metadata {
    public String type = 'PermissionSet';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public DynamicMetadataService.PermissionSetApplicationVisibility[] applicationVisibilities;
    public DynamicMetadataService.PermissionSetApexClassAccess[] classAccesses;
    public DynamicMetadataService.PermissionSetCustomPermissions[] customPermissions;
    public String description;
    public DynamicMetadataService.PermissionSetExternalDataSourceAccess[] externalDataSourceAccesses;
    public DynamicMetadataService.PermissionSetFieldPermissions[] fieldPermissions;
    public Boolean hasActivationRequired;
    public String label;
    public String license;
    public DynamicMetadataService.PermissionSetObjectPermissions[] objectPermissions;
    public DynamicMetadataService.PermissionSetApexPageAccess[] pageAccesses;
    public DynamicMetadataService.PermissionSetRecordTypeVisibility[] recordTypeVisibilities;
    public DynamicMetadataService.PermissionSetTabSetting[] tabSettings;
    public DynamicMetadataService.PermissionSetUserPermission[] userPermissions;
    private String[] applicationVisibilities_type_info = new String[]{'applicationVisibilities',SOAP_M_URI,null,'0','-1','false'};
    private String[] classAccesses_type_info = new String[]{'classAccesses',SOAP_M_URI,null,'0','-1','false'};
    private String[] customPermissions_type_info = new String[]{'customPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] externalDataSourceAccesses_type_info = new String[]{'externalDataSourceAccesses',SOAP_M_URI,null,'0','-1','false'};
    private String[] fieldPermissions_type_info = new String[]{'fieldPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] hasActivationRequired_type_info = new String[]{'hasActivationRequired',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] license_type_info = new String[]{'license',SOAP_M_URI,null,'0','1','false'};
    private String[] objectPermissions_type_info = new String[]{'objectPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] pageAccesses_type_info = new String[]{'pageAccesses',SOAP_M_URI,null,'0','-1','false'};
    private String[] recordTypeVisibilities_type_info = new String[]{'recordTypeVisibilities',SOAP_M_URI,null,'0','-1','false'};
    private String[] tabSettings_type_info = new String[]{'tabSettings',SOAP_M_URI,null,'0','-1','false'};
    private String[] userPermissions_type_info = new String[]{'userPermissions',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'applicationVisibilities','classAccesses','customPermissions','description','externalDataSourceAccesses','fieldPermissions','hasActivationRequired','label','license','objectPermissions','pageAccesses','recordTypeVisibilities','tabSettings','userPermissions'};
}

/** @description : Wrapper class to handle flow rule in flow**/
public class FlowRule extends FlowElement {
    public String type = 'FlowRule';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String conditionLogic;
    public DynamicMetadataService.FlowCondition[] conditions;
    public DynamicMetadataService.FlowConnector connector;
    public String label;
    private String[] conditionLogic_type_info = new String[]{'conditionLogic',SOAP_M_URI,null,'1','1','false'};
    private String[] conditions_type_info = new String[]{'conditions',SOAP_M_URI,null,'0','-1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'conditionLogic','conditions','connector','label'};
}

/** @description : Wrapper class to handle apex class access in permission set**/
public class PermissionSetApexClassAccess {
    public String apexClass;
    public Boolean enabled;
    private String[] apexClass_type_info = new String[]{'apexClass',SOAP_M_URI,null,'1','1','false'};
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'apexClass','enabled'};
}

/** @description : Wrapper class to handle flow screen translation in flow**/
public class FlowScreenTranslation {
    public DynamicMetadataService.FlowScreenFieldTranslation[] fields;
    public String helpText;
    public String name;
    public String pausedText;
    private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
    private String[] helpText_type_info = new String[]{'helpText',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] pausedText_type_info = new String[]{'pausedText',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'fields','helpText','name','pausedText'};
}

/** @description : Wrapper class to handle sub flow output assignment in flow**/
public class FlowSubflowOutputAssignment extends FlowBaseElement {
    public String type = 'FlowSubflowOutputAssignment';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String assignToReference;
    public String name;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'assignToReference','name'};
}

/** @description : Wrapper class to handle chart in report type**/
 public class ReportChart {
    public String backgroundColor1;
    public String backgroundColor2;
    public String backgroundFadeDir;
    public DynamicMetadataService.ChartSummary[] chartSummaries;
    public String chartType;
    public Boolean enableHoverLabels;
    public Boolean expandOthers;
    public String groupingColumn;
    public String legendPosition;
    public String location;
    public String secondaryGroupingColumn;
    public Boolean showAxisLabels;
    public Boolean showPercentage;
    public Boolean showTotal;
    public Boolean showValues;
    public String size;
    public Double summaryAxisManualRangeEnd;
    public Double summaryAxisManualRangeStart;
    public String summaryAxisRange;
    public String textColor;
    public Integer textSize;
    public String title;
    public String titleColor;
    public Integer titleSize;
    private String[] backgroundColor1_type_info = new String[]{'backgroundColor1',SOAP_M_URI,null,'0','1','false'};
    private String[] backgroundColor2_type_info = new String[]{'backgroundColor2',SOAP_M_URI,null,'0','1','false'};
    private String[] backgroundFadeDir_type_info = new String[]{'backgroundFadeDir',SOAP_M_URI,null,'0','1','false'};
    private String[] chartSummaries_type_info = new String[]{'chartSummaries',SOAP_M_URI,null,'0','-1','false'};
    private String[] chartType_type_info = new String[]{'chartType',SOAP_M_URI,null,'1','1','false'};
    private String[] enableHoverLabels_type_info = new String[]{'enableHoverLabels',SOAP_M_URI,null,'0','1','false'};
    private String[] expandOthers_type_info = new String[]{'expandOthers',SOAP_M_URI,null,'0','1','false'};
    private String[] groupingColumn_type_info = new String[]{'groupingColumn',SOAP_M_URI,null,'0','1','false'};
    private String[] legendPosition_type_info = new String[]{'legendPosition',SOAP_M_URI,null,'0','1','false'};
    private String[] location_type_info = new String[]{'location',SOAP_M_URI,null,'0','1','false'};
    private String[] secondaryGroupingColumn_type_info = new String[]{'secondaryGroupingColumn',SOAP_M_URI,null,'0','1','false'};
    private String[] showAxisLabels_type_info = new String[]{'showAxisLabels',SOAP_M_URI,null,'0','1','false'};
    private String[] showPercentage_type_info = new String[]{'showPercentage',SOAP_M_URI,null,'0','1','false'};
    private String[] showTotal_type_info = new String[]{'showTotal',SOAP_M_URI,null,'0','1','false'};
    private String[] showValues_type_info = new String[]{'showValues',SOAP_M_URI,null,'0','1','false'};
    private String[] size_type_info = new String[]{'size',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryAxisManualRangeEnd_type_info = new String[]{'summaryAxisManualRangeEnd',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryAxisManualRangeStart_type_info = new String[]{'summaryAxisManualRangeStart',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryAxisRange_type_info = new String[]{'summaryAxisRange',SOAP_M_URI,null,'0','1','false'};
    private String[] textColor_type_info = new String[]{'textColor',SOAP_M_URI,null,'0','1','false'};
    private String[] textSize_type_info = new String[]{'textSize',SOAP_M_URI,null,'0','1','false'};
    private String[] title_type_info = new String[]{'title',SOAP_M_URI,null,'0','1','false'};
    private String[] titleColor_type_info = new String[]{'titleColor',SOAP_M_URI,null,'0','1','false'};
    private String[] titleSize_type_info = new String[]{'titleSize',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'backgroundColor1','backgroundColor2','backgroundFadeDir','chartSummaries','chartType','enableHoverLabels','expandOthers','groupingColumn','legendPosition','location','secondaryGroupingColumn','showAxisLabels','showPercentage','showTotal','showValues','size','summaryAxisManualRangeEnd','summaryAxisManualRangeStart','summaryAxisRange','textColor','textSize','title','titleColor','titleSize'};
}

/** @description : Wrapper class to handle picklist value in record type**/
public class RecordTypePicklistValue {
    public String picklist;
    public DynamicMetadataService.PicklistValue[] values;
    private String[] picklist_type_info = new String[]{'picklist',SOAP_M_URI,null,'1','1','false'};
    private String[] values_type_info = new String[]{'values',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'picklist','values'};
}

/** @description : Virtual class to handle global picklist value in record type**/
public virtual class GlobalPicklistValue extends Metadata {
    public String color;
    public Boolean default_x;
    public String description;
    public Boolean isActive;
}

/** @description : Wrapper class to handle picklist value in record type**/
public class PicklistValue extends GlobalPicklistValue {
    public String type = 'PicklistValue';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public String color;
    public Boolean default_x;
    public String description;
    public Boolean isActive;
    private String[] color_type_info = new String[]{'color',SOAP_M_URI,null,'0','1','false'};
    private String[] default_x_type_info = new String[]{'default',SOAP_M_URI,null,'1','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] isActive_type_info = new String[]{'isActive',SOAP_M_URI,null,'0','1','false'};
    public Boolean allowEmail;
    public Boolean closed;
    public String[] controllingFieldValues;
    public Boolean converted;
    public Boolean cssExposed;
    public String forecastCategory;
    public Boolean highPriority;
    public Integer probability;
    public String reverseRole;
    public Boolean reviewed;
    public Boolean won;
    private String[] allowEmail_type_info = new String[]{'allowEmail',SOAP_M_URI,null,'0','1','false'};
    private String[] closed_type_info = new String[]{'closed',SOAP_M_URI,null,'0','1','false'};
    private String[] controllingFieldValues_type_info = new String[]{'controllingFieldValues',SOAP_M_URI,null,'0','-1','false'};
    private String[] converted_type_info = new String[]{'converted',SOAP_M_URI,null,'0','1','false'};
    private String[] cssExposed_type_info = new String[]{'cssExposed',SOAP_M_URI,null,'0','1','false'};
    private String[] forecastCategory_type_info = new String[]{'forecastCategory',SOAP_M_URI,null,'0','1','false'};
    private String[] highPriority_type_info = new String[]{'highPriority',SOAP_M_URI,null,'0','1','false'};
    private String[] probability_type_info = new String[]{'probability',SOAP_M_URI,null,'0','1','false'};
    private String[] reverseRole_type_info = new String[]{'reverseRole',SOAP_M_URI,null,'0','1','false'};
    private String[] reviewed_type_info = new String[]{'reviewed',SOAP_M_URI,null,'0','1','false'};
    private String[] won_type_info = new String[]{'won',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName','color','default_x','description','isActive', 'allowEmail','closed','controllingFieldValues','converted','cssExposed','forecastCategory','highPriority','probability','reverseRole','reviewed','won'};
}

/** @description : Wrapper class to create record type**/
public class RecordType extends Metadata {
    public String type = 'RecordType';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public Boolean active;
    public String businessProcess;
    public String compactLayoutAssignment;
    public String description;
    public String label;
    public DynamicMetadataService.RecordTypePicklistValue[] picklistValues;
    private String[] active_type_info = new String[]{'active',SOAP_M_URI,null,'1','1','false'};
    private String[] businessProcess_type_info = new String[]{'businessProcess',SOAP_M_URI,null,'0','1','false'};
    private String[] compactLayoutAssignment_type_info = new String[]{'compactLayoutAssignment',SOAP_M_URI,null,'0','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] picklistValues_type_info = new String[]{'picklistValues',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'active','businessProcess','compactLayoutAssignment','description','label','picklistValues'};
}

/** @description : Wrapper class to handle cross filter in report type**/
public class ReportCrossFilter {
    public DynamicMetadataService.ReportFilterItem[] criteriaItems;
    public String operation;
    public String primaryTableColumn;
    public String relatedTable;
    public String relatedTableJoinColumn;
    private String[] criteriaItems_type_info = new String[]{'criteriaItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] operation_type_info = new String[]{'operation',SOAP_M_URI,null,'1','1','false'};
    private String[] primaryTableColumn_type_info = new String[]{'primaryTableColumn',SOAP_M_URI,null,'1','1','false'};
    private String[] relatedTable_type_info = new String[]{'relatedTable',SOAP_M_URI,null,'1','1','false'};
    private String[] relatedTableJoinColumn_type_info = new String[]{'relatedTableJoinColumn',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'criteriaItems','operation','primaryTableColumn','relatedTable','relatedTableJoinColumn'};
}

/** @description : Wrapper class to handle flow loop in flow**/
public class FlowLoop extends FlowNode {
    public String type = 'FlowLoop';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public String assignNextValueToReference;
    public String collectionReference;
    public String iterationOrder;
    public DynamicMetadataService.FlowConnector nextValueConnector;
    public DynamicMetadataService.FlowConnector noMoreValuesConnector;
    private String[] assignNextValueToReference_type_info = new String[]{'assignNextValueToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] collectionReference_type_info = new String[]{'collectionReference',SOAP_M_URI,null,'1','1','false'};
    private String[] iterationOrder_type_info = new String[]{'iterationOrder',SOAP_M_URI,null,'0','1','false'};
    private String[] nextValueConnector_type_info = new String[]{'nextValueConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] noMoreValuesConnector_type_info = new String[]{'noMoreValuesConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'assignNextValueToReference','collectionReference','iterationOrder','nextValueConnector','noMoreValuesConnector'};
}

/** @description : Wrapper class to handle definition in flow**/
public class FlowDefinition {
    public Integer activeVersionNumber;
    public String description;
    public String masterLabel;
    private String[] activeVersionNumber_type_info = new String[]{'activeVersionNumber',SOAP_M_URI,null,'0','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] masterLabel_type_info = new String[]{'masterLabel',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'activeVersionNumber','description','masterLabel'};
}

/** @description : Wrapper class to handle column in page layout**/
public class LayoutColumn {
    public DynamicMetadataService.LayoutItem[] layoutItems;
    public String reserved;
    private String[] layoutItems_type_info = new String[]{'layoutItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] reserved_type_info = new String[]{'reserved',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'layoutItems','reserved'};
}

/** @description : Wrapper class to handle errors in metadata deployment**/
public class Error {
    public DynamicMetadataService.ExtendedErrorDetails[] extendedErrorDetails;
    public String[] fields;
    public String message;
    public String statusCode;
    private String[] extendedErrorDetails_type_info = new String[]{'extendedErrorDetails',SOAP_M_URI,null,'0','-1','false'};
    private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
    private String[] message_type_info = new String[]{'message',SOAP_M_URI,null,'1','1','false'};
    private String[] statusCode_type_info = new String[]{'statusCode',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'extendedErrorDetails','fields','message','statusCode'};
}

/** @description : Wrapper class to handle flow step in flow**/
public class FlowStep extends FlowNode {
    public String type = 'FlowStep';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowConnector[] connectors;
    private String[] connectors_type_info = new String[]{'connectors',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'connectors'};
}

/** @description : Wrapper class to handle update in metadata deployment**/
public class updateMetadata_element {
    public DynamicMetadataService.Metadata[] metadata;
    private String[] metadata_type_info = new String[]{'metadata',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'metadata'};
}

/** @description : Wrapper class to handle variable in flow**/
public class FlowVariable extends FlowElement {
    public String type = 'FlowVariable';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String dataType;
    public Boolean isCollection;
    public Boolean isInput;
    public Boolean isOutput;
    public String objectType;
    public Integer scale;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'1','1','false'};
    private String[] isCollection_type_info = new String[]{'isCollection',SOAP_M_URI,null,'0','1','false'};
    private String[] isInput_type_info = new String[]{'isInput',SOAP_M_URI,null,'0','1','false'};
    private String[] isOutput_type_info = new String[]{'isOutput',SOAP_M_URI,null,'0','1','false'};
    private String[] objectType_type_info = new String[]{'objectType',SOAP_M_URI,null,'0','1','false'};
    private String[] scale_type_info = new String[]{'scale',SOAP_M_URI,null,'0','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'dataType','isCollection','isInput','isOutput','objectType','scale','value'};
}

/** @description : Wrapper class to handle category in flow**/
public class FlowCategory {
    public String description;
    public DynamicMetadataService.FlowCategoryItems[] flowCategoryItems;
    public String masterLabel;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] flowCategoryItems_type_info = new String[]{'flowCategoryItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] masterLabel_type_info = new String[]{'masterLabel',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'description','flowCategoryItems','masterLabel'};
}

/** @description : Wrapper class to handle upsert in metadata deployment**/
public class upsertMetadata_element {
    public DynamicMetadataService.Metadata[] metadata;
    private String[] metadata_type_info = new String[]{'metadata',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'metadata'};
}

/** @description : Wrapper class to handle assignment item in flow**/
public class FlowAssignmentItem extends FlowBaseElement {
    public String type = 'FlowAssignmentItem';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String assignToReference;
    public String operator;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] operator_type_info = new String[]{'operator',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'assignToReference','operator','value'};
}

/** @description : Wrapper class to handle metadata rename in metadata deployment**/
public class renameMetadata_element {
    public String type_x;
    public String oldFullName;
    public String newFullName;
    private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'1','1','false'};
    private String[] oldFullName_type_info = new String[]{'oldFullName',SOAP_M_URI,null,'1','1','false'};
    private String[] newFullName_type_info = new String[]{'newFullName',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'type_x','oldFullName','newFullName'};
}

/** @description : virtual class to declare metadata**/
public virtual class Metadata {
    public String fullName;
}

/** @description : Wrapper class to apex page access in permission set**/
public class PermissionSetApexPageAccess {
    public String apexPage;
    public Boolean enabled;
    private String[] apexPage_type_info = new String[]{'apexPage',SOAP_M_URI,null,'1','1','false'};
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'apexPage','enabled'};
}

/** @description : Wrapper class to handle flow choice in flow**/
public class FlowChoice extends FlowElement {
    public String type = 'FlowChoice';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String choiceText;
    public String dataType;
    public DynamicMetadataService.FlowChoiceUserInput userInput;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] choiceText_type_info = new String[]{'choiceText',SOAP_M_URI,null,'1','1','false'};
    private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'1','1','false'};
    private String[] userInput_type_info = new String[]{'userInput',SOAP_M_URI,null,'0','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'choiceText','dataType','userInput','value'};
}

/** @description : Wrapper class to describe metadata**/
public class describeMetadata_element {
    public Double asOfVersion;
    private String[] asOfVersion_type_info = new String[]{'asOfVersion',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'asOfVersion'};
}

/** @description : Wrapper class to handle analytics cloud component in page layout**/
public class AnalyticsCloudComponentLayoutItem {
    public String assetType;
    public String devName;
    public String error;
    public String filter;
    public Integer height;
    public Boolean hideOnError;
    public Boolean showHeader;
    public Boolean showSharing;
    public Boolean showTitle;
    public String width;
    private String[] assetType_type_info = new String[]{'assetType',SOAP_M_URI,null,'1','1','false'};
    private String[] devName_type_info = new String[]{'devName',SOAP_M_URI,null,'1','1','false'};
    private String[] error_type_info = new String[]{'error',SOAP_M_URI,null,'0','1','false'};
    private String[] filter_type_info = new String[]{'filter',SOAP_M_URI,null,'0','1','false'};
    private String[] height_type_info = new String[]{'height',SOAP_M_URI,null,'0','1','false'};
    private String[] hideOnError_type_info = new String[]{'hideOnError',SOAP_M_URI,null,'0','1','false'};
    private String[] showHeader_type_info = new String[]{'showHeader',SOAP_M_URI,null,'0','1','false'};
    private String[] showSharing_type_info = new String[]{'showSharing',SOAP_M_URI,null,'0','1','false'};
    private String[] showTitle_type_info = new String[]{'showTitle',SOAP_M_URI,null,'0','1','false'};
    private String[] width_type_info = new String[]{'width',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'assetType','devName','error','filter','height','hideOnError','showHeader','showSharing','showTitle','width'};
}

/** @description : Wrapper class to handle layout item in page layout**/
public class LayoutItem {
    public DynamicMetadataService.AnalyticsCloudComponentLayoutItem analyticsCloudComponent;
    public String behavior;
    public String canvas;
    public String component;
    public String customLink;
    public Boolean emptySpace;
    public String field;
    public Integer height;
    public String page_x;
    public DynamicMetadataService.ReportChartComponentLayoutItem reportChartComponent;
    public String scontrol;
    public Boolean showLabel;
    public Boolean showScrollbars;
    public String width;
    private String[] analyticsCloudComponent_type_info = new String[]{'analyticsCloudComponent',SOAP_M_URI,null,'0','1','false'};
    private String[] behavior_type_info = new String[]{'behavior',SOAP_M_URI,null,'0','1','false'};
    private String[] canvas_type_info = new String[]{'canvas',SOAP_M_URI,null,'0','1','false'};
    private String[] component_type_info = new String[]{'component',SOAP_M_URI,null,'0','1','false'};
    private String[] customLink_type_info = new String[]{'customLink',SOAP_M_URI,null,'0','1','false'};
    private String[] emptySpace_type_info = new String[]{'emptySpace',SOAP_M_URI,null,'0','1','false'};
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'0','1','false'};
    private String[] height_type_info = new String[]{'height',SOAP_M_URI,null,'0','1','false'};
    private String[] page_x_type_info = new String[]{'page',SOAP_M_URI,null,'0','1','false'};
    private String[] reportChartComponent_type_info = new String[]{'reportChartComponent',SOAP_M_URI,null,'0','1','false'};
    private String[] scontrol_type_info = new String[]{'scontrol',SOAP_M_URI,null,'0','1','false'};
    private String[] showLabel_type_info = new String[]{'showLabel',SOAP_M_URI,null,'0','1','false'};
    private String[] showScrollbars_type_info = new String[]{'showScrollbars',SOAP_M_URI,null,'0','1','false'};
    private String[] width_type_info = new String[]{'width',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'analyticsCloudComponent','behavior','canvas','component','customLink','emptySpace','field','height','page_x','reportChartComponent','scontrol','showLabel','showScrollbars','width'};
}

/** @description : Wrapper class to handle flow connector in flow**/
public class FlowConnector extends FlowBaseElement {
    public String type = 'FlowConnector';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String targetReference;
    private String[] targetReference_type_info = new String[]{'targetReference',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'targetReference'};
}

/** @description : Wrapper class to handle flow record lookup in flow**/
public class FlowRecordLookup extends FlowNode {
    public String type = 'FlowRecordLookup';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public Boolean assignNullValuesIfNoRecordsFound;
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowRecordFilter[] filters;
    public String object_x;
    public DynamicMetadataService.FlowOutputFieldAssignment[] outputAssignments;
    public String outputReference;
    public String[] queriedFields;
    public String sortField;
    public String sortOrder;
    private String[] assignNullValuesIfNoRecordsFound_type_info = new String[]{'assignNullValuesIfNoRecordsFound',SOAP_M_URI,null,'0','1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] filters_type_info = new String[]{'filters',SOAP_M_URI,null,'0','-1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'1','1','false'};
    private String[] outputAssignments_type_info = new String[]{'outputAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] outputReference_type_info = new String[]{'outputReference',SOAP_M_URI,null,'0','1','false'};
    private String[] queriedFields_type_info = new String[]{'queriedFields',SOAP_M_URI,null,'0','-1','false'};
    private String[] sortField_type_info = new String[]{'sortField',SOAP_M_URI,null,'0','1','false'};
    private String[] sortOrder_type_info = new String[]{'sortOrder',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'assignNullValuesIfNoRecordsFound','connector','faultConnector','filters','object_x','outputAssignments','outputReference','queriedFields','sortField','sortOrder'};
}

/** @description : Wrapper class to handle page layout assignment in profile**/
public class ProfileLayoutAssignment {
    public String layout;
    public String recordType;
    private String[] layout_type_info = new String[]{'layout',SOAP_M_URI,null,'1','1','false'};
    private String[] recordType_type_info = new String[]{'recordType',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'layout','recordType'};
}

/** @description : Wrapper class to handle report type translation**/
public class ReportTypeTranslation {
    public String description;
    public String label;
    public String name;
    public DynamicMetadataService.ReportTypeSectionTranslation[] sections;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] sections_type_info = new String[]{'sections',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'description','label','name','sections'};
}

/** @description : Wrapper class to handle reponse element in create metadata**/
public class createMetadataResponse_element {
    public DynamicMetadataService.SaveResult[] result;
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to handle apex plugin call in flow**/
public class FlowApexPluginCall extends FlowNode {
    public String type = 'FlowApexPluginCall';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public String apexClass;
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowApexPluginCallInputParameter[] inputParameters;
    public DynamicMetadataService.FlowApexPluginCallOutputParameter[] outputParameters;
    private String[] apexClass_type_info = new String[]{'apexClass',SOAP_M_URI,null,'1','1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] inputParameters_type_info = new String[]{'inputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] outputParameters_type_info = new String[]{'outputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'apexClass','connector','faultConnector','inputParameters','outputParameters'};
}

/** @description : Wrapper class to handle feed dilter in page layout**/
public class FeedLayoutFilter {
    public String feedFilterName;
    public String feedFilterType;
    public String feedItemType;
    private String[] feedFilterName_type_info = new String[]{'feedFilterName',SOAP_M_URI,null,'0','1','false'};
    private String[] feedFilterType_type_info = new String[]{'feedFilterType',SOAP_M_URI,null,'1','1','false'};
    private String[] feedItemType_type_info = new String[]{'feedItemType',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'feedFilterName','feedFilterType','feedItemType'};
}

/** @description : Wrapper class to handle feed in page layout**/
public class FeedLayout {
    public Boolean autocollapsePublisher;
    public Boolean compactFeed;
    public String feedFilterPosition;
    public DynamicMetadataService.FeedLayoutFilter[] feedFilters;
    public Boolean fullWidthFeed;
    public Boolean hideSidebar;
    public Boolean highlightExternalFeedItems;
    public DynamicMetadataService.FeedLayoutComponent[] leftComponents;
    public DynamicMetadataService.FeedLayoutComponent[] rightComponents;
    public Boolean useInlineFiltersInConsole;
    private String[] autocollapsePublisher_type_info = new String[]{'autocollapsePublisher',SOAP_M_URI,null,'0','1','false'};
    private String[] compactFeed_type_info = new String[]{'compactFeed',SOAP_M_URI,null,'0','1','false'};
    private String[] feedFilterPosition_type_info = new String[]{'feedFilterPosition',SOAP_M_URI,null,'0','1','false'};
    private String[] feedFilters_type_info = new String[]{'feedFilters',SOAP_M_URI,null,'0','-1','false'};
    private String[] fullWidthFeed_type_info = new String[]{'fullWidthFeed',SOAP_M_URI,null,'0','1','false'};
    private String[] hideSidebar_type_info = new String[]{'hideSidebar',SOAP_M_URI,null,'0','1','false'};
    private String[] highlightExternalFeedItems_type_info = new String[]{'highlightExternalFeedItems',SOAP_M_URI,null,'0','1','false'};
    private String[] leftComponents_type_info = new String[]{'leftComponents',SOAP_M_URI,null,'0','-1','false'};
    private String[] rightComponents_type_info = new String[]{'rightComponents',SOAP_M_URI,null,'0','-1','false'};
    private String[] useInlineFiltersInConsole_type_info = new String[]{'useInlineFiltersInConsole',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'autocollapsePublisher','compactFeed','feedFilterPosition','feedFilters','fullWidthFeed','hideSidebar','highlightExternalFeedItems','leftComponents','rightComponents','useInlineFiltersInConsole'};
}

/** @description : Wrapper class to handle read metadata element **/
public class readMetadata_element {
    public String type_x;
    public String[] fullNames;
    private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'1','1','false'};
    private String[] fullNames_type_info = new String[]{'fullNames',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'type_x','fullNames'};
}

/** @description : Wrapper class to handle update metadata response**/
public class updateMetadataResponse_element {
    public DynamicMetadataService.SaveResult[] result;
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to handle flow choice translation in flow**/
public class FlowChoiceTranslation {
    public String choiceText;
    public String name;
    public DynamicMetadataService.FlowChoiceUserInputTranslation userInput;
    private String[] choiceText_type_info = new String[]{'choiceText',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] userInput_type_info = new String[]{'userInput',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'choiceText','name','userInput'};
}

/** @description : Wrapper class to handle custom permissions in permission set**/
public class PermissionSetCustomPermissions {
    public Boolean enabled;
    public String name;
    private String[] enabled_type_info = new String[]{'enabled',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'enabled','name'};
}

/** @description : Wrapper class to handle flow text template in flow**/
public class FlowTextTemplate extends FlowElement {
    public String type = 'FlowTextTemplate';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String text;
    private String[] text_type_info = new String[]{'text',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'text'};
}

/** @description : Wrapper class to handle flow screen in flow**/
public class FlowScreen extends FlowNode {
    public String type = 'FlowScreen';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public Boolean allowBack;
    public Boolean allowFinish;
    public Boolean allowPause;
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowScreenField[] fields;
    public String helpText;
    public String pausedText;
    public DynamicMetadataService.FlowScreenRule[] rules;
    public Boolean showFooter;
    public Boolean showHeader;
    private String[] allowBack_type_info = new String[]{'allowBack',SOAP_M_URI,null,'0','1','false'};
    private String[] allowFinish_type_info = new String[]{'allowFinish',SOAP_M_URI,null,'0','1','false'};
    private String[] allowPause_type_info = new String[]{'allowPause',SOAP_M_URI,null,'0','1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
    private String[] helpText_type_info = new String[]{'helpText',SOAP_M_URI,null,'0','1','false'};
    private String[] pausedText_type_info = new String[]{'pausedText',SOAP_M_URI,null,'0','1','false'};
    private String[] rules_type_info = new String[]{'rules',SOAP_M_URI,null,'0','-1','false'};
    private String[] showFooter_type_info = new String[]{'showFooter',SOAP_M_URI,null,'0','1','false'};
    private String[] showHeader_type_info = new String[]{'showHeader',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'allowBack','allowFinish','allowPause','connector','fields','helpText','pausedText','rules','showFooter','showHeader'};
}

/** @description : Wrapper class to handle flow screen rule action in flow**/
public class FlowScreenRuleAction {
    public String attribute;
    public String fieldReference;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] attribute_type_info = new String[]{'attribute',SOAP_M_URI,null,'1','1','false'};
    private String[] fieldReference_type_info = new String[]{'fieldReference',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'attribute','fieldReference','value'};
}

/** @description : Wrapper class to handle flow record filter in flow**/
public class FlowRecordFilter extends FlowBaseElement {
    public String type = 'FlowRecordFilter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String field;
    public String operator;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
    private String[] operator_type_info = new String[]{'operator',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'field','operator','value'};
}

/** @description : Wrapper class to handle delete metadata element**/
public class deleteMetadata_element {
    public String type_x;
    public String[] fullNames;
    private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'1','1','false'};
    private String[] fullNames_type_info = new String[]{'fullNames',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'type_x','fullNames'};
}

/** @description : Wrapper class to handle action call in flow**/
public class FlowActionCall extends FlowNode {
    public String type = 'FlowActionCall';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public String actionName;
    public String actionType;
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowDataTypeMapping[] dataTypeMappings;
    public DynamicMetadataService.FlowActionCallInputParameter[] inputParameters;
    public DynamicMetadataService.FlowActionCallOutputParameter[] outputParameters;
    public String flowTransactionModel;
    private transient String[] flowTransactionModel_type_info = new String[]{'flowTransactionModel',SOAP_M_URI,'FlowTransactionModel','0','1','false'};
    private String[] actionName_type_info = new String[]{'actionName',SOAP_M_URI,null,'1','1','false'};
    private transient String[] dataTypeMappings_type_info = new String[]{'dataTypeMappings',SOAP_M_URI,'FlowDataTypeMapping','0','-1','false'};
    private String[] actionType_type_info = new String[]{'actionType',SOAP_M_URI,null,'1','1','false'};
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] inputParameters_type_info = new String[]{'inputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] outputParameters_type_info = new String[]{'outputParameters',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'actionName','actionType','connector','dataTypeMappings','faultConnector','flowTransactionModel','inputParameters','outputParameters'};
}

/** @description : Wrapper class to handle data type mapping in flow**/
public class FlowDataTypeMapping {
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private transient String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,'FlowMetadataValue','0','-1','false'};
    public String typeName;
    public String typeValue;
    private transient String[] typeName_type_info = new String[]{'typeName',SOAP_M_URI,'string','1','1','false'};
    private transient String[] typeValue_type_info = new String[]{'typeValue',SOAP_M_URI,'string','1','1','false'};
    private transient String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private transient String[] field_order_type_info = new String[]{'processMetadataValues','typeName','typeValue'};
}

/** @description : Wrapper class to handle apex plugin call input parameter in flow**/
 public class FlowApexPluginCallInputParameter extends FlowBaseElement {
    public String type = 'FlowApexPluginCallInputParameter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String name;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'name','value'};
}

/** @description : Wrapper class to handle rename metadata response**/
public class renameMetadataResponse_element {
    public DynamicMetadataService.SaveResult result;
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to handle related list in page layout**/
public class RelatedList {
    public Boolean hideOnDetail;
    public String name;
    private String[] hideOnDetail_type_info = new String[]{'hideOnDetail',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'hideOnDetail','name'};
}

/** @description : Wrapper class to handle subflow in flow**/
public class FlowSubflow extends FlowNode {
    public String type = 'FlowSubflow';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowConnector connector;
    public String flowName;
    public DynamicMetadataService.FlowSubflowInputAssignment[] inputAssignments;
    public DynamicMetadataService.FlowSubflowOutputAssignment[] outputAssignments;
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] flowName_type_info = new String[]{'flowName',SOAP_M_URI,null,'1','1','false'};
    private String[] inputAssignments_type_info = new String[]{'inputAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] outputAssignments_type_info = new String[]{'outputAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'connector','flowName','inputAssignments','outputAssignments'};
}

/** @description : Wrapper class to handle decision in flow**/
public class FlowDecision extends FlowNode {
    public String type = 'FlowDecision';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowConnector defaultConnector;
    public String defaultConnectorLabel;
    public DynamicMetadataService.FlowRule[] rules;
    private String[] defaultConnector_type_info = new String[]{'defaultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] defaultConnectorLabel_type_info = new String[]{'defaultConnectorLabel',SOAP_M_URI,null,'0','1','false'};
    private String[] rules_type_info = new String[]{'rules',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'defaultConnector','defaultConnectorLabel','rules'};
}

/** @description : Wrapper class to handle record type visibility in profile**/
public class ProfileRecordTypeVisibility {
    public Boolean default_x;
    public Boolean personAccountDefault;
    public String recordType;
    public Boolean visible;
    private String[] default_x_type_info = new String[]{'default',SOAP_M_URI,null,'1','1','false'};
    private String[] personAccountDefault_type_info = new String[]{'personAccountDefault',SOAP_M_URI,null,'0','1','false'};
    private String[] recordType_type_info = new String[]{'recordType',SOAP_M_URI,null,'1','1','false'};
    private String[] visible_type_info = new String[]{'visible',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'default_x','personAccountDefault','recordType','visible'};
}

/** @description : Interface class to read result**/
public interface IReadResult {
    DynamicMetadataService.Metadata[] getRecords();
}

/** @description : Interface class to handle read response**/
public interface IReadResponseElement {
    IReadResult getResult();
}

/** @description : Wrapper class to read custom field result**/
public class ReadCustomFieldResult implements IReadResult {
    public DynamicMetadataService.CustomField[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to handle flow rule in flow**/
public class readCustomFieldResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadCustomFieldResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read record type result**/
public class ReadRecordTypeResult implements IReadResult {
    public DynamicMetadataService.RecordType[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to read record type response in flow**/
public class readRecordTypeResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadRecordTypeResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read page layout result**/
public class ReadLayoutResult implements IReadResult {
    public DynamicMetadataService.Layout[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to handle read page layout response element in flow**/
public class readLayoutResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadLayoutResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read report type result**/
public class ReadReportTypeResult implements IReadResult {
    public DynamicMetadataService.ReportType[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to read report type response element**/
public class readReportTypeResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadReportTypeResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read flow result**/
public class ReadFlowResult implements IReadResult {
    public DynamicMetadataService.Flow[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to read flow response element**/
public class readFlowResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadFlowResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read translation result**/
public class ReadTranslationsResult implements IReadResult {
    public DynamicMetadataService.Translations[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to handle custom application translation**/
public class CustomApplicationTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}
public class CustomDataTypeTranslation {
    public DynamicMetadataService.CustomDataTypeComponentTranslation[] components;
    public String customDataTypeName;
    public String description;
    public String label;
    private String[] components_type_info = new String[]{'components',SOAP_M_URI,null,'0','-1','false'};
    private String[] customDataTypeName_type_info = new String[]{'customDataTypeName',SOAP_M_URI,null,'1','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'components','customDataTypeName','description','label'};
}

/** @description : Wrapper class to handle custom label translation**/
public class CustomLabelTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}

/** @description : Wrapper class to handle custom page web link translation**/
public class CustomPageWebLinkTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}

/** @description : Wrapper class to handle custom tab translation**/
public class CustomTabTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}

/** @description : Wrapper class to handle global quick action translation**/
public class GlobalQuickActionTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}

/** @description : Wrapper class to handle Scontrol translation**/
public class ScontrolTranslation {
    public String label;
    public String name;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'label','name'};
}

/** @description : Wrapper class to handle translations**/
public class Translations extends Metadata {
    public String type = 'Translations';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public DynamicMetadataService.CustomApplicationTranslation[] customApplications;
    public DynamicMetadataService.CustomDataTypeTranslation[] customDataTypeTranslations;
    public DynamicMetadataService.CustomLabelTranslation[] customLabels;
    public DynamicMetadataService.CustomPageWebLinkTranslation[] customPageWebLinks;
    public DynamicMetadataService.CustomTabTranslation[] customTabs;
    public DynamicMetadataService.FlowDefinitionTranslation[] flowDefinitions;
    public DynamicMetadataService.GlobalQuickActionTranslation[] quickActions;
    public DynamicMetadataService.ReportTypeTranslation[] reportTypes;
    public DynamicMetadataService.ScontrolTranslation[] scontrols;
    private String[] customApplications_type_info = new String[]{'customApplications',SOAP_M_URI,null,'0','-1','false'};
    private String[] customDataTypeTranslations_type_info = new String[]{'customDataTypeTranslations',SOAP_M_URI,null,'0','-1','false'};
    private String[] customLabels_type_info = new String[]{'customLabels',SOAP_M_URI,null,'0','-1','false'};
    private String[] customPageWebLinks_type_info = new String[]{'customPageWebLinks',SOAP_M_URI,null,'0','-1','false'};
    private String[] customTabs_type_info = new String[]{'customTabs',SOAP_M_URI,null,'0','-1','false'};
    private String[] flowDefinitions_type_info = new String[]{'flowDefinitions',SOAP_M_URI,null,'0','-1','false'};
    private String[] quickActions_type_info = new String[]{'quickActions',SOAP_M_URI,null,'0','-1','false'};
    private String[] reportTypes_type_info = new String[]{'reportTypes',SOAP_M_URI,null,'0','-1','false'};
    private String[] scontrols_type_info = new String[]{'scontrols',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'customApplications','customDataTypeTranslations','customLabels','customPageWebLinks','customTabs','flowDefinitions','quickActions','reportTypes','scontrols'};
}

/** @description : Wrapper class to handle read translation response**/
public class readTranslationsResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadTranslationsResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}
/** @description : Wrapper class to read profile result**/
public class ReadProfileResult implements IReadResult {
    public DynamicMetadataService.Profile[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to read profile response element**/
public class readProfileResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadProfileResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read permission set result**/
public class ReadPermissionSetResult implements IReadResult {
    public DynamicMetadataService.PermissionSet[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to read permission set response element**/
public class readPermissionSetResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadPermissionSetResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read custom metadata result**/
public class ReadCustomMetadataResult implements IReadResult {
    public DynamicMetadataService.CustomMetadata[] records;
    public DynamicMetadataService.Metadata[] getRecords() { return records; }
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to read custom metadata response element**/
public class readCustomMetadataResponse_element implements IReadResponseElement {
    public DynamicMetadataService.ReadCustomMetadataResult result;
    public IReadResult getResult() { return result; }
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to read result**/
public class ReadResult {
    public DynamicMetadataService.Metadata[] records;
    private String[] records_type_info = new String[]{'records',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'records'};
}

/** @description : Wrapper class to handle section in page layout**/
public class LayoutSection {
    public Boolean customLabel;
    public Boolean detailHeading;
    public Boolean editHeading;
    public String label;
    public DynamicMetadataService.LayoutColumn[] layoutColumns;
    public String style;
    private String[] customLabel_type_info = new String[]{'customLabel',SOAP_M_URI,null,'0','1','false'};
    private String[] detailHeading_type_info = new String[]{'detailHeading',SOAP_M_URI,null,'0','1','false'};
    private String[] editHeading_type_info = new String[]{'editHeading',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] layoutColumns_type_info = new String[]{'layoutColumns',SOAP_M_URI,null,'0','-1','false'};
    private String[] style_type_info = new String[]{'style',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'customLabel','detailHeading','editHeading','label','layoutColumns','style'};
}

/** @description : Wrapper class to handle Metadata value in flow**/
public class FlowMetadataValue {
    public String name;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'name','value'};
}

/** @description : Wrapper class to handle object permissions in profile**/
public class ProfileObjectPermissions {
    public Boolean allowCreate;
    public Boolean allowDelete;
    public Boolean allowEdit;
    public Boolean allowRead;
    public Boolean modifyAllRecords;
    public String object_x;
    public Boolean viewAllRecords;
    private String[] allowCreate_type_info = new String[]{'allowCreate',SOAP_M_URI,null,'0','1','false'};
    private String[] allowDelete_type_info = new String[]{'allowDelete',SOAP_M_URI,null,'0','1','false'};
    private String[] allowEdit_type_info = new String[]{'allowEdit',SOAP_M_URI,null,'0','1','false'};
    private String[] allowRead_type_info = new String[]{'allowRead',SOAP_M_URI,null,'0','1','false'};
    private String[] modifyAllRecords_type_info = new String[]{'modifyAllRecords',SOAP_M_URI,null,'0','1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'1','1','false'};
    private String[] viewAllRecords_type_info = new String[]{'viewAllRecords',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'allowCreate','allowDelete','allowEdit','allowRead','modifyAllRecords','object_x','viewAllRecords'};
}

/** @description : Wrapper class to handle deploy message**/
public class DeployMessage {
    public Boolean changed;
    public Integer columnNumber;
    public String componentType;
    public Boolean created;
    public DateTime createdDate;
    public Boolean deleted;
    public String fileName;
    public String fullName;
    public String id;
    public Integer lineNumber;
    public String problem;
    public String problemType;
    public Boolean success;
    private String[] changed_type_info = new String[]{'changed',SOAP_M_URI,null,'1','1','false'};
    private String[] columnNumber_type_info = new String[]{'columnNumber',SOAP_M_URI,null,'0','1','false'};
    private String[] componentType_type_info = new String[]{'componentType',SOAP_M_URI,null,'0','1','false'};
    private String[] created_type_info = new String[]{'created',SOAP_M_URI,null,'1','1','false'};
    private String[] createdDate_type_info = new String[]{'createdDate',SOAP_M_URI,null,'1','1','false'};
    private String[] deleted_type_info = new String[]{'deleted',SOAP_M_URI,null,'1','1','false'};
    private String[] fileName_type_info = new String[]{'fileName',SOAP_M_URI,null,'1','1','false'};
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'1','1','false'};
    private String[] id_type_info = new String[]{'id',SOAP_M_URI,null,'0','1','false'};
    private String[] lineNumber_type_info = new String[]{'lineNumber',SOAP_M_URI,null,'0','1','false'};
    private String[] problem_type_info = new String[]{'problem',SOAP_M_URI,null,'0','1','false'};
    private String[] problemType_type_info = new String[]{'problemType',SOAP_M_URI,null,'0','1','false'};
    private String[] success_type_info = new String[]{'success',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'changed','columnNumber','componentType','created','createdDate','deleted','fileName','fullName','id','lineNumber','problem','problemType','success'};
}

/** @description : Wrapper class to handle object permissions in permission set**/
public class PermissionSetObjectPermissions {
    public Boolean allowCreate;
    public Boolean allowDelete;
    public Boolean allowEdit;
    public Boolean allowRead;
    public Boolean modifyAllRecords;
    public String object_x;
    public Boolean viewAllRecords;
    private String[] allowCreate_type_info = new String[]{'allowCreate',SOAP_M_URI,null,'1','1','false'};
    private String[] allowDelete_type_info = new String[]{'allowDelete',SOAP_M_URI,null,'1','1','false'};
    private String[] allowEdit_type_info = new String[]{'allowEdit',SOAP_M_URI,null,'1','1','false'};
    private String[] allowRead_type_info = new String[]{'allowRead',SOAP_M_URI,null,'1','1','false'};
    private String[] modifyAllRecords_type_info = new String[]{'modifyAllRecords',SOAP_M_URI,null,'1','1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'1','1','false'};
    private String[] viewAllRecords_type_info = new String[]{'viewAllRecords',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'allowCreate','allowDelete','allowEdit','allowRead','modifyAllRecords','object_x','viewAllRecords'};
}

/** @description : Wrapper class to handle flow wait in flow**/
public class FlowWait extends FlowNode {
    public String type = 'FlowWait';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowConnector defaultConnector;
    public String defaultConnectorLabel;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowWaitEvent[] waitEvents;
    private String[] defaultConnector_type_info = new String[]{'defaultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] defaultConnectorLabel_type_info = new String[]{'defaultConnectorLabel',SOAP_M_URI,null,'1','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] waitEvents_type_info = new String[]{'waitEvents',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'defaultConnector','defaultConnectorLabel','faultConnector','waitEvents'};
}

/** @description : Wrapper class to handle flow stage in flow**/
public class FlowStage {
    public Boolean isActive;
    public String label;
    public Integer stageOrder;
    private String[] isActive_type_info = new String[]{'isActive',SOAP_M_URI,null,'1','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] stageOrder_type_info = new String[]{'stageOrder',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'isActive','label','stageOrder'};
}

/** @description : Wrapper class to handle chart summary in report type**/
public class ChartSummary {
    public String aggregate;
    public String axisBinding;
    public String column;
    private String[] aggregate_type_info = new String[]{'aggregate',SOAP_M_URI,null,'0','1','false'};
    private String[] axisBinding_type_info = new String[]{'axisBinding',SOAP_M_URI,null,'0','1','false'};
    private String[] column_type_info = new String[]{'column',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'aggregate','axisBinding','column'};
}

/** @description : Wrapper class to handle feed component in page layout**/
public class FeedLayoutComponent {
    public String componentType;
    public Integer height;
    public String page_x;
    private String[] componentType_type_info = new String[]{'componentType',SOAP_M_URI,null,'1','1','false'};
    private String[] height_type_info = new String[]{'height',SOAP_M_URI,null,'0','1','false'};
    private String[] page_x_type_info = new String[]{'page',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'componentType','height','page_x'};
}

/** @description : Wrapper class to handle flow condition in flow**/
public class FlowCondition extends FlowBaseElement {
    public String type = 'FlowCondition';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String leftValueReference;
    public String operator;
    public DynamicMetadataService.FlowElementReferenceOrValue rightValue;
    private String[] leftValueReference_type_info = new String[]{'leftValueReference',SOAP_M_URI,null,'1','1','false'};
    private String[] operator_type_info = new String[]{'operator',SOAP_M_URI,null,'1','1','false'};
    private String[] rightValue_type_info = new String[]{'rightValue',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'leftValueReference','operator','rightValue'};
}

/** @description : Wrapper class to handle describe metadata result**/
public class DescribeMetadataResult {
    public DynamicMetadataService.DescribeMetadataObject[] metadataObjects;
    public String organizationNamespace;
    public Boolean partialSaveAllowed;
    public Boolean testRequired;
    private String[] metadataObjects_type_info = new String[]{'metadataObjects',SOAP_M_URI,null,'0','-1','false'};
    private String[] organizationNamespace_type_info = new String[]{'organizationNamespace',SOAP_M_URI,null,'1','1','false'};
    private String[] partialSaveAllowed_type_info = new String[]{'partialSaveAllowed',SOAP_M_URI,null,'1','1','false'};
    private String[] testRequired_type_info = new String[]{'testRequired',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'metadataObjects','organizationNamespace','partialSaveAllowed','testRequired'};
}

/** @description : Wrapper class to create report type**/
public class ReportType extends Metadata {
    public String type = 'ReportType';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public Boolean autogenerated;
    public String baseObject;
    
    public String category;
    public Boolean deployed;
    public String description;
    public DynamicMetadataService.ObjectRelationship join_x;
    public String label;
    public DynamicMetadataService.ReportLayoutSection[] sections;
    private String[] autogenerated_type_info = new String[]{'au	togenerated',SOAP_M_URI,null,'0','1','false'};
    private String[] baseObject_type_info = new String[]{'baseObject',SOAP_M_URI,null,'1','1','false'};
    private String[] category_type_info = new String[]{'category',SOAP_M_URI,null,'1','1','false'};
    private String[] deployed_type_info = new String[]{'deployed',SOAP_M_URI,null,'1','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] join_x_type_info = new String[]{'join',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] sections_type_info = new String[]{'sections',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'autogenerated','baseObject','category','deployed','description','join_x','label','sections'};
}

/** @description : Wrapper class to handle sub flow input assignment in flow**/
public class FlowSubflowInputAssignment extends FlowBaseElement {
    public String type = 'FlowSubflowInputAssignment';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String name;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'name','value'};
}

/** @description : Wrapper class to handle flow formula in flow**/
public class FlowFormula extends FlowElement {
    public String type = 'FlowFormula';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String dataType;
    public String expression;
    public Integer scale;
    private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'0','1','false'};
    private String[] expression_type_info = new String[]{'expression',SOAP_M_URI,null,'1','1','false'};
    private String[] scale_type_info = new String[]{'scale',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'dataType','expression','scale'};
}

/** @description : Wrapper class to handle report type section translation**/
public class ReportTypeSectionTranslation {
    public DynamicMetadataService.ReportTypeColumnTranslation[] columns;
    public String label;
    public String name;
    private String[] columns_type_info = new String[]{'columns',SOAP_M_URI,null,'0','-1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'columns','label','name'};
}

/** @description : Wrapper class to handle flow screen field output parameter in flow**/
public class FlowScreenFieldOutputParameter {
    public String assignToReference;
    public String name;
    private String[] assignToReference_type_info = new String[]{'assignToReference',SOAP_M_URI,null,'1','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'assignToReference','name'};
}

/** @description : Wrapper class to handle translation in page layout**/
public class LayoutTranslation {
    public String layout;
    public String layoutType;
    public DynamicMetadataService.LayoutSectionTranslation[] sections;
    private String[] layout_type_info = new String[]{'layout',SOAP_M_URI,null,'1','1','false'};
    private String[] layoutType_type_info = new String[]{'layoutType',SOAP_M_URI,null,'0','1','false'};
    private String[] sections_type_info = new String[]{'sections',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'layout','layoutType','sections'};
}

/** @description : Wrapper class to handle flow constant in flow**/
public class FlowConstant extends FlowElement {
    public String type = 'FlowConstant';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String dataType;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'dataType','value'};
}

/** @description : Wrapper class to create metadata element**/
public class createMetadata_element {
    public DynamicMetadataService.Metadata[] metadata;
    private String[] metadata_type_info = new String[]{'metadata',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'metadata'};
}

/** @description : Wrapper class to describe metadata response element**/
public class describeMetadataResponse_element {
    public DynamicMetadataService.DescribeMetadataResult result;
    private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'result'};
}

/** @description : Wrapper class to handle flow action call input parameter in flow**/
public class FlowActionCallInputParameter extends FlowBaseElement {
    public String type = 'FlowActionCallInputParameter';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String name;
    public DynamicMetadataService.FlowElementReferenceOrValue value;
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues', 'name','value'};
}

/** @description : Wrapper class to handle record update in flow**/
public class FlowRecordUpdate extends FlowNode {
    public String type = 'FlowRecordUpdate';
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
    private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
    public String description;
    public String name;
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
    public String label;
    public Integer locationX;
    public Integer locationY;
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
    private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
    private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
    public DynamicMetadataService.FlowConnector connector;
    public DynamicMetadataService.FlowConnector faultConnector;
    public DynamicMetadataService.FlowRecordFilter[] filters;
    public DynamicMetadataService.FlowInputFieldAssignment[] inputAssignments;
    public String inputReference;
    public String object_x;
    private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
    private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
    private String[] filters_type_info = new String[]{'filters',SOAP_M_URI,null,'0','-1','false'};
    private String[] inputAssignments_type_info = new String[]{'inputAssignments',SOAP_M_URI,null,'0','-1','false'};
    private String[] inputReference_type_info = new String[]{'inputReference',SOAP_M_URI,null,'0','1','false'};
    private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'connector','faultConnector','filters','inputAssignments','inputReference','object_x'};
}

/** @description : Wrapper class to handle flow input validation rule in flow**/
public class FlowInputValidationRuleTranslation {
    public String errorMessage;
    private String[] errorMessage_type_info = new String[]{'errorMessage',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'errorMessage'};
}

/** @description : Wrapper class to create summary layout**/
public class SummaryLayout {
    public String masterLabel;
    public Integer sizeX;
    public Integer sizeY;
    public Integer sizeZ;
    public DynamicMetadataService.SummaryLayoutItem[] summaryLayoutItems;
    public String summaryLayoutStyle;
    private String[] masterLabel_type_info = new String[]{'masterLabel',SOAP_M_URI,null,'1','1','false'};
    private String[] sizeX_type_info = new String[]{'sizeX',SOAP_M_URI,null,'1','1','false'};
    private String[] sizeY_type_info = new String[]{'sizeY',SOAP_M_URI,null,'0','1','false'};
    private String[] sizeZ_type_info = new String[]{'sizeZ',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryLayoutItems_type_info = new String[]{'summaryLayoutItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] summaryLayoutStyle_type_info = new String[]{'summaryLayoutStyle',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'masterLabel','sizeX','sizeY','sizeZ','summaryLayoutItems','summaryLayoutStyle'};
}

/** @description : Virtual class to handle flow base element in flow**/
public virtual class FlowBaseElement {
    public DynamicMetadataService.FlowMetadataValue[] processMetadataValues;
}

/** @description : Wrapper class to handle flow choice user input translation in flow**/
public class FlowChoiceUserInputTranslation {
    public String promptText;
    public DynamicMetadataService.FlowInputValidationRuleTranslation validationRule;
    private String[] promptText_type_info = new String[]{'promptText',SOAP_M_URI,null,'0','1','false'};
    private String[] validationRule_type_info = new String[]{'validationRule',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'promptText','validationRule'};
}

/** @description : Wrapper class to handle lookup filter in report type**/
public class LookupFilter {
    public Boolean active;
    public String booleanFilter;
    public String description;
    public String errorMessage;
    public DynamicMetadataService.FilterItem[] filterItems;
    public String infoMessage;
    public Boolean isOptional;
    private String[] active_type_info = new String[]{'active',SOAP_M_URI,null,'1','1','false'};
    private String[] booleanFilter_type_info = new String[]{'booleanFilter',SOAP_M_URI,null,'0','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] errorMessage_type_info = new String[]{'errorMessage',SOAP_M_URI,null,'0','1','false'};
    private String[] filterItems_type_info = new String[]{'filterItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] infoMessage_type_info = new String[]{'infoMessage',SOAP_M_URI,null,'0','1','false'};
    private String[] isOptional_type_info = new String[]{'isOptional',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'active','booleanFilter','description','errorMessage','filterItems','infoMessage','isOptional'};
}

/** @description : Wrapper class to handle lookup filter translation in report type**/
public class LookupFilterTranslation {
    public String errorMessage;
    public String informationalMessage;
    private String[] errorMessage_type_info = new String[]{'errorMessage',SOAP_M_URI,null,'1','1','false'};
    private String[] informationalMessage_type_info = new String[]{'informationalMessage',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'errorMessage','informationalMessage'};
}

/** @description : Wrapper class to create custom field**/
public class CustomField extends Metadata {
    public String type = 'CustomField';
    public String fullName;
    private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
    public String businessOwnerGroup;
    public String businessOwnerUser;
    public String businessStatus;
    public Boolean caseSensitive;
    public String customDataType;
    public String defaultValue;
    public String deleteConstraint;
    public Boolean deprecated;
    public String description;
    public String displayFormat;
    public Boolean displayLocationInDecimal;
    public Boolean encrypted;
    public Boolean escapeMarkup;
    public String externalDeveloperName;
    public Boolean externalId;
    public String fieldManageability;
    public String formula;
    public String formulaTreatBlanksAs;
    public String inlineHelpText;
    public Boolean isConvertLeadDisabled;
    public Boolean isFilteringDisabled;
    public Boolean isNameField;
    public Boolean isSortingDisabled;
    public String label;
    public Integer length;
    public DynamicMetadataService.LookupFilter lookupFilter;
    public String maskChar;
    public String maskType;
    public String metadataRelationshipControllingField;
    public Boolean populateExistingRows;
    public Integer precision;
    public String referenceTargetField;
    public String referenceTo;
    public String relationshipLabel;
    public String relationshipName;
    public Integer relationshipOrder;
    public Boolean reparentableMasterDetail;
    public Boolean required;
    public Boolean restrictedAdminField;
    public Integer scale;
    public String securityClassification;
    public Integer startingNumber;
    public Boolean stripMarkup;
    public String summarizedField;
    public DynamicMetadataService.FilterItem[] summaryFilterItems;
    public String summaryForeignKey;
    public String summaryOperation;
    public Boolean trackFeedHistory;
    public Boolean trackHistory;
    public Boolean trackTrending;
    public String type_x;
    public Boolean unique;
    public DynamicMetadataService.ValueSet valueSet;
    public Integer visibleLines;
    public Boolean writeRequiresMasterRead;
    private String[] businessOwnerGroup_type_info = new String[]{'businessOwnerGroup',SOAP_M_URI,null,'0','1','false'};
    private String[] businessOwnerUser_type_info = new String[]{'businessOwnerUser',SOAP_M_URI,null,'0','1','false'};
    private String[] businessStatus_type_info = new String[]{'businessStatus',SOAP_M_URI,null,'0','1','false'};
    private String[] caseSensitive_type_info = new String[]{'caseSensitive',SOAP_M_URI,null,'0','1','false'};
    private String[] customDataType_type_info = new String[]{'customDataType',SOAP_M_URI,null,'0','1','false'};
    private String[] defaultValue_type_info = new String[]{'defaultValue',SOAP_M_URI,null,'0','1','false'};
    private String[] deleteConstraint_type_info = new String[]{'deleteConstraint',SOAP_M_URI,null,'0','1','false'};
    private String[] deprecated_type_info = new String[]{'deprecated',SOAP_M_URI,null,'0','1','false'};
    private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
    private String[] displayFormat_type_info = new String[]{'displayFormat',SOAP_M_URI,null,'0','1','false'};
    private String[] displayLocationInDecimal_type_info = new String[]{'displayLocationInDecimal',SOAP_M_URI,null,'0','1','false'};
    private String[] encrypted_type_info = new String[]{'encrypted',SOAP_M_URI,null,'0','1','false'};
    private String[] escapeMarkup_type_info = new String[]{'escapeMarkup',SOAP_M_URI,null,'0','1','false'};
    private String[] externalDeveloperName_type_info = new String[]{'externalDeveloperName',SOAP_M_URI,null,'0','1','false'};
    private String[] externalId_type_info = new String[]{'externalId',SOAP_M_URI,null,'0','1','false'};
    private String[] fieldManageability_type_info = new String[]{'fieldManageability',SOAP_M_URI,null,'0','1','false'};
    private String[] formula_type_info = new String[]{'formula',SOAP_M_URI,null,'0','1','false'};
    private String[] formulaTreatBlanksAs_type_info = new String[]{'formulaTreatBlanksAs',SOAP_M_URI,null,'0','1','false'};
    private String[] inlineHelpText_type_info = new String[]{'inlineHelpText',SOAP_M_URI,null,'0','1','false'};
    private String[] isConvertLeadDisabled_type_info = new String[]{'isConvertLeadDisabled',SOAP_M_URI,null,'0','1','false'};
    private String[] isFilteringDisabled_type_info = new String[]{'isFilteringDisabled',SOAP_M_URI,null,'0','1','false'};
    private String[] isNameField_type_info = new String[]{'isNameField',SOAP_M_URI,null,'0','1','false'};
    private String[] isSortingDisabled_type_info = new String[]{'isSortingDisabled',SOAP_M_URI,null,'0','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] length_type_info = new String[]{'length',SOAP_M_URI,null,'0','1','false'};
    private String[] lookupFilter_type_info = new String[]{'lookupFilter',SOAP_M_URI,null,'0','1','false'};
    private String[] maskChar_type_info = new String[]{'maskChar',SOAP_M_URI,null,'0','1','false'};
    private String[] maskType_type_info = new String[]{'maskType',SOAP_M_URI,null,'0','1','false'};
    private String[] metadataRelationshipControllingField_type_info = new String[]{'metadataRelationshipControllingField',SOAP_M_URI,null,'0','1','false'};
    private String[] populateExistingRows_type_info = new String[]{'populateExistingRows',SOAP_M_URI,null,'0','1','false'};
    private String[] precision_type_info = new String[]{'precision',SOAP_M_URI,null,'0','1','false'};
    private String[] referenceTargetField_type_info = new String[]{'referenceTargetField',SOAP_M_URI,null,'0','1','false'};
    private String[] referenceTo_type_info = new String[]{'referenceTo',SOAP_M_URI,null,'0','1','false'};
    private String[] relationshipLabel_type_info = new String[]{'relationshipLabel',SOAP_M_URI,null,'0','1','false'};
    private String[] relationshipName_type_info = new String[]{'relationshipName',SOAP_M_URI,null,'0','1','false'};
    private String[] relationshipOrder_type_info = new String[]{'relationshipOrder',SOAP_M_URI,null,'0','1','false'};
    private String[] reparentableMasterDetail_type_info = new String[]{'reparentableMasterDetail',SOAP_M_URI,null,'0','1','false'};
    private String[] required_type_info = new String[]{'required',SOAP_M_URI,null,'0','1','false'};
    private String[] restrictedAdminField_type_info = new String[]{'restrictedAdminField',SOAP_M_URI,null,'0','1','false'};
    private String[] scale_type_info = new String[]{'scale',SOAP_M_URI,null,'0','1','false'};
    private String[] securityClassification_type_info = new String[]{'securityClassification',SOAP_M_URI,null,'0','1','false'};
    private String[] startingNumber_type_info = new String[]{'startingNumber',SOAP_M_URI,null,'0','1','false'};
    private String[] stripMarkup_type_info = new String[]{'stripMarkup',SOAP_M_URI,null,'0','1','false'};
    private String[] summarizedField_type_info = new String[]{'summarizedField',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryFilterItems_type_info = new String[]{'summaryFilterItems',SOAP_M_URI,null,'0','-1','false'};
    private String[] summaryForeignKey_type_info = new String[]{'summaryForeignKey',SOAP_M_URI,null,'0','1','false'};
    private String[] summaryOperation_type_info = new String[]{'summaryOperation',SOAP_M_URI,null,'0','1','false'};
    private String[] trackFeedHistory_type_info = new String[]{'trackFeedHistory',SOAP_M_URI,null,'0','1','false'};
    private String[] trackHistory_type_info = new String[]{'trackHistory',SOAP_M_URI,null,'0','1','false'};
    private String[] trackTrending_type_info = new String[]{'trackTrending',SOAP_M_URI,null,'0','1','false'};
    private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'0','1','false'};
    private String[] unique_type_info = new String[]{'unique',SOAP_M_URI,null,'0','1','false'};
    private String[] valueSet_type_info = new String[]{'valueSet',SOAP_M_URI,null,'0','1','false'};
    private String[] visibleLines_type_info = new String[]{'visibleLines',SOAP_M_URI,null,'0','1','false'};
    private String[] writeRequiresMasterRead_type_info = new String[]{'writeRequiresMasterRead',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'businessOwnerGroup','businessOwnerUser','businessStatus','caseSensitive','customDataType','defaultValue','deleteConstraint','deprecated','description','displayFormat','displayLocationInDecimal','encrypted','escapeMarkup','externalDeveloperName','externalId','fieldManageability','formula','formulaTreatBlanksAs','inlineHelpText','isConvertLeadDisabled','isFilteringDisabled','isNameField','isSortingDisabled','label','length','lookupFilter','maskChar','maskType','metadataRelationshipControllingField','populateExistingRows','precision','referenceTargetField','referenceTo','relationshipLabel','relationshipName','relationshipOrder','reparentableMasterDetail','required','restrictedAdminField','scale','securityClassification','startingNumber','stripMarkup','summarizedField','summaryFilterItems','summaryForeignKey','summaryOperation','trackFeedHistory','trackHistory','trackTrending','type_x','unique','valueSet','visibleLines','writeRequiresMasterRead'};
}
public class CustomDataTypeComponentTranslation {
    public String developerSuffix;
    public String label;
    private String[] developerSuffix_type_info = new String[]{'developerSuffix',SOAP_M_URI,null,'1','1','false'};
    private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'developerSuffix','label'};
}

/** @description : Wrapper class to handle value set in fields**/
public class ValueSet {
    public String controllingField;
    public Boolean restricted;
    public DynamicMetadataService.ValueSetValuesDefinition valueSetDefinition;
    public String valueSetName;
    public DynamicMetadataService.ValueSettings[] valueSettings;
    private String[] controllingField_type_info = new String[]{'controllingField',SOAP_M_URI,null,'0','1','false'};
    private String[] restricted_type_info = new String[]{'restricted',SOAP_M_URI,null,'0','1','false'};
    private String[] valueSetDefinition_type_info = new String[]{'valueSetDefinition',SOAP_M_URI,null,'0','1','false'};
    private String[] valueSetName_type_info = new String[]{'valueSetName',SOAP_M_URI,null,'0','1','false'};
    private String[] valueSettings_type_info = new String[]{'valueSettings',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'controllingField','restricted','valueSetDefinition','valueSetName','valueSettings'};
}

/** @description : Wrapper class to handle value set values definition**/
public class ValueSetValuesDefinition {
    public Boolean sorted;
    public DynamicMetadataService.CustomValue[] value;
    private String[] sorted_type_info = new String[]{'sorted',SOAP_M_URI,null,'1','1','false'};
    private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','-1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'sorted','value'};
}

/** @description : Wrapper class to handle value settings**/
public class ValueSettings {
    public String[] controllingFieldValue;
    public String valueName;
    private String[] controllingFieldValue_type_info = new String[]{'controllingFieldValue',SOAP_M_URI,null,'0','-1','false'};
    private String[] valueName_type_info = new String[]{'valueName',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'controllingFieldValue','valueName'};
}

/** @description : Virtual class to handle custom value**/
public virtual class CustomValue extends Metadata {
    public String color;
    public Boolean default_x;
    public String description;
    public Boolean isActive;
    public String label;
}

/** @description : Wrapper class to establish connection with Metadata Api**/
public class MetadataPort {
    public String endpoint_x = URL.getOrgDomainUrl().toExternalForm() + '/services/Soap/m/56.0';
    public Map<String,String> inputHttpHeaders_x;
    public Map<String,String> outputHttpHeaders_x;
    public String clientCertName_x;
    public String clientCert_x;
    public String clientCertPasswd_x;
    public Integer timeout_x;
    public DynamicMetadataService.SessionHeader_element SessionHeader;
    public DynamicMetadataService.DebuggingInfo_element DebuggingInfo;
    public DynamicMetadataService.DebuggingHeader_element DebuggingHeader;
    public DynamicMetadataService.CallOptions_element CallOptions;
    public DynamicMetadataService.AllOrNoneHeader_element AllOrNoneHeader;
    private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/2006/04/metadata';
    private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/2006/04/metadata';
    private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/2006/04/metadata';
    private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/2006/04/metadata';
    private String AllOrNoneHeader_hns = 'AllOrNoneHeader=http://soap.sforce.com/2006/04/metadata';
    private String[] ns_map_type_info = new String[]{SOAP_M_URI, 'DynamicMetadataService'};   
    public DynamicMetadataService.SaveResult[] updateMetadata(DynamicMetadataService.Metadata[] metadata) {
        DynamicMetadataService.updateMetadata_element request_x = new DynamicMetadataService.updateMetadata_element();
        request_x.metadata = metadata;
        DynamicMetadataService.updateMetadataResponse_element response_x;
        Map<String, DynamicMetadataService.updateMetadataResponse_element> response_map_x = new Map<String, DynamicMetadataService.updateMetadataResponse_element>();
        response_map_x.put('response_x', response_x);
        WebServiceCallout.invoke(
          this,
          request_x,
          response_map_x,
          new String[]{endpoint_x,
          '',
          SOAP_M_URI,
          'updateMetadata',
          SOAP_M_URI,
          'updateMetadataResponse',
          'DynamicMetadataService.updateMetadataResponse_element'}
        );
        response_x = response_map_x.get('response_x');
        return response_x.result;
    }
    
   /** @description : Method to describe metadata**/
   public DynamicMetadataService.DescribeMetadataResult describeMetadata(Double asOfVersion) {
        DynamicMetadataService.describeMetadata_element request_x = new DynamicMetadataService.describeMetadata_element();
        request_x.asOfVersion = asOfVersion;
        DynamicMetadataService.describeMetadataResponse_element response_x;
        Map<String, DynamicMetadataService.describeMetadataResponse_element> response_map_x = new Map<String, DynamicMetadataService.describeMetadataResponse_element>();
        response_map_x.put('response_x', response_x);
        WebServiceCallout.invoke(
          this,
          request_x,
          response_map_x,
          new String[]{endpoint_x,
          '',
          SOAP_M_URI,
          'describeMetadata',
          SOAP_M_URI,
          'describeMetadataResponse',
          'DynamicMetadataService.describeMetadataResponse_element'}
        );
        response_x = response_map_x.get('response_x');
        return response_x.result;
    }
    
    /** @description : Method to read metadata**/
    public DynamicMetadataService.IReadResult readMetadata(String type_x,String[] fullNames) {
        DynamicMetadataService.readMetadata_element request_x = new DynamicMetadataService.readMetadata_element();
        request_x.type_x = type_x;
        request_x.fullNames = fullNames;
        DynamicMetadataService.IReadResponseElement response_x;
        Map<String, DynamicMetadataService.IReadResponseElement> response_map_x = new Map<String, DynamicMetadataService.IReadResponseElement>();
        response_map_x.put('response_x', response_x);
        WebServiceCallout.invoke(
          this,
          request_x,
          response_map_x,
          new String[]{endpoint_x,
          '',
          SOAP_M_URI,
          'readMetadata',
          SOAP_M_URI,
          'readMetadataResponse',
          'DynamicMetadataService.read' + type_x + 'Response_element'}
        );
        response_x = response_map_x.get('response_x');
        return response_x.getResult();
    }
    
    /** @description : Method to create metadata**/
    public DynamicMetadataService.SaveResult[] createMetadata(DynamicMetadataService.Metadata[] metadata) {
        DynamicMetadataService.createMetadata_element request_x = new DynamicMetadataService.createMetadata_element();
        request_x.metadata = metadata;
        DynamicMetadataService.createMetadataResponse_element response_x;
        Map<String, DynamicMetadataService.createMetadataResponse_element> response_map_x = new Map<String, DynamicMetadataService.createMetadataResponse_element>();
        response_map_x.put('response_x', response_x);
        WebServiceCallout.invoke(
          this,
          request_x,
          response_map_x,
          new String[]{endpoint_x,
          '',
          SOAP_M_URI,
          'createMetadata',
          SOAP_M_URI,
          'createMetadataResponse',
          'DynamicMetadataService.createMetadataResponse_element'}
        );
        response_x = response_map_x.get('response_x');
        return response_x.result;
    }
    
    /** @description : Method to upsert metadata**/
    public DynamicMetadataService.UpsertResult[] upsertMetadata(DynamicMetadataService.Metadata[] metadata) {
        DynamicMetadataService.upsertMetadata_element request_x = new DynamicMetadataService.upsertMetadata_element();
        request_x.metadata = metadata;
        DynamicMetadataService.upsertMetadataResponse_element response_x;
        Map<String, DynamicMetadataService.upsertMetadataResponse_element> response_map_x = new Map<String, DynamicMetadataService.upsertMetadataResponse_element>();
        response_map_x.put('response_x', response_x);
        WebServiceCallout.invoke(
          this,
          request_x,
          response_map_x,
          new String[]{endpoint_x,
          '',
          SOAP_M_URI,
          'upsertMetadata',
          SOAP_M_URI,
          'upsertMetadataResponse',
          'DynamicMetadataService.upsertMetadataResponse_element'}
        );
        response_x = response_map_x.get('response_x');
        return response_x.result;
    }
}

/** @description : Wrapper class to handle debugging info**/
public class DebuggingInfo_element {
    public String debugLog;
    private String[] debugLog_type_info = new String[]{'debugLog',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'debugLog'};
}

/** @description : Wrapper class to handle debugging header**/
public class DebuggingHeader_element {
    public DynamicMetadataService.LogInfo[] categories;
    public String debugLevel;
    private String[] categories_type_info = new String[]{'categories',SOAP_M_URI,null,'0','-1','false'};
    private String[] debugLevel_type_info = new String[]{'debugLevel',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'categories','debugLevel'};
}

/** @description : Wrapper class to handle log info**/
public class LogInfo {
    public String category;
    public String level;
    private String[] category_type_info = new String[]{'category',SOAP_M_URI,null,'1','1','false'};
    private String[] level_type_info = new String[]{'level',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'category','level'};
}

/** @description : Wrapper class to handle call options**/
public class CallOptions_element {
    public String client;
    private String[] client_type_info = new String[]{'client',SOAP_M_URI,null,'1','1','false'};
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
    private String[] field_order_type_info = new String[]{'client'};
}
    

}