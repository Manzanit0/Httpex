# Httpex

Apex library for HTTP callouts.
## Usage
You can use it with variety of request methods, authentication types or contexts.

### Request methods
Library is able to execute GET, POST, PUT, PATCH, DELET, HEAD.
POST example:
```
Object result = new HttpClientAura(
                new HttpClientProviderAuthProvider('SampleAuthProviderName'))
                .post('https://foo.com'
                        + '/v1/resource/baz/post'
                        , '{"fizz":"buzz"}');
```

### Authentication types
Library supports several authentication schemes - AuthProvider, Named credentials, Cookie based authentication or basic username/password authentication, for example:
```
static Object postQuxByParams(String params){
        return
                new HttpClientAura(
                        new HttpClientProviderBasic('admin', 'hunter2'))
                        .post('https://foo.com'
                        + '/v2/qux/post',
                        params);
    }
```

### Contexts

#### Usage in Lightning server side controllers
Library provides basic catching of errors and reporting them via AuraHandledException that is readable on client side. Example call:
```
@AuraEnabled public static Object getFoo() {
       return
               new HttpClientAura(
                       new HttpClientProviderNamedCredentials('SampleNamedCredential'))
                       .get('https://foo.com'
                       + '/v3/resource/foo/get');
   }
```

#### Usage elsewhere
```
new HttpClient(
        new HttpClientProviderAuthProvider('SampleAuthProviderName'))
        .get('https://foo.com'
        + '/v1/resource/foo/get');
```

#### Calling internal API's
```
final static String endpoint = '/services/data/';
final static String apiVersion = 'v43.0';
final static String query = '/tooling/query?q=';
final static String param = 'SELECT Description, EndpointUrl, FullName, IsActive, ManageableState, NamespacePrefix, ProtocolMismatch, SiteName, Metadata FROM RemoteProxy';
final static String sobjectApi = '/tooling/sobjects/RemoteProxy/';
@AuraEnabled public static Object Query(){
    HttpClientProviderSelf self = new HttpClientProviderSelf();
    return new HttpClientAura(self)
            .get(self.getBaseUrl() + endpoint + apiVersion + query + EncodingUtil.urlEncode(param, 'UTF-8'));
}
```

See more at https://github.com/metacursion/RemoteSitesService


<a href="https://githubsfdeploy.herokuapp.com" target="_blank">
    <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
