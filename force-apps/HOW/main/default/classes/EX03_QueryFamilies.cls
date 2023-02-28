public with sharing class EX03_QueryFamilies {
	@InvocableMethod(label='Get Families' description='Demonstrates calling Apex to get data' category='Contact')
	public static List<FamilyResponse> getFamilies(List<FamilyRequest> familyRequests) {
		// Initalize response
		List<FamilyResponse> output = new List<FamilyResponse>();
		EX03AE_Response aeResponse = new EX03AE_Response();
		FamilyResponse familyResponse = new FamilyResponse();
		familyResponse.response = aeResponse;
		output.add(familyResponse);

		System.assertEquals(1, familyRequests.size());
		FamilyRequest familyRequest = familyRequests[0];
		for (Family__c family : [
			SELECT Id, LastName__c, (SELECT Id, FirstName, LastName, FamilyLastName__c FROM Contacts__r ORDER BY FirstName)
			FROM Family__c
			WHERE Id IN :familyRequest.Families
			ORDER BY LastName__c
			LIMIT :familyRequest.maxFamilies
		]) {
			aeResponse.add(family);
		}

		return output;
	}

	public class FamilyRequest {
		@InvocableVariable(label='Families input' description='Family records without related contacts' required=true)
		public List<Family__c> families;
		@InvocableVariable(label='Max families' description='How many family records do you want back?')
		public Integer maxFamilies;
	}

	public class FamilyResponse {
		@InvocableVariable(label='Families output' description='Family records with related contacts')
		public EX03AE_Response response;
	}
}
