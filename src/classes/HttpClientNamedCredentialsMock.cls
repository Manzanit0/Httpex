@IsTest
public with sharing class HttpClientNamedCredentialsMock implements HttpCalloutMock {

    public String method { get; set; }

    public HttpClientNamedCredentialsMock(String method) {
        this.method = method;
    }

    public HttpResponse respond(HttpRequest req) {
        System.assertEquals(method, req.getMethod());
        System.assertEquals('callout:' + HttpClientTests.AUTH_NAMEDCREDENTIALS_NAME + '/' + HttpClientTests.ENDPOINT, req.getEndpoint());

        if(method != 'GET' && method != 'HEAD' && method != 'DELETE') {
            System.assertEquals(HttpClientTests.PAYLOAD_REQUEST, req.getBody());
        }

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(HttpClientTests.PAYLOAD_RESPONSE);
        res.setStatusCode(200);
        return res;
    }
}