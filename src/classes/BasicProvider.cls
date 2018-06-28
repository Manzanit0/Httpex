public class BasicProvider implements ICredentialsProvider {

    private String username { get; set; }
    private String password { get; set; }

    public BasicProvider(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getHeader() {
        Blob headerValue = Blob.valueOf(username + ':' + password);
        return 'BASIC ' + EncodingUtil.base64Encode(headerValue);
    }
}