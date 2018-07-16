
import { Inject, Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { Observable } from 'rxjs/Rx';

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

import { FileUploader } from 'ng2-file-upload';

@Component({
  selector: 'student-update',
  templateUrl: './student-update.component.html',
  styleUrls: ['../student.css']
})
export class StudentUpdateComponent implements OnInit {

  StudentForm: FormGroup;
  std: StudentModel;
  cls: InstitutionClassModel;
  prt: ParentModel;
  prtf: ParentModel;
  prf: PersonRefModel;
  mat:number = 0;
  chSex: string;
  chClassId: number;

  isDateChange: boolean;

  iclasses: Array<InstitutionClassModel>;
  URL = AppSettings.URL_BASE + "/file/upload/students/";
  public uploader:FileUploader;
  imgUrl: string = "";

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, public dialogRef: MatDialogRef<StudentUpdateComponent>, public formBuilder: FormBuilder, private gProvider: GenericProvider) { 
    console.clear();    
    this.uploader  = new FileUploader({url: this.URL, itemAlias: 'photo'});

  	this.std = this.data.std;
    this.cls = this.data.cls;
    this.prt = this.data.prt;
    this.prtf = this.data.prtf;
    this.prf = this.data.prf;

    this.isDateChange = false;

    this.chSex = this.std.studentSex;
    this.chClassId = this.cls.institutionClassId;

    this.imgUrl = AppSettings.URL_BASE + "/file/download/students/" + this.std.studentId + "?" + new Date();

	this.gProvider.getData("/lae_class/all/1").subscribe(data=>{
		this.iclasses = <Array<InstitutionClassModel>>data;
	}, error=>{
		console.log("lae class error", error);
	});

	this.StudentForm = this.formBuilder.group({
	    studentFirstname:  ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
	    studentLastname: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(40), Validators.required])],
	    studentBirthday: ['', Validators.compose([Validators.minLength(8), Validators.maxLength(15), Validators.required])],
	    studentBirthplace: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(30), Validators.required])],
	    studentTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(30), Validators.required])],
	    studentSex: ['', Validators.compose([Validators.required])],
	    studentEmail: ['', Validators.compose([Validators.minLength(0), Validators.maxLength(60)])],
	    //studentReligion: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(50), Validators.required])],
	    studentAddress: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(100), Validators.required])],
	    studentOldSchool: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(300)])],
	   
		/*parent/m form */
	    parentFirstName: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
	    parentLastname: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
	    parentTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(20), Validators.required])],
	    parentAddress: ['', Validators.compose([Validators.minLength(6), Validators.maxLength(100), Validators.required])],

	    /* father/f form */
	    fParentFirstName: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
	    fParentLastname: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
	  	fParentTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(20), Validators.required])],
	  	fParentAddress: ['', Validators.compose([Validators.minLength(6), Validators.maxLength(100),])],
		
	 	/*person ref form */
	 	  personFirstName: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
	    personLastname: ['', Validators.compose([Validators.minLength(2), Validators.maxLength(40), Validators.required])],
	    personTels: ['', Validators.compose([Validators.minLength(7), Validators.maxLength(20), Validators.required])],
	    personSex: ['', Validators.compose([Validators.required])],
	    personDesc: ['', Validators.compose([Validators.minLength(4), Validators.maxLength(50)])],
	    personAddress: ['', Validators.compose([Validators.minLength(4), Validators.maxLength(100), Validators.required])],
		
		/* institution class id-for student class */
	    institutionClassId: ['', Validators.compose([Validators.required])],
	});

    this.initForm();

  }


  ngOnInit() {
  	console.log("form val: ", this.StudentForm.value);
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
      this.URL = AppSettings.URL_BASE + "/file/upload/students/" + this.std.studentId;
      console.log("URL: ", this.URL);
      
      this.uploader.queue.forEach((elem)=> {
          elem.alias = "photo";
          elem.url = this.URL;
      });
  }

  changeSex(val:string): void{
  	this.chSex = val;
  }

  changeClassId(id: number): void{
  	this.chClassId = id;
  }

  setDateChange(){
  	this.isDateChange = true;
  }

  validateStudent(): void{

 	/* parent m*/
    let parent = new ParentModel();
    parent.parentFirstName = this.StudentForm.value.parentFirstName;
    parent.parentLastname = this.StudentForm.value.parentLastname;
    parent.parentSex = 'M';
    parent.parentTels = this.StudentForm.value.parentTels;
    parent.parentAddress = this.StudentForm.value.parentAddress;
    parent.createdBy = this.prt.createdBy
    parent.dateCreated = GlobalFunction.getCurrentDate(true);
    parent.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    parent.dateModified = GlobalFunction.getCurrentDate(true);


    /* parent f*/
    let fparent = new ParentModel();
    fparent.parentFirstName = this.StudentForm.value.fParentFirstName;
    fparent.parentLastname = this.StudentForm.value.fParentLastname;
    fparent.parentSex = 'F';
    fparent.parentTels = this.StudentForm.value.fParentTels;
    fparent.parentAddress = this.StudentForm.value.fParentAddress;
    fparent.createdBy = this.prtf.createdBy;
    fparent.dateCreated = GlobalFunction.getCurrentDate(true);
    fparent.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    fparent.dateModified = GlobalFunction.getCurrentDate(true);

    /* person ref */
    let peref = new PersonRefModel();
    peref.personRefFirstname = this.StudentForm.value.personFirstName;
    peref.personRefLastname = this.StudentForm.value.personLastname;
    peref.personRefSex = this.StudentForm.value.personSex;
    peref.personRefTels = this.StudentForm.value.personTels;
    peref.personRefDesc = this.StudentForm.value.personDesc;
    peref.personRefAddress = this.StudentForm.value.personAddress;
    peref.createdBy = this.prf.createdBy;
    peref.dateCreated = GlobalFunction.getCurrentDate(true);
    peref.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    peref.dateModified = GlobalFunction.getCurrentDate(true);

    /* student obj */
    let std = new StudentModel();
    let instit = <InstitutionModel> JSON.parse(window.localStorage.getItem("INSTITUTION"));

    std.institutionId = instit.institutionId;
    std.institutionClassId = this.chClassId;
    std.studentFirstname = this.StudentForm.value.studentFirstname;
    std.studentLastname = this.StudentForm.value.studentLastname;
    
    std.studentId = this.data.std.studentId;
    std.studentBirthplace = this.StudentForm.value.studentBirthplace;
    std.studentBirthday = new Date(Date.parse(this.StudentForm.value.studentBirthday)).toISOString().split("T")[0];
    std.studentSex = this.chSex;
    std.studentMotherTonge = this.StudentForm.value.studentMotherTonge;
    std.studentSkills = this.StudentForm.value.studentSkills;
    std.studentTels = this.StudentForm.value.studentTels;
    std.studentEmail = this.StudentForm.value.studentEmail;
    std.studentActive = true;
    std.studentReligion = this.StudentForm.value.studentReligion;
    std.createdBy = this.std.createdBy;
    std.dateCreated = GlobalFunction.getCurrentDate(true);
    std.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    std.dateModified = GlobalFunction.getCurrentDate(true);
    std.studentImg = "";
    std.studentAddress = this.StudentForm.value.studentAddress;
    std.studentOldSchool = this.StudentForm.value.studentOldSchool;
  

    parent.parentId = this.prt.parentId;
    peref.personRefId = this.prf.personRefId;
    fparent.parentId = this.prtf.parentId;

	  console.log("To update: ", parent, fparent, peref, std);

	/* insert person and parent */
	Observable.forkJoin(this.gProvider.update(parent, "/parent"), this.gProvider.update(peref, "/person_ref"), this.gProvider.update(fparent, "/parent")).subscribe(data=>{
		std.parentId = this.prt.parentId;
		std.personRefId = this.prf.personRefId;
		std.parentFId = this.prtf.parentId;


		/* update student */
		this.gProvider.update(std, "/student").subscribe(data=>{
				console.log("adding student success", data);
				//this.closeWindow();
        GlobalFunction.showMsgSuccess();
        this.closeWindow();
			}, error=>{
				/* if some errors ocurred when inserting a student we have remove the parent et person ref already insert in step 1*/
				console.log("adding student error: ", error);
				/*
				this.gProvider.deleteObj(std.parentId + "", "/parent").subscribe(data=>{
					console.log("adding student cancelled, remove data parent: ", data);	
				}, error=>{
					console.log("an error occured when removing parent: ", error);
				});

				this.gProvider.deleteObj(std.personRefId + "", "/person_ref").subscribe(data=>{
					console.log("adding student cancelled, remove data person ref: ", data);	
				}, error=>{
					console.log("an error occured when removing person ref: ", error);
				});
			  */
			  GlobalFunction.showMsgError();
			  this.closeWindow();
		});
	}, error=>{
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
		this.closeWindow();
	});
 }

  closeWindow(){
    this.dialogRef.close();
  }

 initForm(): void{
 	this.StudentForm.patchValue({
 		/* student */
		  "studentFirstname": this.std.studentFirstname,
	    "studentLastname": this.std.studentLastname,
	    "studentBirthday": this.std.studentBirthday,
	    "studentBirthplace": this.std.studentBirthplace,
	    "studentTels": this.std.studentTels, 
	    "studentSex": this.std.studentSex,
	    "studentEmail": this.std.studentEmail,
	    "studentReligion": this.std.studentReligion,
	    "studentAddress": this.std.studentAddress,
	    "studentOldSchool": this.std.studentOldSchool,
		
		/* parent m*/
	    "parentFirstName": this.prt.parentFirstName,
	    "parentLastname": this.prt.parentLastname,
	    "parentTels": this.prt.parentTels,
	    "parentAddress": this.prt.parentAddress,

	    /* parent f */
	    "fParentFirstName": this.prtf.parentFirstName,
	    "fParentLastname": this.prtf.parentLastname,
	    "fParentTels": this.prtf.parentTels,
	    "fParentAddress": this.prtf.parentAddress,

	 	  "personFirstName": this.prf.personRefFirstname,
	    "personLastname": this.prf.personRefLastname,
	    "personTels": this.prf.personRefTels,
	    "personSex": this.prf.personRefSex,
	    "personDesc": this.prf.personRefDesc,
	    "personAddress": this.prf.personRefAddress,
		
	    "institutionClassId": this.std.institutionClassId
	});
  }
}

