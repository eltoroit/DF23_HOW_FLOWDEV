public with sharing class EX03_DataStructures {
	@InvocableMethod(label='Sample' description='...' category='Contact')
	public static List<Results> execute(List<Request> requests) {
		List<Results> responseWrapper = new List<Results>();
		Results response = new Results();
		response.outputData = new EX03_DataStructuresAuraEnabled();
		response.outputData.prior = requests[0].inputContacts[0];
		response.outputData.current = requests[0].inputContacts[1];
		responseWrapper.add(response);
		return responseWrapper;
	}

	public class Request {
		@InvocableVariable(label='Input Contacts' required='true')
		public List<Contact> inputContacts;
		@InvocableVariable(label='The answer to the ultimate question of life, the universe and everything is...')
		public Integer someVariable;
	}

	public class Results {
		@InvocableVariable(label='Output Data')
		public EX03_DataStructuresAuraEnabled outputData;
	}
}
