public with sharing class ConnectedAppDemo {
    public static void callOrgB(){

        Http http = new Http ();
HttpRequest request = new HttpRequest();
request.setEndpoint('Callout:SDFC/services/apexrest/bhaskar/Cases');
request.setMethod('GET');
//request.setHeader('Content-Type', 'application/json;charset=UTF-8');
HttpResponse response = http.send(request);
System.debug(response.getBody());

if (response.getStatusCode()==200) {
System.debug(response.getBody());
    
}
    }

}