public with sharing class EX03_DataStructures {
	@InvocableMethod(label='Sample' description='...' category='Contact')
	public static List<Results> execute(List<Request> requests) {
		List<Results> responseWrapper = new List<Results>();
		Results response = new Results();
		response.outputContact = new EX03_DataStructuresAuraEnabled();
		response.outputContact.myContact = requests[0].inputContacts[0];
		responseWrapper.add(response);
		return responseWrapper;
	}

	public class Request {
		@InvocableVariable(label='Input Contact' required='true')
		public List<Contact> inputContacts;
	}

	public class Results {
		@InvocableVariable(label='Output Contact')
		public EX03_DataStructuresAuraEnabled outputContact;
	}
}
