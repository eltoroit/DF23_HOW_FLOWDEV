public class EX04_FamilyTypeAuraEnabled {
	@AuraEnabled
	public Family__c record { get; set; }

	@AuraEnabled
	public List<Contact> contacts { get; set; }

	@AuraEnabled
	public Integer contactsCount { get; set; }
}
