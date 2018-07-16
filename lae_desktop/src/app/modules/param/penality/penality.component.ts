import { Component, OnInit } from '@angular/core';
import { Inject} from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { GlobalFunction } from '../../../global/global';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { PenalityTypeModel } from '../../../models/student-model';
import { Router } from '@angular/router';

//import { StudentSearchComponent } from '../../rh/students/student-search/student-search.component';

@Component({
  selector: 'app-penality',
  templateUrl: './penality.component.html',
  styleUrls: ['./penality.component.css']
})
export class StudentPenalityComponent implements OnInit {

  penls: Array<PenalityTypeModel>;
  penl: PenalityTypeModel;

  constructor(private gProvider: GenericProvider, public dialog: MatDialog) {
    console.clear();

    this.penl = new PenalityTypeModel();
    this.fetchData();
  }

  ngOnInit(){

  }

  fetchData(): void{
    this.gProvider.getData("/penality_type/all").subscribe(data=>{
      console.log("class found: ", data);
      this.penls = <Array<PenalityTypeModel>>data;
    }, error=>{
      console.log("fetch data error: ", error);
    });
  }

  openDialog(data, param, w, h): void {
    //AppSettings.CLASS_DATA_MODE = data.institutionClassId;

  	data.param = param;

    let dialogRef = this.dialog.open(DialogUpdatePenalityType, {
      width: w,
      height: h,
      data: data
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
      this.fetchData();
    });
  }

}

@Component({
  selector: 'class-update-dialog',
  templateUrl: 'penality-update-dialog.html',
  styleUrls: ['./penality.component.css'],
  providers: [GenericProvider]
})
export class DialogUpdatePenalityType {

  penl: PenalityTypeModel;

  PenlForm: FormGroup;
  isDelete: boolean;
  isDetails: boolean;
  
  constructor(public dialogRef: MatDialogRef<DialogUpdatePenalityType>, private router:Router, private formBuilder: FormBuilder, private gProvider: GenericProvider, @Inject(MAT_DIALOG_DATA) public data: any){
	  
	this.isDelete = (this.data.param == "Delete" || this.data.param == "Details");
  this.isDetails =  this.data.param == "Details";

	this.PenlForm = this.formBuilder.group({
	    penalityTypeName:  ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
	    penalityTypeDesc: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
      penalityTypeFee: ['', Validators.compose([Validators.required])],
	});

	if(this.data.param == "Update" || this.isDelete){
    	this.PenlForm.setValue({"penalityTypeName": this.data.penalityTypeName, "penalityTypeDesc": this.data.penalityTypeDesc, "penalityTypeFee": this.data.penalityTypeFee});
  	}else if(this.data.param == "Add"){
      this.PenlForm.setValue({"penalityTypeName": "", "penalityTypeDesc": "", "penalityTypeFee": ""});
  	}else if(this.data.param == "Details"){
      this.PenlForm.setValue({"penalityTypeName": this.data.penalityTypeName, "penalityTypeDesc": this.data.penalityTypeDesc, "penalityTypeFee": this.data.penalityTypeFee});
  	}

  }

  onClickSave(): void{
      let obj1: PenalityTypeModel = new PenalityTypeModel();
      obj1.penalityTypeId = this.data.penalityTypeId;
      obj1.penalityTypeName = this.PenlForm.value.penalityTypeName;
      obj1.penalityTypeDesc = this.PenlForm.value.penalityTypeDesc;
      obj1.penalityTypeFee = this.PenlForm.value.penalityTypeFee;
      obj1.createdBy = AppSettings.DEFAULT_USER.userUsername;
      obj1.dateCreated = GlobalFunction.getCurrentDate(true);
      obj1.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
      obj1.dateModified = GlobalFunction.getCurrentDate(true);

      if(this.data.param == "Update"){

  	  	this.gProvider.update(obj1, "/penality_type").subscribe(data=>{
  	  		console.log("Update penality type success: ", data);    		    
  	  	}, error=>{
  	  		  console.log("Update penality type error: ", error);
    		    this.onNoClick();
  	  	});
  	}else if(this.data.param == "Delete"){
  		this.gProvider.deleteObj(this.data.penalityTypeId, "/penality_type").subscribe(data=>{
  			  console.log("Delete inst penality type success: ", data);    
  		    this.onNoClick();
          GlobalFunction.showMsgSuccess();
  		}, error=>{
  			console.log("Delete ins penality type error: ", error);
  		    this.dialogRef.close();
  		})
  	}else if(this.data.param == "Add"){
	    this.gProvider.add(obj1, "/penality_type").subscribe(data=>{
	    	console.log("adding penality type success: ", data);
        GlobalFunction.showMsgSuccess();
	    }, error=>{
	    	console.log("adding penality type error: ", error);
  		    this.onNoClick();
	    })	
	}
  	
  	this.onNoClick();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

}