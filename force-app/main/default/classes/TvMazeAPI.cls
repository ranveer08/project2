public with sharing class TvMazeAPI {
    
    //public static List<String>showNames = new List<String>();
    //public static List<Map<String,String>>showMap = new List<Map<String,String>>();
    public static List<show__c>showMap = new List<show__c>();

    @AuraEnabled
    public static String consumeApi(String showSearch){
        Http http = new Http();
    	HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.tvmaze.com/search/shows?q='+showSearch);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode()== 200){
            Object deserializedResponse = JSON.deserializeUntyped(res.getBody());
            //System.debug(deserializedResponse instanceof List<Object>) ;
            //System.debug(res.getBody());
            List<Object> resObjList = (List<Object>) deserializedResponse;
            //system.debug(resObjList);
            //List<String> rValue;
            for(Integer i = 0; i < resObjList.size(); i++){
                Map<String, Object> resMap = (Map<String, Object>) resObjList[i];
                Map<String, Object> show = (Map<String,Object>)resMap.get('show');
                Map<String, Object> rating = (Map<String,Object>)show.get('rating');
                Map<String, Object> image = (Map<String,Object>)show.get('image');
               
                //String convertRate = (String) rate;
                //List<Object> rate = (List<Object>) rating;
                //Decimal rate = (Decimal)rating.get('average');
                //System.debug(rate);
          		//String ratingToString = String.valueOf(rate.format());
                //System.debug(show.get('name'));
                //System.debug(show.get('status'));
                //System.debug(rating.get('average'));
                //System.debug(show.get('summary'));
                //System.debug(image.get('medium'));
               	//showNames.add((String)show.get('name'));
                //showStatuses.add((String)resMap.get('status'));
               /* showMap.add(new Map<String,String>{'name'=>(String)show.get('name'),
                'status'=>(String)show.get('status'),
                'image'=>(String)image.get('medium'),
                    'summary'=>(String)show.get('summary'),
                    'rating' =>(String)rate[0]
                    });*/
                showMap.add(new show__c(
                    Name=(String)show.get('name'),
                Status__c=(String)show.get('status'),
                image__c=(String)image.get('medium'),
                    Summary__c=(String)show.get('summary')
                ));
                
            }
            
            
        } 
        return null;
    }
    /*@AuraEnabled
    public static List<String>shows(String showName){
        consumeApi(showName);
        return showNames;
    }*/
    @AuraEnabled
    public static List<show__c>showMapHelper(String showStatus){
        consumeApi(showStatus);
        return showMap;
    }
    // saving into database
    @AuraEnabled
    public static String insertShow(show__c shows){
        insert shows;
        return shows.Id;
    }
    
     @AuraEnabled
    public static List<show__c> getShowFromDb(){
        return [SELECT ID, Name, Status__c, Summary__c, image__c FROM show__c];
    }
    
}