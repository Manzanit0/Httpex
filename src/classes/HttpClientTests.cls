@IsTest
public class HttpClientTests {

    public static final String PAYLOAD_REQUEST = '{"payload": true}';
    public static final String PAYLOAD_RESPONSE = '{"payload": false}';
    public static final String ENDPOINT = 'http://api.endpoint.dev/doSomething';

    public static final String AUTH_BASIC_USERNAME = 'javier@garcia.es';
    public static final String AUTH_BASIC_PASSWORD = '#g4rc14';

    public static final String AUTH_OAUTH_ENDPOINT = 'https://auth.api.com/requestToken';
    public static final String AUTH_OAUTH_PAYLOAD_REQUEST = '{"clientSecret":"clientSecret_value","clientId":"clientId_value"}';
    public static final String AUTH_OAUTH_ACCESS_TOKEN = '132456789qwerty';
    public static final String AUTH_OAUTH_PAYLOAD_RESPONSE = '{"access_token":"' + AUTH_OAUTH_ACCESS_TOKEN +'"}';

    public static final String AUTH_NAMEDCREDENTIALS_NAME = 'NamedCreds';

    @IsTest
    static void testPostMethod_NoAuth() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientMock('POST'));
        HttpClient client = new HttpClient();

        // Act
        HttpResponse res = (HttpResponse) client.post(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assertEquals(null, client.credentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPostMethod_BasicAuth() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientBasicMock('POST'));

        HttpClient client = new HttpClient(new HttpClientProviderBasic(AUTH_BASIC_USERNAME, AUTH_BASIC_PASSWORD));

        // Act
        HttpResponse res = (HttpResponse) client.post(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderBasic);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPostMethod_OAuth2() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientOAuthMock('POST'));

        HttpClient client = new HttpClient(
                new HttpClientProviderOAuth(AUTH_OAUTH_ENDPOINT, new Map<String, String>{
                        'clientId' => 'clientId_value',
                        'clientSecret' => 'clientSecret_value'
        }));

        // Act
        HttpResponse res =(HttpResponse)  client.post(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderOAuth);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(2, Limits.getCallouts());
    }

    @IsTest
    static void testPostMethod_NamedCredentials() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientNamedCredentialsMock('POST'));

        HttpClient client = new HttpClient(new HttpClientProviderNamedCredentials(AUTH_NAMEDCREDENTIALS_NAME));

        // Act
        HttpResponse res = (HttpResponse) client.post(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderNamedCredentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPutMethod_NoAuth() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientMock('PUT'));
        HttpClient client = new HttpClient();

        // Act
        HttpResponse res = (HttpResponse) client.put(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assertEquals(null, client.credentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPutMethod_BasicAuth() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientBasicMock('PUT'));

        HttpClient client = new HttpClient(new HttpClientProviderBasic(AUTH_BASIC_USERNAME, AUTH_BASIC_PASSWORD));

        // Act
        HttpResponse res = (HttpResponse) client.put(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderBasic);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPutMethod_OAuth2() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientOAuthMock('PUT'));

        HttpClient client = new HttpClient(
                new HttpClientProviderOAuth(AUTH_OAUTH_ENDPOINT, new Map<String, String>{
                        'clientId' => 'clientId_value',
                        'clientSecret' => 'clientSecret_value'
                }));

        // Act
        HttpResponse res = (HttpResponse) client.put(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderOAuth);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(2, Limits.getCallouts());
    }

    @IsTest
    static void testPutMethod_NamedCredentials() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientNamedCredentialsMock('PUT'));

        HttpClient client = new HttpClient(new HttpClientProviderNamedCredentials(AUTH_NAMEDCREDENTIALS_NAME));

        // Act
        HttpResponse res = (HttpResponse) client.put(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderNamedCredentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPatchMethod_NoAuth() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientMock('PATCH'));
        HttpClient client = new HttpClient();

        // Act
        HttpResponse res =(HttpResponse)  client.patch(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assertEquals(null, client.credentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPatchMethod_BasicAuth() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientBasicMock('PATCH'));

        HttpClient client = new HttpClient(new HttpClientProviderBasic(AUTH_BASIC_USERNAME, AUTH_BASIC_PASSWORD));

        // Act
        HttpResponse res = (HttpResponse) client.patch(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderBasic);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testPatchMethod_OAuth2() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientOAuthMock('PATCH'));

        HttpClient client = new HttpClient(
                new HttpClientProviderOAuth(AUTH_OAUTH_ENDPOINT, new Map<String, String>{
                        'clientId' => 'clientId_value',
                        'clientSecret' => 'clientSecret_value'
                }));

        // Act
        HttpResponse res = (HttpResponse) client.patch(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderOAuth);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(2, Limits.getCallouts());
    }

    @IsTest
    static void testPatchMethod_NamedCredentials() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientNamedCredentialsMock('PATCH'));

        HttpClient client = new HttpClient(new HttpClientProviderNamedCredentials(AUTH_NAMEDCREDENTIALS_NAME));

        // Act
        HttpResponse res = (HttpResponse) client.patch(ENDPOINT, PAYLOAD_REQUEST);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderNamedCredentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testGetMethod_NoAuth() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientMock('GET'));
        HttpClient client = new HttpClient();

        // Act
        HttpResponse res = (HttpResponse) client.get(ENDPOINT);

        // Assert
        System.assertEquals(null, client.credentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testGetMethod_BasicAuth() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientBasicMock('GET'));

        HttpClient client = new HttpClient(new HttpClientProviderBasic(AUTH_BASIC_USERNAME, AUTH_BASIC_PASSWORD));

        // Act
        HttpResponse res = (HttpResponse) client.get(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderBasic);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testGetMethod_OAuth2() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientOAuthMock('GET'));

        HttpClient client = new HttpClient(
                new HttpClientProviderOAuth(AUTH_OAUTH_ENDPOINT, new Map<String, String>{
                        'clientId' => 'clientId_value',
                        'clientSecret' => 'clientSecret_value'
                }));

        // Act
        HttpResponse res = (HttpResponse) client.get(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderOAuth);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(2, Limits.getCallouts());
    }

    @IsTest
    static void testGetMethod_NamedCredentials() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientNamedCredentialsMock('GET'));

        HttpClient client = new HttpClient(new HttpClientProviderNamedCredentials(AUTH_NAMEDCREDENTIALS_NAME));

        // Act
        HttpResponse res = (HttpResponse) client.get(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderNamedCredentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testDeleteMethod_NoAuth() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientMock('DELETE'));
        HttpClient client = new HttpClient();

        // Act
        HttpResponse res = (HttpResponse) client.del(ENDPOINT);

        // Assert
        System.assertEquals(null, client.credentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testDeleteMethod_BasicAuth() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientBasicMock('DELETE'));

        HttpClient client = new HttpClient(new HttpClientProviderBasic(AUTH_BASIC_USERNAME, AUTH_BASIC_PASSWORD));

        // Act
        HttpResponse res = (HttpResponse) client.del(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderBasic);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testDeleteMethod_OAuth2() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientOAuthMock('DELETE'));

        HttpClient client = new HttpClient(
                new HttpClientProviderOAuth(AUTH_OAUTH_ENDPOINT, new Map<String, String>{
                        'clientId' => 'clientId_value',
                        'clientSecret' => 'clientSecret_value'
                }));

        // Act
        HttpResponse res =(HttpResponse)  client.del(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderOAuth);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(2, Limits.getCallouts());
    }

    @IsTest
    static void testDeleteMethod_NamedCredentials() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientNamedCredentialsMock('DELETE'));

        HttpClient client = new HttpClient(new HttpClientProviderNamedCredentials(AUTH_NAMEDCREDENTIALS_NAME));

        // Act
        HttpResponse res = (HttpResponse) client.del(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderNamedCredentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testHeadMethod_NoAuth() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientMock('HEAD'));
        HttpClient client = new HttpClient();

        // Act
        HttpResponse res = (HttpResponse) client.head(ENDPOINT);

        // Assert
        System.assertEquals(null, client.credentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testHeadMethod_BasicAuth() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientBasicMock('HEAD'));

        HttpClient client = new HttpClient(new HttpClientProviderBasic(AUTH_BASIC_USERNAME, AUTH_BASIC_PASSWORD));

        // Act
        HttpResponse res = (HttpResponse) client.head(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderBasic);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }

    @IsTest
    static void testHeadMethod_OAuth2() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new HttpClientOAuthMock('HEAD'));

        HttpClient client = new HttpClient(
                new HttpClientProviderOAuth(AUTH_OAUTH_ENDPOINT, new Map<String, String>{
                        'clientId' => 'clientId_value',
                        'clientSecret' => 'clientSecret_value'
                }));

        // Act
        HttpResponse res = (HttpResponse) client.head(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderOAuth);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(2, Limits.getCallouts());
    }

    @IsTest
    static void testHeadMethod_NamedCredentials() {
        // Arange
        Test.setMock(HttpCalloutMock.class, new HttpClientNamedCredentialsMock('HEAD'));

        HttpClient client = new HttpClient(new HttpClientProviderNamedCredentials(AUTH_NAMEDCREDENTIALS_NAME));

        // Act
        HttpResponse res = (HttpResponse) client.head(ENDPOINT);

        // Assert
        System.assert(client.credentials instanceof HttpClientProviderNamedCredentials);
        System.assertEquals(PAYLOAD_RESPONSE, res.getBody());
        System.assertEquals(200, res.getStatusCode());
    }
}