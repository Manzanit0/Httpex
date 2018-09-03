public class HttpClientAura extends HttpClient {
    public HttpClientAura(HttpClientProviderInterface credentials) {
        super.credentials = credentials;
    }
    public override Object get(String endpoint) {
        try {
            return parse((HttpResponse)super.get(endpoint));
        } catch( Exception e ){
            AuraHandledException ex = new AuraHandledException( e.getMessage() );
            ex.setMessage( e.getMessage() );
            throw ex;
        }
    }
    public override Object post(String endpoint, String payload) {
        try {
            return parse((HttpResponse)super.post(endpoint, payload));
        } catch( Exception e ){
            AuraHandledException ex = new AuraHandledException( e.getMessage() );
            ex.setMessage( e.getMessage() );
            throw ex;
        }
    }
    public override Object put(String endpoint, String payload) {
        try {
            return parse((HttpResponse)super.put(endpoint, payload));
        } catch( Exception e ){
            AuraHandledException ex = new AuraHandledException( e.getMessage() );
            ex.setMessage( e.getMessage() );
            throw ex;
        }
    }
    public override Object patch(String endpoint, String payload) {
        try {
            return parse((HttpResponse)super.patch(endpoint, payload));
        } catch( Exception e ){
            AuraHandledException ex = new AuraHandledException( e.getMessage() );
            ex.setMessage( e.getMessage() );
            throw ex;
        }
    }
    public override Object del(String endpoint) {
        try {
            return parse((HttpResponse)super.del(endpoint));
        } catch( Exception e ){
            AuraHandledException ex = new AuraHandledException( e.getMessage() );
            ex.setMessage( e.getMessage() );
            throw ex;
        }
    }
    public override Object head(String endpoint) {
        try {
            return parse((HttpResponse)super.head(endpoint));
        } catch( Exception e ){
            AuraHandledException ex = new AuraHandledException( e.getMessage() );
            ex.setMessage( e.getMessage() );
            throw ex;
        }
    }
    public Object parse(HttpResponse response){
        if ( response.getStatusCode() < 300 ) {
            try {
                return JSON.deserializeUntyped( response.getBody() );
            } catch( Exception e ){
                AuraHandledException ex = new AuraHandledException( e.getMessage() );
                ex.setMessage( e.getMessage() );
                throw ex;
            }
        } else {
            System.debug(LoggingLevel.ERROR, response.getBody());
            String error = response.getStatusCode() + ': ' + response.getStatus();
            AuraHandledException ex = new AuraHandledException(error);
            ex.setMessage( error );
            throw ex;
        }
    }
}