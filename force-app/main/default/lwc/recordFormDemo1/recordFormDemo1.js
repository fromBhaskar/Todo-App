import { LightningElement, api } from 'lwc';

export default class RecordFormDemo1 extends LightningElement {

    @api
    recordId

    @api
    objectApiName

    fields = ["Name"]
}