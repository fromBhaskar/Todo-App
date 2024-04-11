import { LightningElement, track } from "lwc";

export default class LwcDemo extends LightningElement{

    @track
    greeting = 'Manish';

    handleChange(event) {
        this.greeting = event.target.value;
    }
}

