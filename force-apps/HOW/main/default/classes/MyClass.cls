public with sharing class MyClass {
	@InvocableMethod(label='Sample' description='...' category='Contact')
	public static List<Results> execute(List<contact> contacts) {
		List<Results> responseWrapper = new List<Results>();
        for (Contact contact : contacts) {
            Results response = new Results();
            response.outputContact = new MyClassAE();
            response.outputContact.contact = contact;
            responseWrapper.add(response);
        }
		return responseWrapper;
	}

	public class Results {
		@InvocableVariable(label='Output Contact')
		public MyClassAE outputContact;
	}
}
