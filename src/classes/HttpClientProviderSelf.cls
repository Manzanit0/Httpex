public class HttpClientProviderSelf implements HttpClientProviderInterface {
    static String[] ref { get; set; }
    public String getHeader() {
        return 'Bearer ' + ref[0];
    }
    public String getBaseUrl() {
        ref = Page.HttpClientProviderSelf.getContent().toString().split(';');
        return ref[1];
    }
    public String salesforceBaseUrl {
        get {
            return System.Url.getSalesforceBaseUrl().toExternalForm();
        }
    }
}