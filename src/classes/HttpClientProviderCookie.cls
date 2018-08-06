/**
 * Created by heyoo on 10/07/18.
 */

public class HttpClientProviderCookie implements HttpClientProviderInterface {

    private Map<String, String> cookies { get; set; }

    public HttpClientProviderCookie(Map<String, String> cookies) {
        this.cookies = cookies;
    }

    public String getHeader() {
        String cookie = '';
        for(String i: this.cookies.keySet()){
            cookie += i+':'+cookies.get(i);
        }
        return 'Cookie: ' + cookie;
    }

}