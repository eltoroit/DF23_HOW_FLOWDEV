public class EX03AE_FamilyWithContacts {
	@AuraEnabled
	public Family__c family { get; set; }

	@AuraEnabled
	public List<Contact> contacts { get; set; }

	@AuraEnabled
	public Integer contactsCount { get; set; }
}
