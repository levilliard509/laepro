
import { Component, OnInit, ViewChild, ElementRef, Inject, Input } from '@angular/core';
import { Observable } from 'rxjs/Rx';
import 'rxjs/add/operator/startWith';
import 'rxjs/add/observable/merge';
import 'rxjs/add/operator/map';

import { StudentModel } from '../../../models/student-model';
import { ParentModel } from '../../../models/parent-model';
import { PersonRefModel } from '../../../models/person-ref-model';
import { AddressModel } from '../../../models/address-model';
import { InstitutionClassModel } from '../../../models/institution-model';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { InstitutionModel } from '../../../models/institution-model';

import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { GlobalFunction } from '../../../global/global';
import { FileUploader } from 'ng2-file-upload/ng2-file-upload';


@Component({
  selector: 'student-add',
  templateUrl: './student-add.component.html',
  styleUrls: ['./student-add.component.css']
})
export class StudentAddComponent{

  StudentForm: FormGroup;
  iclasses: Array<InstitutionClassModel>;
  minDate: any;
  maxDate: any;
  codeStd: string = "";
  addr: AddressModel = AppSettings.ADDRESS;
  iname: string = AppSettings.INSTITUTION.institutionName + ""; 

  imgUrl = "assets/img/student.jpg";
  currentStd: StudentModel;
  URL = AppSettings.URL_BASE + "/file/upload/students/";
  public uploader:FileUploader;

  constructor(private gProvider: GenericProvider, public formBuilder: FormBuilder, private el: ElementRef){
      console.clear();
      this.currentStd = new StudentModel();
      this.uploader  = new FileUploader({url: this.URL, itemAlias: 'photo'});
	  
  	  let date = new Date();
  	  this.minDate = new Date(1930, 0, 1);
  	  this.maxDate = new Date(date.getFullYear() - 3, 0, 1);
      AppSettings.CLASS_DATA_MODE = 0;

      console.log("default address: ", this.addr);
	  this.gProvider.getData("/lae_class/all/1").subscribe(data=>{
		this.iclasses = <Array<InstitutionClassModel>>data;
		if(this.iclasses.length <= 0){
			alert("Vous devez d'abord ajouter les classes de l'institution: " + this.iname.toUpperCase());
		}
	   }, error=>{
			console.log("lae class error", error);
			alert("Vous devez d'abord ajouter les classes de l'institution: " + this.iname.toUpperCase());
	   });

    	this.StudentForm = this.formBuilder.group({
    		/* student form */
		    studentFirstname:  ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
		    studentLastname: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
		    studentBirthday: ['', Validators.compose([Validators.minLength(8), Validators.maxLength(15), Validators.required])],
		    studentBirthplace: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(30), Validators.required])],
		    studentTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(30)])],
		    studentSex: ['', Validators.compose([Validators.required])],
		    studentEmail: ['', Validators.compose([Validators.minLength(0), Validators.maxLength(60)])],
		    //studentReligion: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(50)])],
		    studentAddress: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(100)])],
		    studentOldSchool: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(200)])],
		   
  		    /* father form */
		    parentFirstName: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
		    parentLastname: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
		    parentTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(20), Validators.required])],
		    parentAddress: ['', Validators.compose([Validators.minLength(6), Validators.maxLength(100),])],
  		
		    /* father form */
		    fParentFirstName: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
		    fParentLastname: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
		  	fParentTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(20), Validators.required])],
		  	fParentAddress: ['', Validators.compose([Validators.minLength(6), Validators.maxLength(100),])],

		    /* person ref form */
		 	personFirstName: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
		    personLastname: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
		    personSex: ['', Validators.compose([Validators.required])],
		    personTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(20), Validators.required])],
		    personDesc: ['', Validators.compose([Validators.minLength(4), Validators.maxLength(50), Validators.required])],
		    personAddress: ['', Validators.compose([Validators.minLength(4), Validators.maxLength(50), Validators.required])],
			
			/* institution class id-for student class */
		    institutionClassId: ['', Validators.compose([Validators.required])],
  		});
  }

  ngOnInit(){
    this.initAddr();

         //override the onAfterAddingfile property of the uploader so it doesn't authenticate with //credentials.
     this.uploader.onAfterAddingFile = (file)=> { 
       this.setUrl();
       file.withCredentials = false; 
     };
     //overide the onCompleteItem property of the uploader so we are 
     //able to deal with the server response.
     this.uploader.onCompleteItem = (item:any, response:any, status:any, headers:any) => {
          console.log("ImageUpload:uploaded:", item, status, response);
      };
  }
  
  setUrl(): void{
    this.currentStd.studentImg = "machin";

    if(this.currentStd.studentImg != null && this.currentStd.studentImg.length > 0){
      this.URL = AppSettings.URL_BASE + "/file/upload/students/" + this.currentStd.studentImg;
      this.uploader.queue.forEach((elem)=> {
          elem.alias = "photo";
          elem.url = this.URL;
      });
    }else{
      console.log("aucon enregistremen effectue");
    }
  }

  downloadPhoto(uri: string){

  }


  printStd(): void {
    let printContents, popupWin;
    printContents = document.getElementById('std-section').innerHTML;
    popupWin = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
    popupWin.document.open();
    popupWin.document.write(`
      <html>
        <head>
          <title> Institution ${this.iname}</title>
          <style>
			.header-info{
				padding: 5px 40px;
				background: #263238;
				color: #fff;
				text-align: center;
				margin: 20px auto;
			}
         
		</style>
        </head>
        <h2 class="header-info"> Formulaire d'inscription </h2>
       <body onload="window.print();window.close()">${printContents}</body>
      </html>`
    );
    popupWin.document.close();
  }

 deleteStudent(): void{
 	this.gProvider.deleteObj(this.codeStd + "", "/student").subscribe(data=>{
 		console.log(" delete student success ...");
    	GlobalFunction.showMsgSuccess();
 	}, error=>{
 		console.log(" delete student error ...");
 	});
 }
 
 validateStudent(): void{

    /* parent m*/
    let parent = new ParentModel();
	parent.parentFirstName = this.StudentForm.value.parentFirstName;
	parent.parentLastname = this.StudentForm.value.parentLastname;
	parent.parentSex = 'M';
	parent.parentTels = this.StudentForm.value.parentTels;
	parent.parentAddress = this.StudentForm.value.parentAddress;
 	parent.createdBy = AppSettings.DEFAULT_USER.userUsername;
    parent.dateCreated = GlobalFunction.getCurrentDate(true);
    parent.modifiedBy = "";
    parent.dateModified = GlobalFunction.getCurrentDate(true);

    /* parent f*/
    let fparent = new ParentModel();
	fparent.parentFirstName = this.StudentForm.value.fParentFirstName;
	fparent.parentLastname = this.StudentForm.value.fParentLastname;
	fparent.parentSex = 'F';
	fparent.parentTels = this.StudentForm.value.fParentTels;
	fparent.parentAddress = this.StudentForm.value.fParentAddress;
	fparent.createdBy = AppSettings.DEFAULT_USER.userUsername;
    fparent.dateCreated = GlobalFunction.getCurrentDate(true);
    fparent.modifiedBy = "";
    fparent.dateModified = GlobalFunction.getCurrentDate(true);

    /* person ref */
    let peref = new PersonRefModel();
  	peref.personRefFirstname = this.StudentForm.value.personFirstName;
  	peref.personRefLastname = this.StudentForm.value.personLastname;
  	peref.personRefSex = this.StudentForm.value.personSex;
  	peref.personRefTels = this.StudentForm.value.personTels;
  	peref.personRefDesc = this.StudentForm.value.personDesc;
  	peref.personRefAddress = this.StudentForm.value.personAddress;
  	peref.createdBy = AppSettings.DEFAULT_USER.userUsername;
    peref.dateCreated = GlobalFunction.getCurrentDate(true);
    peref.modifiedBy = "";
    peref.dateModified = GlobalFunction.getCurrentDate(true);

    /* student obj */
    let std = new StudentModel();
    std.institutionId = AppSettings.INSTITUTION.institutionId;
    std.institutionClassId = this.StudentForm.value.institutionClassId;
    std.studentFirstname = this.StudentForm.value.studentFirstname;
    std.studentLastname = this.StudentForm.value.studentLastname;
    std.studentBirthday = new Date(Date.parse(this.StudentForm.value.studentBirthday)).toISOString().split("T")[0];
  	std.studentBirthplace = this.StudentForm.value.studentBirthplace;
  	std.studentSex = this.StudentForm.value.studentSex;
  	std.studentMotherTonge = this.StudentForm.value.studentMotherTonge;
  	std.studentSkills = this.StudentForm.value.studentSkills;
  	std.studentTels = this.StudentForm.value.studentTels;
  	std.studentAddress = this.StudentForm.value.studentAddress;
  	std.studentEmail = this.StudentForm.value.studentEmail 
    std.studentActive = true;
  	std.studentReligion = this.StudentForm.value.studentReligion;
  	std.createdBy = AppSettings.DEFAULT_USER.userUsername;
  	std.dateCreated = GlobalFunction.getCurrentDate(true);
  	std.modifiedBy = "";
  	std.dateModified = GlobalFunction.getCurrentDate(true);
	std.studentImg = ""; 
	std.studentOldSchool = this.StudentForm.value.studentOldSchool;

	/* insert person, parent m, parent f */
	Observable.forkJoin(this.gProvider.add(parent, "/parent"), this.gProvider.add(peref, "/person_ref"), this.gProvider.add(fparent, "/parent")).subscribe(data=>{
		std.parentId = parseInt(data[0].toString());
		std.personRefId = parseInt(data[1].toString());
		std.parentFId = parseInt(data[2].toString());
        this.currentStd = std;
		/* instert student */
		this.gProvider.add(std, "/student").subscribe(data=>{
			console.log("adding student success", data);
            this.currentStd.studentImg = parseInt(data.toString()) + "";
			this.StudentForm.reset();
			GlobalFunction.showMsgSuccess();
			if(this.uploader.getNotUploadedItems().length && this.uploader.getNotUploadedItems().length > 0){
				this.uploader.uploadAll();
			}  
			}, error=>{
				/* if some errors ocurred when inserting a student we have remove the parent et person ref already insert in step 1*/
				console.log("adding student error: ", error);
				GlobalFunction.showMsgError();
		});
	}, error=>{
		GlobalFunction.showMsgError();

		if(std.parentId){
			this.gProvider.deleteObj(std.parentId + "", "/parent").subscribe(data=>{
				console.log("adding student cancelled, remove data parent: ", data);	
			}, error=>{
				console.log("an error occured when removing parent: ", error);
			});
		}

		if(std.personRefId){
			this.gProvider.deleteObj(std.personRefId + "", "/person_ref").subscribe(data=>{
				console.log("adding person ref cancelled, remove data parent: ", data);	
			}, error=>{
				console.log("an error occured when removing parent: ", error);
			});
		}			

		console.log("error insert parent and/or person ref: ", error);
	});
 }

  private initAddr(){

  }

}

