public class FamilyTypes {
	@AuraEnabled
	public List<FamilyType> records { get; set; }

	public FamilyTypes() {
		this.records = new List<FamilyType>();
	}

    public void add(FamilyType familyType) {
        this.records.add(familyType);
    }
}
