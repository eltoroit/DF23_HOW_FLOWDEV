public without sharing class RT_LinkFamily {
	@InvocableMethod(label='Link Families' description='Associates a contact with the corresponding family based on the last name' category='Contact')
	public static List<Contact> linkFamily(List<Contact> contacts) {
		Set<String> lastNames = new Set<String>();
		Map<String, Family__c> mapFamiliesByLastName = new Map<String, Family__c>();

		// Find contact's last name
		for (Contact contact : contacts) {
			lastNames.add(contact.LastName);
			mapFamiliesByLastName.put(contact.LastName, null);
		}

		// Find existing families
		for (Family__c family : [SELECT Id, LastName__c FROM Family__c WHERE LastName__c IN :lastNames]) {
			mapFamiliesByLastName.put(family.LastName__c, family);
		}

		// Create missing families (last names without a family record)
		List<family__c> newFamilies = new List<Family__c>();
		for (String lastName : mapFamiliesByLastName.keyset()) {
			if (mapFamiliesByLastName.get(lastName) == null) {
				newFamilies.add(new Family__c(LastName__c = lastName));
			}
		}
		insert newFamilies;

		// Add new families to the map
		for (Family__c family : newFamilies) {
			mapFamiliesByLastName.put(family.LastName__c, family);
		}

		// Update contacts
		for (Contact contact : contacts) {
			contact.Family__c = mapFamiliesByLastName.get(contact.LastName).Id;
		}

		// We could do the DML here, but do it in flow to explain concept
		// update contacts;

		return contacts;
	}
}