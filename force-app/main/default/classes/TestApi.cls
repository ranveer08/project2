public with sharing class TestApi {
     public static String consumeApi(){
        Http http = new Http();
    	HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.tvmaze.com/search/shows?q=golden%20girls');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode()== 200){
            Object deserializedResponse = JSON.deserializeUntyped(res.getBody());
            //System.debug(deserializedResponse instanceof List<Object>) ;
            //System.debug(res.getBody());
            List<Object> resObjList = (List<Object>) deserializedResponse;
            system.debug(resObjList);
            
            for(Integer i = 0; i < resObjList.size(); i++){
                Map<String, Object> resMap = (Map<String, Object>) resObjList[i];
                Map<String, Object> show = (Map<String,Object>)resMap.get('show');
                Map<String, Object> rating = (Map<String,Object>)show.get('rating');
          
                System.debug(show.get('name'));
                System.debug(show.get('status'));
                System.debug(rating.get('average'));
                System.debug(show.get('summary'));
            }
            //System.debug(resMap.get('domains'));
        }
        
        return null;
    }

    
    

}