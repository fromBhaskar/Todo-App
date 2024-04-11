import { LightningElement, track, wire } from 'lwc';
import getAccount from '@salesforce/apex/debugClass.getAccountRecs';

import LightningAlert from 'lightning/alert';

export default class ButtonDemo extends LightningElement {

    @wire(getAccount)
    accountList

    //  data =[]

    // columns=[{ label: 'Acc Name', fieldName: 'Name' },{ label: 'Phone', fieldName: 'Phone', type: 'phone' }]


    // handleClick(){
    //    getAccount().then((response)=>{
    //     this.data = response
    //    })

    // }
    async handleAlertClick() {
        await LightningAlert.open({
            message: 'this is the alert message',
            theme: 'error', // a red theme intended for error states
            label: 'Error!', // this is the header text
        });
        //Alert has been closed
    }


}