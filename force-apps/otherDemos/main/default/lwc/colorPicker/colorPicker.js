import { api, LightningElement } from "lwc";
import { FlowAttributeChangeEvent } from "lightning/flowSupport";

export default class ColorPicker extends LightningElement {
	_red = 0;
	_green = 0;
	_blue = 0;

	connectedCallback() {
		//eslint-disable-next-line @lwc/lwc/no-async-operation
		setTimeout(() => {
			this.setColor();
			this.updateColor(this.refs.myColor.value);
		}, 0);
	}

	@api label;

	@api
	get red() {
		return this._red;
	}
	set red(value) {
		this._red = Number(value);
		this.setColor();
	}

	@api
	get green() {
		return this._green;
	}
	set green(value) {
		this._green = Number(value);
		this.setColor();
	}

	@api
	get blue() {
		return this._blue;
	}
	set blue(value) {
		this._blue = Number(value);
		this.setColor();
	}

	onColorChange(event) {
		this.updateColor(event.target.value);
	}

	setColor() {
		let colorHex = `#${this.toHex(this._red)}${this.toHex(this._green)}${this.toHex(this._blue)}`;
		this.refs.myColor.value = colorHex;
	}

	updateColor(value) {
		if (value[0] === "#") {
			value = value.substr(1);
		}
		if (value.length === 6) {
			this._red = parseInt(value.substr(0, 2), 16);
			this._green = parseInt(value.substr(2, 2), 16);
			this._blue = parseInt(value.substr(4, 2), 16);

			this.dispatchEvent(new FlowAttributeChangeEvent("red", this._red));
			this.dispatchEvent(new FlowAttributeChangeEvent("green", this._green));
			this.dispatchEvent(new FlowAttributeChangeEvent("blue", this._blue));
		}
	}

	toHex(value) {
		let output = value < 16 ? "0" : "";
		output += Math.round(value).toString(16);
		return output;
	}
}
