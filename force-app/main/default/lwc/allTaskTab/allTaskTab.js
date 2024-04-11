import { LightningElement, api, track, wire } from 'lwc';
import getTaskData from '@salesforce/apex/CreateTask.getTaskRecs';


export default class AllTaskTab extends LightningElement {
    columns = [
        { label: 'Name', fieldName: 'Subject' },
        { label: 'Priority', fieldName: 'Priority' },
        { label: 'Created Date', fieldName: 'CreatedDate' }
    ];
    @track data = [];
    @api recordId;

    @wire(getTaskData)
    taskRecords

    // get tasks(){
    //     return this.taskRecords.data
    // }

    
    connectedCallback() {
        // this.asyncConnectedCallback();
        getTaskData()
        .then((res)=> {this.data = res});
        
    }
    
}