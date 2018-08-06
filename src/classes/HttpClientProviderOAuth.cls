public class HttpClientProviderOAuth implements HttpClientProviderInterface {

    public String accessToken { get; set; }
    public String authenticationUrl { get; set; }
    private Map<String, String> authParameters { get; set; }

    public HttpClientProviderOAuth(String authenticationUrl, Map<String, String> authParameters) {
        this.authenticationUrl = authenticationUrl;
        this.authParameters = authParameters;
    }

    public String getHeader() {
        this.login();
        return 'Bearer ' + accessToken;
    }

    public void login() {
        String authJson = JSON.serialize(authParameters);

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setTimeout(60000);
        req.setEndpoint(authenticationUrl);
        req.setMethod('POST');
        req.setHeader('Content-type','application/json');
        req.setBody(authJson);

        HttpResponse res = h.send(req);
        if(res.getStatusCode() != 200) {
            throw new HttpCalloutException('Login unsuccessful: ' + res.getStatus());
        }

        Map<String, Object> resValues = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

        if(resValues.containsKey('access_token')) { // OpenID format.
            accessToken = (String) resValues.get('access_token');
        }
        else if(resValues.containsKey('accessToken')) { // Marketing Cloud format.
            accessToken = (String) resValues.get('accessToken');
        }
        else {
            throw new HttpCalloutException('Unable to parse the response.');
        }
    }
}