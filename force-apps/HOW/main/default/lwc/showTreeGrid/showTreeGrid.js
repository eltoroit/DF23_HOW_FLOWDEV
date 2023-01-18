import { api, LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";

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

export default class ShowTreeGrid extends NavigationMixin(LightningElement) {
	records;
	gridData = [];
	gridColumns = GRID_COLUMNS;

	@api
	get familyTypes() {
		return this.records;
	}
	set familyTypes(value) {
		if (value.records) {
			this.records = value.records;
			this.gridData = [];
			this.records.forEach((familyType) => {
				const family = {
					Id: familyType.record.Id,
					LastName: familyType.record.LastName__c,
					_children: []
				};
				familyType.contacts.forEach((contact) => {
					family._children.push({
						Id: contact.Id,
						FirstName: contact.FirstName,
						LastName: contact.LastName
					});
				});
				this.gridData.push(family);
			});
			debugger;
		}
	}

	onRowAction(event) {
		debugger;
		console.log(event.detail);
		const action = event.detail.action;
		const row = event.detail.row;
		console.log(row);
		switch (action.name) {
			case "navContact": {
				this[NavigationMixin.Navigate]({
					type: "standard__recordPage",
					attributes: {
						recordId: row.Id,
						objectApiName: "Contact", // objectApiName is optional
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
