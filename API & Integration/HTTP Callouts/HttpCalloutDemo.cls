public class HttpCalloutDemo {
    // We are invoking a HTTP request and handling the response.
    public static void makeCallout() {
                
        // We instantiate a new Http object.
        Http http = new Http();

        // We instantiate a new HttpRequest
        HttpRequest request = new HttpRequest();
        
        // We define where we are sending it. Note that we must first whitelist any url we wish to make a
        // callout to by adding it in our Remote Site Settings
        request.setEndpoint('https://www.balldontlie.io/api/v1/games/38');
        
        // We define what we are doing with it. In this case GET.
        // GET, requests a designated resource.
        // 		Idempotent
        // 			Idempotency relates to operations that when run multiple times 
        // 			will not change the result. Making multiple identical requests 
        // 			will result in the same effect as if making one request.
        // We could also use:
        // POST, Allows a client to create a new resource or replace an existing one.
        // 		Not Idempotent
        // PUT, Allows a client to create a new resource or replace an existing one.
        // 		Idempotent
        // DELETE, removes the designated resource.
        // 		Idempotent
        // TRACE, echoes back to the client whatever string was sent to the server, 
        // 	used for debugging. However, there are security risks associated with exposing this.
        // 		Idempotent
        // CONNECT, starts two-way communications with the requested resource.
        // 	It can be used to open a tunnel.
        // 		Not Idempotent
        // HEAD, requests the headers that are returned if the specified resource would be 
        // 	requested with an HTTP GET method. Such a request can be done before deciding 
        // 	to download a large resource to save bandwidth, for example.
        // 		Idempotent
        // OPTIONS, used to describe the communication options for the target resource. 
        // 	The client can specify a URL for the OPTIONS method, 
        // 	or an asterisk (*) to refer to the entire server.
        // 		Idempotent
        request.setMethod('GET');
      
        // Now we send the request
        HttpResponse response = http.send(request);
        
        // Here I am doing some code just as an example callback.
        // Here we check the result, and do something as a result.
        // First, we check for the status code.
        // 		Status Codes:
        // 		100, informational
	    //      	100: Continue
		//		200, Success
    	//			200: Ok
    	//			201: Created
    	//			204: No Content
		//		300, Redirect
    	//			300: Multiple Choices
    	//			301: Moved Permanently
    	//			307: Temporary Redirect
		//		400, Client side error
    	//			400: Bad Request
    	//			401: Unauthorized
    	//			403: Forbidden
    	//			404: Page Not Found
		//		500, Server side error.
    	//			500: Internal Server Error
    	//			502: Bad Gateway
        if(response.getStatusCode() == 200) {
            Map<String, Object> respMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }
    }
}