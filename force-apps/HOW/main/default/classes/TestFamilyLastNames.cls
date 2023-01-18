@IsTest
public class TestFamilyLastNames {
	@TestSetup
	public static void testSetup() {
		createContacts(new List<String>{ 'LN1', 'LN2' }, 0, 2);
	}

	@IsTest
	public static void newContacts_WithDifferent_ExistingLastNames() {
		createContacts(new List<String>{ 'LN1', 'LN2' }, 2, 2);
	}

	@IsTest
	public static void newContacts_WithDuplicate_ExistingLastNames() {
		createContacts(new List<String>{ 'LN1', 'LN1' }, 2, 2);
	}

	@IsTest
	public static void newContacts_WithDifferent_NewLastNames() {
		createContacts(new List<String>{ 'LN3', 'LN4' }, 2, 4);
	}

	@IsTest
	public static void newContacts_WithDuplicate_NewLastNames() {
		createContacts(new List<String>{ 'LN3', 'LN3' }, 2, 3);
	}

	@IsTest
	public static void updateContacts_ExistingLastName() {
		updateContacts('LN1', 'LN2');
	}

	@IsTest
	public static void updateContacts_NewLastName() {
		updateContacts('LN1', 'LN3');
	}

	@IsTest
	public static void updateContacts_NoChange() {
		updateContacts('LN1', 'LN1');
	}


	private static void createContacts(List<String> lastNames, Integer expectedBefore, Integer expectedAfter) {
		Id recTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Family').getRecordTypeId();
		List<Family__c> families = [SELECT Id FROM Family__c];
		System.assertEquals(expectedBefore, families.size());
		List<Contact> contacts = new List<Contact>();
		for (String lastName : lastNames) {
			contacts.add(new Contact(LastName = lastName, RecordTypeId = recTypeId));
		}
		insert contacts;
		for (Contact c : [SELECT Id, LastName, Family__r.LastName__c FROM Contact]) {
			System.assertEquals(c.LastName, c.Family__r.LastName__c);
		}
		families = [SELECT Id FROM Family__c];
		System.assertEquals(expectedAfter, families.size());
	}

	private static void updateContacts(String oldLastName, String newLastName) {
		Contact oldContact = [SELECT Id FROM Contact WHERE LastName = :oldLastName];
		oldContact.LastName = newLastName;
		update oldContact;
		for (Contact newContact : [SELECT Id, LastName, Family__r.LastName__c FROM Contact WHERE Id = :oldContact.Id]) {
			System.assertEquals(newLastName, newContact.LastName);
			System.assertEquals(newContact.LastName, newContact.Family__r.LastName__c);
		}
	}
}
