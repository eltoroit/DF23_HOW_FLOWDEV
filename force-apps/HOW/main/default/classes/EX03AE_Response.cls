public class EX03AE_Response {
	@AuraEnabled
	public List<EX03AE_FamilyWithContacts> familiesWithContacts { get; set; }
	@AuraEnabled
	public integer theAnswer {
		get {
			return 42;
		}
		private set;
	}

	public EX03AE_Response() {
		this.familiesWithContacts = new List<EX03AE_FamilyWithContacts>();
	}

	public void add(Family__c family) {
		EX03AE_FamilyWithContacts familyWithContacts = new EX03AE_FamilyWithContacts();
		familyWithContacts.family = family;
		familyWithContacts.contacts = family.Contacts__r;
		familyWithContacts.contactsCount = family.Contacts__r.size();
		this.familiesWithContacts.add(familyWithContacts);
	}
}
