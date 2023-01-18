public class UI_FamilyTypes {
	@AuraEnabled
	public List<UI_FamilyTypeAE> records { get; set; }

	public UI_FamilyTypes() {
		this.records = new List<UI_FamilyTypeAE>();
	}

	public void add(UI_FamilyTypeAE familyType) {
		this.records.add(familyType);
	}
}
