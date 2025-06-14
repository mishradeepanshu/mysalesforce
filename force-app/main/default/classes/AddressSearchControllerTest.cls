@isTest
private class AddressSearchControllerTest {
    @TestSetup
    static void makeData(){
        // Create test data
        AddressDetails__c testAddress = new AddressDetails__c(
            City__c = 'Test City',
            State__c = 'Test State',
            Country__c = 'Test Country',
            PostalCode__c = '12345',
            Street__c = 'Test Street'
        );
        insert testAddress;
    }
    
    @isTest
    static void testGetAddressDetailsbyId() {
        // Get the test address
        AddressDetails__c testAddress = [SELECT Id FROM AddressDetails__c LIMIT 1];
        
        Test.startTest();
        AddressDetails__c result = AddressSearchController.getAddressDetailsbyId(testAddress.Id);
        Test.stopTest();
        
        // Verify results
        System.assertEquals('Test City', result.City__c, 'City should match');
        System.assertEquals('Test State', result.State__c, 'State should match');
        System.assertEquals('Test Country', result.Country__c, 'Country should match');
        System.assertEquals('12345', result.PostalCode__c, 'Postal code should match');
        System.assertEquals('Test Street', result.Street__c, 'Street should match');
    }
    
    @isTest
    static void testSaveAddressDetailsbyId() {
        // Get the test address
        AddressDetails__c testAddress = [SELECT Id FROM AddressDetails__c LIMIT 1];
        
        // Create updated address details
        AddressDetails__c updatedAddress = new AddressDetails__c(
            City__c = 'Updated City',
            State__c = 'Updated State',
            Country__c = 'Updated Country',
            PostalCode__c = '54321',
            Street__c = 'Updated Street'
        );
        
        Test.startTest();
        String result = AddressSearchController.saveAddressDetailsbyId(testAddress.Id, updatedAddress);
        Test.stopTest();
        
        // Verify results
        System.assertEquals('Success', result, 'Save should be successful');
        
        // Verify the update
        AddressDetails__c savedAddress = [SELECT City__c, State__c, Country__c, PostalCode__c, Street__c 
                                        FROM AddressDetails__c 
                                        WHERE Id = :testAddress.Id];
        System.assertEquals('Updated City', savedAddress.City__c, 'City should be updated');
        System.assertEquals('Updated State', savedAddress.State__c, 'State should be updated');
        System.assertEquals('Updated Country', savedAddress.Country__c, 'Country should be updated');
        System.assertEquals('54321', savedAddress.PostalCode__c, 'Postal code should be updated');
        System.assertEquals('Updated Street', savedAddress.Street__c, 'Street should be updated');
    }
    
    @isTest
    static void testGetAddressSet() {
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        String result = AddressSearchController.getAddressSet('Test Address');
        Test.stopTest();
        
        // Verify results
        System.assertNotEquals(null, result, 'Result should not be null');
    }
    
    @isTest
    static void testGetAddressDetailsByPlaceId() {
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        String result = AddressSearchController.getAddressDetailsByPlaceId('test_place_id');
        Test.stopTest();
        
        // Verify results
        System.assertNotEquals(null, result, 'Result should not be null');
    }
    
    // Mock HTTP Response Generator
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"OK","predictions":[{"description":"Test Address"}]}');
            res.setStatusCode(200);
            return res;
        }
    }
} 