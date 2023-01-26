@IsTest
public class EX01_LinkFamily_Test {
	@TestSetup
	public static void testSetup() {
		createContacts(new List<String>{ 'LastName01', 'LastName02' }, true, 2);
	}

	@IsTest
	public static void newContacts_WithDifferent_ExistingLastNames() {
		createContacts(new List<String>{ 'LastName01', 'LastName02' }, false, 2);
	}

	@IsTest
	public static void newContacts_WithDuplicate_ExistingLastNames() {
		createContacts(new List<String>{ 'LastName01', 'LastName01' }, false, 2);
	}

	@IsTest
	public static void newContacts_WithDifferent_NewLastNames() {
		createContacts(new List<String>{ 'LastName03', 'LastName04' }, false, 4);
	}

	@IsTest
	public static void newContacts_WithDuplicate_NewLastNames() {
		// createContacts(new List<String>{ 'LastName03', 'LastName03' }, false, 3);
	}

	@IsTest
	public static void updateContacts_ExistingLastName() {
		updateContacts('LastName01', 'LastName02');
	}

	@IsTest
	public static void updateContacts_NewLastName() {
		updateContacts('LastName01', 'LastName03');
	}

	@IsTest
	public static void updateContacts_NoChange() {
		updateContacts('LastName01', 'LastName01');
	}

	private static void createContacts(List<String> lastNames, Boolean isTestSetup, Integer expectedAfter) {
		// Validate the start state
		Integer expectedBefore = isTestSetup ? 0 : 2;
		List<Family__c> families = [SELECT Id FROM Family__c];
		System.assertEquals(expectedBefore, families.size());

		Test.startTest();
		// Create contact records from the lastnames given
		List<Contact> contacts = new List<Contact>();
		for (String lastName : lastNames) {
			contacts.add(new Contact(LastName = lastName));
		}
		insert contacts;
		Test.stopTest();

		// Assert every contact has a family with the same last name
		for (Contact c : [SELECT Id, LastName, Family__r.LastName__c FROM Contact]) {
			System.assertEquals(c.LastName, c.Family__r.LastName__c);
		}

		// Assert the expected number of family records
		families = [SELECT Id FROM Family__c];
		System.assertEquals(expectedAfter, families.size());
	}

	private static void updateContacts(String oldLastName, String newLastName) {
		// Find the family contact with the old last name (assuming one because no duplicate records)
		Contact oldContact = [SELECT Id FROM Contact WHERE LastName = :oldLastName];

		Test.startTest();
		// Update to the new last name
		oldContact.LastName = newLastName;
		update oldContact;
		Test.stopTest();

		// Assert last name was changed and the contact has a family with the same last name
		for (Contact newContact : [SELECT Id, LastName, Family__r.LastName__c FROM Contact WHERE Id = :oldContact.Id]) {
			System.assertEquals(newLastName, newContact.LastName);
			System.assertEquals(newContact.LastName, newContact.Family__r.LastName__c);
		}
	}
}
