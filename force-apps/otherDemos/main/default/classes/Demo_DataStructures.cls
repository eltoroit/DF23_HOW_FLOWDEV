public with sharing class Demo_DataStructures {
	@InvocableMethod(label='Sample' description='...' category='Contact')
	public static List<Result> execute(List<Request> requests) {
		List<Result> responseWrapper = new List<Result>();
		Result response = new Result();
		response.outputData = new Demo_DataStructuresAuraEnabled();
		response.outputData.prior = requests[0].inputContacts[0];
		response.outputData.current = requests[0].inputContacts[1];
		responseWrapper.add(response);
		return responseWrapper;
	}

	public class Request {
		@InvocableVariable(label='Input Contacts' required='true')
		public List<Contact> inputContacts;
		@InvocableVariable(label='The Answer' description='The answer to the ultimate question of life, the universe and everything is...')
		public Integer someVariable;
	}

	public class Result {
		@InvocableVariable(label='Output Data')
		public Demo_DataStructuresAuraEnabled outputData;
	}
}
