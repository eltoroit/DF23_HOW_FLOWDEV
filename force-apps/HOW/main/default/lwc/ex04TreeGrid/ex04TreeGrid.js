import { api, LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

const GRID_COLUMNS = [
	{
		type: "string",
		fieldName: "LastName",
		label: "Last Name"
	},
	{
		type: "button",
		fieldName: "FirstName",
		label: "First Name",
		typeAttributes: {
			label: { fieldName: "FirstName" },
			name: "navContact",
			variant: "base"
		}
	}
];

export default class Ex04TreeGrid extends NavigationMixin(LightningElement) {
	records;
	gridData = [];
	@api familyTypes;
	gridColumns = GRID_COLUMNS;

	@api
	get familyData() {
		return this.records;
	}
	set familyData(value) {
		if (value.familiesWithContacts) {
			this.records = value.familiesWithContacts;
			this.gridData = this.records.map((familyWithContacts) => {
				const family = {
					Id: familyWithContacts.family.Id,
					LastName: `${familyWithContacts.family.LastName__c} (${familyWithContacts.contactsCount} members)`,
					_children: []
				};
				familyWithContacts.contacts.forEach((contact) => {
					family._children.push({
						Id: contact.Id,
						FirstName: contact.FirstName,
						LastName: contact.LastName
					});
				});
				return family;
			});
		}
	}

	@api
	validate() {
		// let output = { isValid: true };
		let output = {
			isValid: false,
			errorMessage: "You can't go past this screen!"
		};
		this.dispatchEvent(
			new ShowToastEvent({
				title: output.errorMessage,
				message: "",
				variant: "error",
				mode: "sticky"
			})
		);
		return output;
	}

	onRowAction(event) {
		const row = event.detail.row;
		const action = event.detail.action;
		switch (action.name) {
			case "navContact": {
				this[NavigationMixin.Navigate]({
					type: "standard__recordPage",
					attributes: {
						recordId: row.Id,
						actionName: "view"
					}
				});
				break;
			}
			default: {
				break;
			}
		}
	}
}
