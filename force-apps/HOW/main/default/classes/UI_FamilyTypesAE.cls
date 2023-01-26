public class UI_FamilyTypesAE {
	@AuraEnabled
	public List<UI_FamilyTypeAE> records { get; set; }

	public UI_FamilyTypesAE() {
		this.records = new List<UI_FamilyTypeAE>();
	}

	public void add(UI_FamilyTypeAE familyType) {
		this.records.add(familyType);
	}
}
