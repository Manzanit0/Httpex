public class HttpClientProviderBasic implements HttpClientProviderInterface {

    private String username { get; set; }
    private String password { get; set; }

    public HttpClientProviderBasic(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getHeader() {
        Blob headerValue = Blob.valueOf(username + ':' + password);
        return 'BASIC ' + EncodingUtil.base64Encode(headerValue);
    }
}