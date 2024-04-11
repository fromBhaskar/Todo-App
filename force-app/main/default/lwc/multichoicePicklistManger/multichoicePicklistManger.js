import { LightningElement, track, wire } from "lwc";
import getSObjectList from "@salesforce/apex/SObjectManager.getAllSObjectNames";
import getSObjectFields from "@salesforce/apex/SObjectManager.getSObjectMultiChoiceFields";
import getMultiPicklist from "@salesforce/apex/SObjectManager.getMultiPicklist";
import getAllMultiPicklist from "@salesforce/apex/SObjectManager.getAllMultiPicklist";
import putMultiPicklist from "@salesforce/apex/SObjectManager.createMultiPicklist";
import updateMultiPicklist from "@salesforce/apex/SObjectManager.updateMultiPicklist";
import deleteMultiPicklist from "@salesforce/apex/SObjectManager.deleteMultiPicklist";
import deleteALLMultiPicklist from "@salesforce/apex/SObjectManager.deleteAllMultiPicklist";
import { refreshApex } from "@salesforce/apex";
import Toast from "lightning/toast";

export default class MultichoicePicklistManger extends LightningElement {
  //SObject related fields
  @track sObjectList = [];
  @track MCPList = [];
  @track wireAllMultiPlicklistData;

  hasMultiChoiceFields = true;
  hasMultiPicklistFlow = false;

  selectedObjectList = [];
  selectedObjectName = "";
  selectedFieldName = "";
  buttonLabel = "Activate";
  showSpinner = false;

  // JS Properties
  pageSizeOptions = [5, 10, 25, 50, 75, 100]; //Page size options
  @track records = []; //All records available in the data table
  @track recordsCopy = []; //All records available in the data table
  totalRecords = 0; //Total no.of records
  pageSize; //No.of records to be displayed per page
  totalPages; //Total no.of pages
  pageNumber = 1; //Page number
  @track recordsToDisplay = []; //Records to be displayed on the page
  @track recordsToDisplayCopy = []; //Records to be displayed on the page
  searchItem = "";

  actions = [{ label: "Deactivate", name: "delete" }];

  columns = [
    { label: "Object", fieldName: "Object__c" },
    { label: "Active Fields", fieldName: "Fields__c" },
    { label: "Active Object", fieldName: "MP_Object_Name__c" },
    { label: "Active Flow", fieldName: "Flow__c" },
    {
      label: "Action",
      type: "action",
      typeAttributes: { rowActions: this.actions }
    }
  ];

  @wire(getAllMultiPicklist)
  wiredRecordData(value) {
    let data = value.data;
    let error = value.data;
    console.log("wire data..");
    this.wireAllMultiPlicklistData = value;
    if (data) {
      let newData = data.map((record, index) => {
        let newRecord = structuredClone(record);
        for (const key in record) {
          if (key !== "Id") {
            let str = record[key].replaceAll("__c", "").replaceAll("_", " ");
            newRecord[key] = str.charAt(0).toUpperCase() + str.slice(1);
          }
        }
        newRecord.index = index;
        return newRecord;
      });

      this.recordsCopy = newData;

      this.records = data;
      this.totalRecords = data.length; // update total records count
      this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
      this.paginationHelper(); // call helper menthod to update pagination logic
    } else if (error) {
      console.log("on wiredRecordData error :", error);
    }
  }

  handleSObjectChange(event) {
    console.log(this.records);

    this.selectedObjectName = "";
    this.selectedFieldName = "";
    this.MCPList = [];
    const name = event.detail.value;
    this.selectedObjectName = name;
    console.log(name);

    getSObjectFields({ selectedObject: name })
      .then((d) => {
        console.log(d);
        if (d) {
          this.hasMultiChoiceFields = false;
          this.MCPList = d;
        } else {
          this.hasMultiChoiceFields = true;
        }
      })
      .catch((e) => {
        console.log(e);
      });
  }

  get showMultiChoiceFeilds() {
    return !this.hasMultiChoiceFields;
  }

  get showDeleteAll() {
    return this.selectedObjectList.length > 0 ? true : false;
  }

  handleDeleteAll() {
    if (this.selectedObjectList) {
      deleteALLMultiPicklist({ mpList: this.selectedObjectList })
        .then(() => {
          this.refreshData();
          this.showToast(
            "Success",
            "Selected field is successfully Deactivated..!",
            "success"
          );
        })
        .catch((e) => {
          console.log(e);
        });
    }
  }

  get options() {
    return this.sObjectList.map((obj) => {
      return { label: obj, value: obj };
    });
  }

  get showLoading() {
    return !(this.records.length > 0);
  }

  get showDataTable() {
    return this.records.length > 0;
  }

  get searchOptions() {
    const newList = this.records.filter(
      (item, index) => item.Object__c !== this.records[index].Object__c
    );
    return newList.map((obj) => {
      return { label: obj.Object__c, value: obj.Object__c };
    });
  }

  handleSearch(event) {
    let name = event.target.value;
    this.searchItem = name;

    console.log(name);
    if (name) {
      let tempList = [];
      this.records.forEach((item) => {
        if (item.Object__c.replaceAll("__c", "").replaceAll("_", " ").includes(name)) tempList.push(item);
      });

      let newData = tempList.map((record, index) => {
        let newRecord = structuredClone(record);
        for (const key in record) {
          if (key !== "Id") {
            let str = record[key].replaceAll("__c", "").replaceAll("_", " ");
            newRecord[key] = str.charAt(0).toUpperCase() + str.slice(1);
          }
        }
        newRecord.index = index;
        return newRecord;
      });
      this.recordsToDisplayCopy = newData;
      this.recordsToDisplay = tempList;
    } else {
      this.recordsToDisplayCopy = this.recordsCopy;
      this.recordsToDisplay = this.records;
    }
  }

  handleOnRowSelection(event) {
    this.selectedObjectList = event.detail.selectedRows;
    console.log("selected row", event.detail.selectedRows);
  }
  connectedCallback() {
    getSObjectList()
      .then((data) => {
        this.sObjectList = data.filter((item) => {
          return item.startsWith("MP_") && item.endsWith("__c") ? false : true;
        });
      })
      .catch((e) => {
        console.log(e);
      });
  }

  handleRowAction(event) {
    const actionName = event.detail.action.name;
    const record = event.detail.row;
    switch (actionName) {
      case "delete":
        this.onDeleteRecord(record);
        break;

      default:
    }
  }

  onDeleteRecord(record) {
    console.log("on delete", record);

    deleteMultiPicklist({ mp: this.recordsToDisplay[record.index] })
      .then(() => {
        this.refreshData();
        this.selectedFieldName = "";
        this.showToast(
          "Success",
          "Selected field is successfully Deactivated..!",
          "success"
        );
      })
      .catch((e) => {
        console.log(e);
      });
  }

  get sObjectLabel() {
    return this.sObjectList.length > 0
      ? `Select SObject (${this.sObjectList.length}) :`
      : `Select SObject :`;
  }

  get multiChoiceFieldLabel() {
    return `Select Multichoice Field (${this.MCPList.length}) :`;
  }

  get sObjects() {
    return this.sObjectList.sort().map((field) => {
      let label = field.replaceAll("__c", "").replaceAll("_", " ");
      label = label.charAt(0).toUpperCase() + label.slice(1);
      return { label: label, value: field };
    });
  }

  get multiChoiceFields() {
    return this.MCPList.sort().map((field) => {
      let label = field.replaceAll("__c", "").replaceAll("_", " ");
      label = label.charAt(0).toUpperCase() + label.slice(1);
      return { label: label, value: field };
    });
  }

  cleanDataList(dataList) {
    return dataList.map((item) => {
      let str = item.replaceAll("__c", "").replaceAll("_", " ");
      str = str.charAt(0).toUpperCase() + str.slice(1);
      return str;
    });
  }

  async handleMultiChoiceFields(event) {
    const name = event.detail.value;
    this.selectedFieldName = name;

    await getMultiPicklist({ objectName: this.selectedObjectName })
      .then((d) => {
        console.log(d);
        if (d) {
          console.log(this.selectedFieldName);
          console.log("fields", d.Fields__c);
          if (d.Fields__c.includes(this.selectedFieldName)) {
            console.log("off");
            this.hasMultiPicklistFlow = true;
            this.buttonLabel = "Deactivate";
          } else {
            this.hasMultiPicklistFlow = false;
            this.buttonLabel = "Activate";
          }
        }
      })
      .catch((e) => {
        console.log(e);
      });

    console.log(name);
  }

  get enableUpdateButton() {
    if (this.selectedFieldName && this.selectedObjectName) {
      return false;
    }
    return true;
  }

  get showDataTabel(){
     return this.recordsToDisplayCopy.length > 0 ? true : false
  }

  get showActiveButton() {
    if (this.selectedFieldName && this.selectedObjectName) {
      return true;
    }
    return false;
  }

  async handleClick(event) {
    const eventName = event.target.name;
    this.showSpinner = true;

    await getMultiPicklist({ objectName: this.selectedObjectName })
      .then((d) => {
        console.log(d);
        if (d) {
          console.log(this.selectedFieldName);
          console.log("fields", d.Fields__c, this.selectedObjectName);
          if (d.Fields__c.includes(this.selectedFieldName)) {
            console.log("off");
            this.hasMultiPicklistFlow = true;
            this.buttonLabel = "Deactivate";
          } else {
            this.hasMultiPicklistFlow = false;
            this.buttonLabel = "Activate";
          }
        } else {
          this.hasMultiPicklistFlow = false;
          this.buttonLabel = "Activate";
        }
      })
      .catch((e) => {
        console.log(e);
      });
    if (eventName === "Activate") {
      if (this.hasMultiPicklistFlow) {
        this.showSpinner = false;
        this.showToast("Info", `Selected field is Already Active..!`);
      } else {
        this.showSpinner = true;
        putMultiPicklist({
          objectName: this.selectedObjectName,
          fieldValues: this.selectedFieldName
        })
          .then(() => {
            this.refreshData();
            this.showToast(
              "Success",
              "Selected field is successfully Activated..!",
              "success"
            );
            this.buttonLabel = "Deactivate";
            this.showSpinner = false;
          })
          .catch((e) => {
            console.log(e);
            this.showSpinner = false;
            this.showToast("Error", "Activation Failed ..!", "error");
          });
      }
    } else if (eventName === "Deactivate") {
      console.log(
        "on Deactivate",
        this.selectedObjectName,
        this.selectedFieldName
      );
      updateMultiPicklist({
        objectName: this.selectedObjectName,
        fieldValues: this.selectedFieldName
      })
        .then(() => {
          this.refreshData();
          this.showToast(
            "Success",
            "Selected field is successfully Deactivate..!",
            "success"
          );
          this.buttonLabel = "Activate";
          this.showSpinner = false;
        })
        .catch((e) => {
          console.log(e);
        });
    }
  }

  showToast(label, message, variant) {
    Toast.show(
      {
        label: label,
        message: message,
        variant: variant
      },
      this
    );
  }

  refreshData() {
    refreshApex(this.wireAllMultiPlicklistData)
      .then(() => {
        console.log(this.records);
      })
      .catch(() => {});
  }

  // pagination
  get showPagination() {
    return this.totalRecords > 5 ? true : false;
  }

  handleRecordsPerPage(event) {
    this.pageSize = event.target.value;
    this.paginationHelper();
  }
  previousPage() {
    this.pageNumber = this.pageNumber - 1;
    this.paginationHelper();
  }
  nextPage() {
    this.pageNumber = this.pageNumber + 1;
    this.paginationHelper();
  }
  firstPage() {
    this.pageNumber = 1;
    this.paginationHelper();
  }
  lastPage() {
    this.pageNumber = this.totalPages;
    this.paginationHelper();
  }
  // JS function to handel pagination logic
  paginationHelper() {
    this.recordsToDisplay = [];
    this.recordsToDisplayCopy = [];
    // calculate total pages
    this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
    // set page number
    if (this.pageNumber <= 1) {
      this.pageNumber = 1;
    } else if (this.pageNumber >= this.totalPages) {
      this.pageNumber = this.totalPages;
    }
    // set records to display on current page
    for (
      let i = (this.pageNumber - 1) * this.pageSize;
      i < this.pageNumber * this.pageSize;
      i++
    ) {
      if (i === this.totalRecords) {
        break;
      }

      let newRecord = structuredClone(this.records[i]);
      for (const key in this.records[i]) {
        if (key !== "Id") {
          let str = this.records[i][key]
            .replaceAll("__c", "")
            .replaceAll("_", " ");
          newRecord[key] = str.charAt(0).toUpperCase() + str.slice(1);
          newRecord.index = i;
        }
      }
      this.recordsToDisplayCopy.push(newRecord);
      this.recordsToDisplay.push(this.records[i]);
    }
  }
}
