import { api, LightningElement, track } from "lwc";

export default class DemoLwcConfiguration extends LightningElement {
	_inputVariables;
	_builderContext;

	@track familyTypes = {
		value: null,
		options: []
	};

	@api
	get inputVariables() {
		return this._inputVariables;
	}
	set inputVariables(value) {
		if (value) {
			this._inputVariables = value;
			console.log(this._inputVariables);
			let familyTypes = this.inputVariables.find(({ name }) => name === "familyTypes")?.value;
			if (familyTypes) {
				this.familyTypes.value = familyTypes;
			} else {
				this.familyTypes.value = "";
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
			this.familyTypes.options = this._builderContext.actionCalls.map((rl) => ({
				value: `${rl.name}.response`,
				label: rl.label,
				description: rl.description
			}));
			this.familyTypes.value = this.familyTypes.options[0].value;
			this.familyTypes.options.unshift({ value: "", label: "None", description: "Blank" });
		}
	}

	onfamilyTypesChange(event) {
		let newValue = event?.detail?.value;
		this.familyTypes.value = newValue;
		this.handleChange(newValue, "familyTypes", "reference");
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
