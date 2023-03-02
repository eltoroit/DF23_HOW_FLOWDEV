public class EX04_FamilyTypeCollectionAuraEnabled {
	@AuraEnabled
	public List<EX04_FamilyTypeAuraEnabled> records { get; set; }

	public EX04_FamilyTypeCollectionAuraEnabled() {
		this.records = new List<EX04_FamilyTypeAuraEnabled>();
	}

	public void add(EX04_FamilyTypeAuraEnabled familyType) {
		this.records.add(familyType);
	}
}
