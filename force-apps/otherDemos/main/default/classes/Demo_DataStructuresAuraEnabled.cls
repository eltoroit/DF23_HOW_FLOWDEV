public class Demo_DataStructuresAuraEnabled {
	@AuraEnabled
	public Contact prior { get; set; }
	@AuraEnabled
	public Contact current { get; set; }
}
