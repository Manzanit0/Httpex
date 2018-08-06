public class HttpClientProviderBearer implements HttpClientProviderInterface {

    private String token { get; set; }

    public HttpClientProviderBearer(String token) {
        this.token = token;
    }

    public String getHeader() {
        return 'Bearer ' + token;
    }
}