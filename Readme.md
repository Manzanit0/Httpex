# Httpex

Apex library for HTTP callouts

## Getting started

The library was designed for ease of use. Depending on the authentication scheme used
by the destination endpoint, it's as easy as picking the appropiate provider:

#### BASIC example

```apex
String basicUser = "myuser"
String basicPassword = "12345"
String endpoint = "https://website.com/api/v1/endpoint1"

BasicProvider provider = new BasicProvider(basicUser, basicPassword)
HttpClient client = new HttpClient(provider);
HttpResponse res = client.post(endpoint, "{\"data\": \"something\"}")
```

#### OAuth2 example

```apex
String authEndpoint = "https://website.com/api/v1/auth"
String endpoint = "https://website.com/api/v1/endpoint2"
Map<String, String> authParameters = new Map<String, String>{
    'clientId' => 'clientId_value',
    'clientSecret' => 'clientSecret_value'
};

OAuthProvider provider = new OAuthProvider(authUrl, authParameters);
HttpClient client = new HttpClient(provider);
HttpResponse res = client.get(endpoint);
```

## Deployment

<a href="https://githubsfdeploy.herokuapp.com" target="_blank">
    <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>