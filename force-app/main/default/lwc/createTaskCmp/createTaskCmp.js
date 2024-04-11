import { LightningElement } from 'lwc';
import createTask from '@salesforce/apex/CreateTask.createTask';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class CreateTaskCmp extends LightningElement {
   

    priorityList = ["High","Medium","Low"]
    taskStatusList =['Not Started', 'In Progress', 'Completed','Waiting on someone else','Deferred']
    statusValue = '';
    titleValue = '';
    contactValue = '';
    accountValue = '';
    taskPriority ='';
    allData =''


    handleTaskCreated(){
        console.log("Task created");
    }

    

    get options() {

        return this.taskStatusList.map(task=>{
            return  ({ label: task, value: task })
        })
        
    }

    get priorityOptions() {

        return this.priorityList.map(task=>{
            return  ({ label: task, value: task })
        })
        
    }

    handleChange(event){

        this.statusValue = event.target.value

    }

    onChangeTitle(event){
        this.titleValue = event.target.value
    }
    onChangeContact(event){
        this.contactValue = event.target.value
    }

    onPriorityChange(event){
        this.taskPriority = event.target.value
    }

    onChangeAccount(event){
        this.accountValue = event.target.value
    }


    onSaveTaskBtn(){

        if(this.statusValue&& this.titleValue&&this.taskPriority ){

         createTask({
            objId : this.accountValue ? this.accountValue : null,
            subject :this.titleValue ,
            status : this.statusValue,
            taskPriority : this.taskPriority,
            conId : this.contactValue ? this.contactValue : null
        }).then(res =>{

            this.allData = "Task Created Sucessfully! "
            this.showToast("Success!", "A new Task has been Created Sucessfully! ","success")
            console.log("Task Created" + res);
            this.resetTaskScreen()
            
        }).catch(rej=>{
            console.log("Task Falied to create" + rej);
        })
    }else{
        this.showToast('Please check and try again', "Please fill the required Fields to create a Task","error")
    }
    }

    

    resetTaskScreen(){
        this.titleValue = ''
        this.statusValue = ''
        this.taskPriority = ''
        this.accountValue = ''
        this.contactValue = ''

    
    }

    showToast(myTitle, myMessage , toastVariant) {
        const event = new ShowToastEvent({
            title: myTitle,
            message: myMessage,
            variant : toastVariant
        });
        this.dispatchEvent(event);
    }
}