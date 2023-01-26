import { api, LightningElement, track } from "lwc";

export default class Ex05ApexConfiguration extends LightningElement {
	_inputVariables;
	_builderContext;
	@track errors = {
		hasErrors: false,
		errorMessages: new Set(),
		get messages() {
			return Array.from(this.errorMessages).join(", ");
		}
	};

	@track families = {
		value: null,
		options: []
	};
	@track countFamilies = {
		min: 1,
		max: 200,
		value: 100
	};
	@track countContacts = {
		min: 1,
		max: 20,
		value: 15
	};

	@api
	get inputVariables() {
		return this._inputVariables;
	}
	set inputVariables(value) {
		if (value) {
			this._inputVariables = value;
			console.log(this._inputVariables);
			this.countFamilies.value = this.inputVariables.find(({ name }) => name === "countFamilies")?.value;
			this.countContacts.value = this.inputVariables.find(({ name }) => name === "countContacts")?.value;
			let families = this.inputVariables.find(({ name }) => name === "families")?.value;
			if (families) {
				this.families.value = families;
			} else {
				this.families.value = "";
			}
		}
	}

	@api
	get builderContext() {
		return this._builderContext;
	}
	set builderContext(value) {
		if (value) {
			this._builderContext = value;
			console.log(this._builderContext);
			this.families.options = this._builderContext.recordLookups.map((rl) => ({
				value: rl.name,
				label: rl.label,
				description: rl.description
			}));
			if (this.families.value === null) {
				this.families.value = this.families.options[0].value;
			}
			this.families.options.unshift({ value: "", label: "None", description: "Blank" });
		}
	}

	@api
	validate() {
		let output = [];
		this.errors.hasErrors = true;
		if (!this.families.value) {
			debugger;
			this.errors.hasErrors = true;
			let errorString = "Family is a required field. Select a value";
			output.push({
				key: "families",
				errorString
			});
			this.refs.families.setCustomValidity(errorString);
			this.refs.families.reportValidity();
			this.errors.errorMessages.add(errorString);
		}
		return output;
	}

	onfamiliesChange(event) {
		let newValue = event?.detail?.value;
		this.families.value = newValue;
		this.handleChange(newValue, "families", "reference");
	}

	onCountFamiliesChange(event) {
		let newValue = Number(event?.detail?.value);
		this.countFamilies.value = newValue;
		this.handleChange(newValue, "countFamilies", "Number");
	}

	onCountContactsChange(event) {
		let newValue = Number(event?.detail?.value);
		this.countContacts.value = newValue;
		this.handleChange(newValue, "countContacts", "Number");
	}

	handleChange(newValue, varName, varType) {
		this.dispatchEvent(
			new CustomEvent("configuration_editor_input_value_changed", {
				bubbles: true,
				cancelable: false,
				composed: true,
				detail: {
					name: varName,
					newValue,
					newValueDataType: varType
				}
			})
		);
	}
}
