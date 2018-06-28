public class NamedCredentialsProvider implements ICredentialsProvider {

    private String namedCredentials { get; set; }

    public NamedCredentialsProvider(String namedCredentialsName) {
        this.namedCredentials = namedCredentialsName;
    }

    public String getHeader() {
        return 'callout:'+namedCredentials;
    }
}