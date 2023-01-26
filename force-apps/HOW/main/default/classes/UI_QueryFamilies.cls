public with sharing class UI_QueryFamilies {
	@InvocableMethod(
		label='Get Families'
		description='Demonstrates calling Apex to get data'
		category='Contact'
		configurationEditor='c-ex05-apex-configuration'
	)
	public static List<FamilyResponse> getFamilies(List<FamilyRequest> familyRequests) {
		// Initalize response
		List<FamilyResponse> output = new List<FamilyResponse>();
		FamilyResponse familyResponse = new FamilyResponse();
		UI_FamilyTypesAE response = new UI_FamilyTypesAE();
		familyResponse.response = response;
		output.add(familyResponse);

		// Get data
		System.assertEquals(1, familyRequests.size());
		FamilyRequest familyRequest = familyRequests[0];
		for (Family__c family : [
			SELECT
				Id,
				LastName__c,
				(SELECT Id, FirstName, LastName, FamilyLastName__c FROM Contacts__r ORDER BY FirstName LIMIT :familyRequest.countContacts)
			FROM Family__c
			WHERE Id IN :familyRequest.Families
			ORDER BY LastName__c
			LIMIT :familyRequest.countFamilies
		]) {
			UI_FamilyTypeAE familyType = new UI_FamilyTypeAE();
			familyType.record = family;
			familyType.contacts = family.Contacts__r;
			familyType.contactsCount = family.Contacts__r.size();
			response.add(familyType);
		}

		return output;
	}

	public class FamilyRequest {
		@InvocableVariable(label='Families input' description='Family records without related contacts' required=true)
		public List<Family__c> families;
		@InvocableVariable(label='Count families' description='How many records do you want back?')
		public Integer countFamilies;
		@InvocableVariable(label='Max contacts per family' description='How many contacts maximum do you want per family?')
		public Integer countContacts;
	}

	public class FamilyResponse {
		@InvocableVariable(label='Families output' description='Family records with related contacts')
		public UI_FamilyTypesAE response;
	}
}
