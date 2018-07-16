
import { Component, OnInit } from '@angular/core';
import { Inject} from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { GlobalFunction } from '../../../global/global';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { InstitutionClassModel, InstitutionModel, PaymentPeriodModel } from '../../../models/institution-model';

import { PaymentPeriodeComponent } from '../payment-periode/payment-periode.component';
import { CourseComponent } from '../course/course.component';

//import { StudentSearchComponent } from '../../rh/students/student-search/student-search.component';

@Component({
  selector: 'class-def',
  templateUrl: './class-def.component.html',
  styleUrls: ['./class-def.component.css']
})
export class ClassDefComponent implements OnInit {

  classes: Array<InstitutionClassModel>;
  instit: InstitutionModel;
  defaultClas: InstitutionClassModel;

  constructor(private gProvider: GenericProvider, public dialog: MatDialog) {
    //console.clear();
    this.defaultClas = new InstitutionClassModel();
    this.defaultClas.institutionId = 1;
    this.defaultClas.institutionClassId = 1;
  }

  ngOnInit(){
    this.instit = AppSettings.INSTITUTION;
    console.log(" class institution: ", this.instit);

    if(this.instit != null){
      this.fetchData();
    }else{
      console.log("Aucune institution trouvée ! ");
      this.instit = new InstitutionModel();
    }
  }

  fetchData(): void{
    
    this.gProvider.getData("/lae_class/all/1").subscribe(data=>{
      console.log("class found: ", data);
      this.classes = <Array<InstitutionClassModel>>data;
    }, error=>{
      console.log(" fetch classes data error: ", error);
    });
  }

  openDialog(c, param, w, h): void {
    AppSettings.CLASS_DATA_MODE = c.institutionClassId;
    let data:any = new Object();

      data.param = param;
      data.clas = c;
      
      let dialogRef = this.dialog.open(DialogMgrDialog, {
        width: w,
        height: h,
        data: data
      });

      dialogRef.afterClosed().subscribe(result => {
        setTimeout(()=>{
          this.fetchData();
          console.log("Updated classes: ", this.classes);
        }, 3000);
      });
  }

  openPaymentDialog(clas: Object){
    let dialogRef = this.dialog.open(PaymentPeriodeComponent, {
      width: "950px",
      height: "450px",
      data: clas
    });
  }

  openCourseDialog(clas: Object){
    let dialogRef = this.dialog.open(CourseComponent, {
      width: "850px",
      height: "550px",
      data: clas
    });
  }

  openScheduleDialog(clas: Object){
    let dialogRef = this.dialog.open(CourseComponent, {
      width: "800px",
      height: "450px",
      data: clas
    });
  }
}

@Component({
  selector: 'class-mgr-dialog',
  templateUrl: 'class-def-dialog.html',
  styleUrls: ['./class-def.component.css'],
  providers: [GenericProvider]
})
export class DialogMgrDialog implements OnInit{

  clas: InstitutionClassModel;
  pay: PaymentPeriodModel;
  pays: Array<PaymentPeriodModel>;

  ClassForm: FormGroup;
  isDelete: boolean;
  isDetails: boolean;

  constructor(public dialogRef: MatDialogRef<DialogMgrDialog>, private formBuilder: FormBuilder, private gProvider: GenericProvider, @Inject(MAT_DIALOG_DATA) public data: any){

  this.clas = this.data.clas;
  this.pays = this.data.pays;
  this.pay = new PaymentPeriodModel();

  console.log("PAYS : ", this.pays);
  this.pay.init();

	this.ClassForm = this.formBuilder.group({
	  institutionClassName:  ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
	  institutionClassLevel: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
    institutionClassDesc: ['', Validators.compose([Validators.minLength(8), Validators.maxLength(200), Validators.required])],
	});

	if(this.data.param == "Update" || this.isDelete){
    	this.ClassForm.setValue( {
        "institutionClassName": this.clas.institutionClassName, 
        "institutionClassLevel": this.clas.institutionClassLevel, 
        "institutionClassDesc": this.clas.institutionClassDesc, 
      });
  	}else if(this.data.param == "Add"){
      this.pays = [];
    	this.ClassForm.setValue({
        "institutionClassName": "", 
        "institutionClassLevel": "", 
        "institutionClassDesc": "", 
      });
  	}else if(this.data.param == "Details"){
      this.ClassForm.setValue({
        "institutionClassName": this.clas.institutionClassName, 
        "institutionClassLevel": this.clas.institutionClassLevel, 
        "institutionClassDesc": this.clas.institutionClassDesc, 
      });
  }else{
      this.ClassForm.setValue({
        "institutionClassName": this.clas.institutionClassName, 
        "institutionClassLevel": this.clas.institutionClassLevel, 
        "institutionClassDesc": this.clas.institutionClassDesc, 

      });
  	}
  }

  ngOnInit(){
    console.log("Form DATA: ", this.ClassForm.value);
  }

  showStd(): void{
    //this.isStd = !this.isStd;
  }

  onClickSave(): void{
      let obj1: InstitutionClassModel = new InstitutionClassModel();
      let instit = <InstitutionModel> JSON.parse(window.localStorage.getItem("INSTITUTION"));
      obj1.institutionClassId = this.clas.institutionClassId;
      obj1.institutionId = instit.institutionId;
      obj1.institutionClassName = this.ClassForm.value.institutionClassName;
      obj1.institutionClassLevel = this.ClassForm.value.institutionClassLevel;
      obj1.institutionClassDesc = this.ClassForm.value.institutionClassDesc;
      obj1.institutionClassCode = this.clas.institutionClassCode;
      obj1.createdBy = AppSettings.DEFAULT_USER.userUsername;
      obj1.dateCreated = GlobalFunction.getCurrentDate(true);
      obj1.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
      obj1.dateModified = GlobalFunction.getCurrentDate(true); 

      if(this.data.param == "Update"){
  	  	this.gProvider.update(obj1, "/lae_class").subscribe(data=>{
          console.log("Update class success: ", data);
          
  	  	}, error=>{
  	  		  console.log("Update class error: ", error);
    		    this.onNoClick();
  	  	});
  	}else if(this.data.param == "Delete"){
  		this.gProvider.deleteObj(this.clas.institutionClassId + "", "/lae_class").subscribe(data=>{
  			  console.log("Delete inst class success: ", data);    
  		    this.onNoClick();
          GlobalFunction.showMsgSuccess();
  		}, error=>{
  			console.log("Delete ins class error: ", error);
  		    this.dialogRef.close();
  		})
  	}else if(this.data.param == "Add"){
	    this.gProvider.add(obj1, "/lae_class").subscribe(data=>{
	    	console.log("adding class success: ", data);
        //GlobalFunction.showMsgSuccess();
	    }, error=>{
	    	console.log("adding class error: ", error);
  		    this.onNoClick();
	    })	
	}
  	
  	this.onNoClick();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  textTranslate(text: string){
    if(text.toLocaleLowerCase().indexOf("del") > -1){
      return "Supprimer";
    }else if(text.toLocaleLowerCase().indexOf("add") > -1){
      return "Ajouter";
    }else{
      return "Modifier";
    }
  }
}