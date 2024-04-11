public with sharing class OrgBAccountTriggerHandler {

    @Future (callout=true)
    public static void createAccount(Id accId){
        Account acc =[SELECT Id, Name FROM Account WHERE ID = :accId];
      
        Http http = new Http ();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('Callout:ORGB/services/apexrest/Account/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(acc));

        HttpResponse response = http.send(request);
        System.debug( response.getBody());

        if (response.getStatusCode()==200) {
            String id = (String)JSON.deserializeUntyped(response.getBody());
            System.debug( 'response id' + id);
            
            if (id != null) {
                acc.Connected_Account_Id__c = id;
                
                update acc;
                System.debug( 'after Update id ' + acc.Id);
                
            }
        }else {

            System.debug( 'On error '+response.getBody());
            
        }
        
    
    }


    @Future (callout=true)
    public static void updateAccount(Id accId){
        Account acc =[SELECT Name ,Connected_Account_Id__c FROM Account WHERE ID = :accId];
        
        Http http = new Http ();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('Callout:ORGB/services/apexrest/Account/');
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
         
        acc.Id = acc.Connected_Account_Id__c;
        request.setBody(JSON.serialize(acc));
        System.debug('on update json body'+ JSON.serialize(acc));
        HttpResponse response = http.send(request);
        System.debug(response.getBody());

        if (response.getStatusCode()==200) {
            System.debug('on success json body'+response.getBody());
        }else {
            System.debug('on error json body '+response.getBody());
        }


    }


    @Future (callout=true)
    public static void onDeleteAccount(Id accId){
        // Account acc =[SELECT Connected_Account_Id__c FROM Account WHERE ID = :accId];
        
        Http http = new Http ();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('Callout:ORGB/services/apexrest/Account/'+acc.Connected_Account_Id__c);
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        HttpResponse response = http.send(request);
        System.debug(response.getBody());

        if (response.getStatusCode()==200) {
            System.debug('on success after delete json body'+response.getBody());
        }else {
            System.debug('on error after delete json body '+response.getBody());
        }


    }





}