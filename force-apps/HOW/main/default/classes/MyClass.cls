public with sharing class MyClass {
	@InvocableMethod(label='Sample' description='...' category='Contact')
	public static List<Results> execute(List<Request> requests) {
		List<Results> responseWrapper = new List<Results>();
		for (Request request : requests) {
			Results response = new Results();
			response.outputContact = new MyClassAE();
			response.outputContact.myContact = request.inputContacts[0];
			responseWrapper.add(response);
		}
		return responseWrapper;
	}

	public class Request {
		@InvocableVariable(label='Input Contact' required='true')
		public List<Contact> inputContacts;
	}

	public class Results {
		@InvocableVariable(label='Output Contact')
		public MyClassAE outputContact;
	}
}
