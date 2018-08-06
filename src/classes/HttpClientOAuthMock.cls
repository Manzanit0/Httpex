@IsTest
public with sharing class HttpClientOAuthMock implements HttpCalloutMock {

    public String method { get; set; }

    public HttpClientOAuthMock(String method) {
        this.method = method;
    }

    public HttpResponse respond(HttpRequest req) {

        if(req.getEndpoint() == HttpClientTests.AUTH_OAUTH_ENDPOINT) {
            System.assertEquals('POST', req.getMethod());
            System.assertEquals(HttpClientTests.AUTH_OAUTH_PAYLOAD_REQUEST, req.getBody());

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(HttpClientTests.AUTH_OAUTH_PAYLOAD_RESPONSE);
            res.setStatusCode(200);
            return res;
        }
        else {
            System.assertEquals(method, req.getMethod());

            if(method != 'GET' && method != 'HEAD' && method != 'DELETE') {
                System.assertEquals(HttpClientTests.PAYLOAD_REQUEST, req.getBody());
            }

            // Verify the callout is correctly authenticated.
            System.assertEquals('Bearer ' + HttpClientTests.AUTH_OAUTH_ACCESS_TOKEN, req.getHeader('Authorization'));

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(HttpClientTests.PAYLOAD_RESPONSE);
            res.setStatusCode(200);
            return res;
        }
    }
}