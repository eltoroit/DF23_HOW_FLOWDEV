import { api, LightningElement, track } from "lwc";

export default class DemoLwcConfiguration extends LightningElement {
	_inputVariables;
	_builderContext;

	@track familyData = {
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
			let familyData = this.inputVariables.find(({ name }) => name === "familyData")?.value;
			if (familyData) {
				this.familyData.value = familyData;
			} else {
				this.familyData.value = "";
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
			this.familyData.options = this._builderContext.actionCalls.map((rl) => ({
				value: `${rl.name}.response`,
				label: rl.label,
				description: rl.description
			}));
			this.familyData.value = this.familyData.options[0].value;
			this.familyData.options.unshift({ value: "", label: "None", description: "Blank" });
		}
	}

	onFamilyDataChange(event) {
		let newValue = event?.detail?.value;
		this.familyData.value = newValue;
		this.handleChange(newValue, "familyData", "reference");
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
