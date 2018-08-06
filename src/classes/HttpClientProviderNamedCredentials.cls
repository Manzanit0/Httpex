public class HttpClientProviderNamedCredentials implements HttpClientProviderInterface {

    private String namedCredentials { get; set; }

    public HttpClientProviderNamedCredentials(String namedCredentialsName) {
        this.namedCredentials = namedCredentialsName;
    }

    public String getHeader() {
        return 'callout:'+namedCredentials;
    }
}