import { LightningElement, api, wire } from 'lwc';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import { getFieldValue, getRecord, } from 'lightning/uiRecordApi';


export default class WireComp extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: "$recordId", fields: [ACCOUNT_NAME_FIELD] })
    record;

    get name() {
      return getFieldValue(this.record.data, ACCOUNT_NAME_FIELD);
  }

}