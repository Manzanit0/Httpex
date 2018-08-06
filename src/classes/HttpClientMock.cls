@IsTest
public with sharing class HttpClientMock implements HttpCalloutMock {

    public String method { get; set; }

    public HttpClientMock(String method) {
        this.method = method;
    }

    public HttpResponse respond(HttpRequest req) {
        System.assertEquals(method, req.getMethod());
        System.assertEquals(HttpClientTests.ENDPOINT, req.getEndpoint());

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