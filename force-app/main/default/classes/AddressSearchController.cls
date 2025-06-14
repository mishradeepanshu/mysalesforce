public class AddressSearchController {
    
    @AuraEnabled
    public static AddressDetails__c getAddressDetailsbyId(String id) {
        return [SELECT Id, City__c, State__c, Country__c, PostalCode__c, Street__c 
                FROM AddressDetails__c 
                WHERE Id = :id];
    }
    
    @AuraEnabled
    public static String saveAddressDetailsbyId(String id, AddressDetails__c addDetails) {
        try {
            AddressDetails__c obj = [SELECT Id FROM AddressDetails__c WHERE Id = :id];
            obj.City__c = addDetails.City__c;
            obj.State__c = addDetails.State__c;
            obj.Country__c = addDetails.Country__c;
            obj.PostalCode__c = addDetails.PostalCode__c;
            obj.Street__c = addDetails.Street__c;
            update obj;
            return 'Success';
        } catch (Exception e) {
            system.debug('Error while saving address details: ' + e.getMessage());
            return 'Error: ' + e.getMessage();
        }
    }
    
    @AuraEnabled
    public static String getAddressSet(String SearchText) {
        String APIKey = 'AIzaSyAqxVnFjoyaNm1ZBkLpJavM6QgwUhe_4v8';
        String result = null;
        
        try {
            if (SearchText != null) {
                String APIUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + 
                                SearchText.replace(' ', '%20') + '&key=' + APIKey; 
                system.debug('APIUrl is ' + APIUrl);
                
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(APIUrl);
                
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                if (res.getStatusCode() == 200) {
                    system.debug('API invoked successfully');
                    result = res.getBody();
                } else {
                    system.debug('Failed to fetch address set, status code: ' + res.getStatusCode());
                }
            }
        } catch (Exception e) {
            system.debug('Error while fetching address set: ' + e.getMessage());
        }
        
        return result;
    }
    
    @AuraEnabled
    public static String getAddressDetailsByPlaceId(String PlaceID) {
        String APIKey = 'AIzaSyAqxVnFjoyaNm1ZBkLpJavM6QgwUhe_4v8'; 
        String result = null;
        
        try {
            if (PlaceID != null) {
                String APIUrl = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=' + 
                                PlaceID + '&key=' + APIKey;
                system.debug('APIUrl is ' + APIUrl);
                
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(APIUrl);
                
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                if (res.getStatusCode() == 200) {
                    system.debug('API invoked successfully');
                    result = res.getBody();
                } else {
                    system.debug('Failed to fetch address details, status code: ' + res.getStatusCode());
                }
            }
        } catch (Exception e) {
            system.debug('Error while fetching address details: ' + e.getMessage());
        }
        
        return result;
    }
}
