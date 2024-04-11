import { LightningElement,track,api } from 'lwc';
import getAccounts from '@salesforce/apex/debugClass.getAccountRecs';

export default class TestCmp extends LightningElement {
columns = [
    { label: 'Acc Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];
@track data = [];
@api recordId;

connectedCallback() {
    // this.asyncConnectedCallback();
    getAccounts()
    .then((res)=> {this.data = res});
    
}
// async asyncConnectedCallback(){
//     let res = await getAccounts();
//     console.log('res @@ '+JSON.stringify(res));
//     this.data = res;
// }

}