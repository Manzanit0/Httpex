public with sharing class HttpClient {

    public ICredentialsProvider credentials { get; set; }

    public HttpClient(ICredentialsProvider credentials) {
        this.credentials = credentials;
    }

    public HttpResponse get(String endpoint, String payload) {
        return callout(endpoint, payload, 'GET');
    }

    public HttpResponse post(String endpoint, String payload) {
        return callout(endpoint, payload, 'POST');
    }

    public HttpResponse put(String endpoint, String payload) {
        return callout(endpoint, payload, 'PUT');
    }

    public HttpResponse patch(String endpoint, String payload) {
        return callout(endpoint, payload, 'PATCH');
    }

    public HttpResponse del(String endpoint, String payload) {
        return callout(endpoint, payload, 'DELETE');
    }

    public HttpResponse head(String endpoint, String payload) {
        return callout(endpoint, payload, 'HEAD');
    }

    public HttpResponse callout(String endpoint, String payload, String method) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');

        if(credentials instanceof NamedCredentialsProvider) {
            endpoint = endpoint.startsWith('/') ? endpoint : '/' + endpoint;
            request.setEndpoint(credentials.getHeader() + endpoint);
        }
        else {
            request.setHeader('Authorization', credentials.getHeader());
        }

        return http.send(request);
    }
}