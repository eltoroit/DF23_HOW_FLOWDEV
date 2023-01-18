public class UI_FamilyTypeAE {
	@AuraEnabled
	public Family__c record { get; set; }

	@AuraEnabled
	public List<Contact> contacts { get; set; }

	@AuraEnabled
	public Integer contactsCount { get; set; }
}
