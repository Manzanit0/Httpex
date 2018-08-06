public with sharing virtual class HttpClient {
    final static Integer CALLOUT_TIMEOUT = 20000;
    public HttpClientProviderInterface credentials { get; set; }

    public HttpClient(){}

    public HttpClient(HttpClientProviderInterface credentials) {
        this.credentials = credentials;
    }

    public virtual Object get(String endpoint) {
        return callout(endpoint, '', 'GET');
    }

    public virtual Object post(String endpoint, String payload) {
        return callout(endpoint, payload, 'POST');
    }

    public virtual Object put(String endpoint, String payload) {
        return callout(endpoint, payload, 'PUT');
    }

    public virtual Object patch(String endpoint, String payload) {
        return callout(endpoint, payload, 'PATCH');
    }

    public virtual Object del(String endpoint) {
        return callout(endpoint, '', 'DELETE');
    }

    public virtual Object head(String endpoint) {
        return callout(endpoint, '', 'HEAD');
    }

    public HttpResponse callout(String endpoint, String payload, String method) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setTimeout(CALLOUT_TIMEOUT);
        request.setEndpoint(endpoint);
        request.setMethod(method);
        if(new String[]{'POST', 'PATCH', 'PUT'}.contains( method )){
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(payload);
        }

        if(credentials != null) {
            if(credentials instanceof HttpClientProviderNamedCredentials) {
                endpoint = endpoint.startsWith('/') ? endpoint : '/' + endpoint;
                request.setEndpoint(credentials.getHeader() + endpoint);
            } else if(credentials instanceof HttpClientProviderCookie) {
                request.setHeader('Cookie', credentials.getHeader());
            } else if(credentials instanceof HttpClientProviderBearer) {
                request.setHeader('Authorization', credentials.getHeader());
            } else {
                request.setHeader('Authorization', credentials.getHeader());
            }
        }

        return http.send(request);
    }
}