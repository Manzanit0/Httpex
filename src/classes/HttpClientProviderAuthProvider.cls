public class HttpClientProviderAuthProvider implements HttpClientProviderInterface {
    private String authProviderId { get; set; }
    private String authProviderType { get; set; }

    public HttpClientProviderAuthProvider(String authProviderName) {
        AuthProvider[] providers = [
                SELECT
                        Id,
                        ProviderType
                FROM AuthProvider
                WHERE FriendlyName =: authProviderName];
        if( providers.isEmpty() ){
            throw new QueryException('No such Auth Provider '+ authProviderName + ' has been found.');
        } else {
            this.authProviderId = providers[0].Id;
            if(providers[0].ProviderType == 'OpenIdConnect'){
                this.authProviderType = 'Open Id Connect';
            } else {
                this.authProviderType = providers[0].ProviderType;
            }
        }

    }
    public String getHeader() {
        return 'Bearer ' + Auth.AuthToken.getAccessToken(authProviderId, authProviderType);
    }
}