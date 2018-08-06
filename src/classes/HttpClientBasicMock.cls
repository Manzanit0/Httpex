@IsTest
public with sharing class HttpClientBasicMock implements HttpCalloutMock {

    public String method { get; set; }

    public HttpClientBasicMock(String method) {
        this.method = method;
    }

    public HttpResponse respond(HttpRequest req) {
        System.assertEquals(method, req.getMethod());
        System.assertEquals(HttpClientTests.ENDPOINT, req.getEndpoint());

        if(method != 'GET' && method != 'HEAD' && method != 'DELETE') {
            System.assertEquals(HttpClientTests.PAYLOAD_REQUEST, req.getBody());
        }

        // Verify the callout is correctly authenticated.
        String headerValue = 'BASIC ' + EncodingUtil.base64Encode(Blob.valueOf(HttpClientTests.AUTH_BASIC_USERNAME + ':' + HttpClientTests.AUTH_BASIC_PASSWORD));
        System.assertEquals(headerValue, req.getHeader('Authorization'));

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(HttpClientTests.PAYLOAD_RESPONSE);
        res.setStatusCode(200);
        return res;
    }
}