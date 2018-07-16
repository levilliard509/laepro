
import { OnInit, Component, ViewChild, ElementRef, Inject, Input } from '@angular/core';
import { DataSource } from '@angular/cdk/collections';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';
import { Observable } from 'rxjs/Rx';
import 'rxjs/add/operator/startWith';
import 'rxjs/add/observable/merge';
import 'rxjs/add/operator/map';

import { StudentModel } from '../../../models/student-model';
import { AddressModel } from '../../../models/address-model';
import { InstitutionClassModel } from '../../../models/institution-model';
import { StudentPenalityModel, PenalityTypeModel, StudentAbsenceModel } from '../../../models/student-model';
import { MatPaginator, MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';

import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';

import { StudentDetailsComponent } from '../student-details/student-details.component';
import { StudentUpdateComponent } from '../student-update/student-update.component';
import { GlobalFunction } from '../../../global/global';

//import { FileUploader } from 'ng2-file-upload/ng2-file-upload';


@Component({
  selector: 'student-view',
  templateUrl: './student-view.component.html',
  styleUrls: ['../student.css']
})
export class StudentViewComponent{
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild('filter') filter: ElementRef;
  @ViewChild('fileInput') fileInput;

  columns = ["Code", "Prenom", "Nom", "DateNaiss", "LieuNaiss", "Sexe", /*"Competences",  "Tel", "Email", "Religion",*/ "Details", "Update", "Sanction", "RAbsence"]; /*, "CreatedBy", "DateCreated", "ModifiedBy", "DateModified"]*/
  studentDatabase = new StudentDatabase(this.gProvider, "");
  dataSource: StudentDataSource | null;
  iclasses: Array<InstitutionClassModel>;
  minDate: any;
  maxDate: any;
  codeStd: string = "";
  addr: AddressModel = AppSettings.ADDRESS;
  iname: string = AppSettings.INSTITUTION.institutionName; 
  imgUrl = "assets/img/student.jpg";
  currentStd: StudentModel;
  URL = AppSettings.URL_BASE + "/file/upload/students/";

  //public uploader:FileUploader;


  constructor(private gProvider: GenericProvider, public dialog: MatDialog, private el: ElementRef){
      console.clear();
      //this.uploader  = new FileUploader({url: this.URL, itemAlias: 'photo'});
      this.currentStd = new StudentModel();

  		let date = new Date();
  		this.minDate = new Date(1930, 0, 1);
  		this.maxDate = new Date(date.getFullYear() - 3, 0, 1);
        AppSettings.CLASS_DATA_MODE = 0;

      console.log("default address: ", this.addr);
  		this.gProvider.getData("/lae_class/all/1").subscribe(data=>{
  			this.iclasses = <Array<InstitutionClassModel>>data;
  		}, error=>{
  			console.log("lae class error", error);
  		});
  }

  ngOnInit(){
    this.dataSource = new StudentDataSource(this.studentDatabase, this.paginator);
    Observable.fromEvent(this.filter.nativeElement, 'keyup')
        .debounceTime(150)
        .distinctUntilChanged()
        .subscribe(() => {
          if (!this.dataSource) { return; }
          this.dataSource.filter = this.filter.nativeElement.value;
    });

    this.initAddr();

      /*   //override the onAfterAddingfile property of the uploader so it doesn't authenticate with //credentials.
     this.uploader.onAfterAddingFile = (file)=> { 
       this.setUrl();
       file.withCredentials = false; 
     };
     //overide the onCompleteItem property of the uploader so we are 
     //able to deal with the server response.
     this.uploader.onCompleteItem = (item:any, response:any, status:any, headers:any) => {
          console.log("ImageUpload:uploaded:", item, status, response);
      };
      */
  }

  fetchData(): void{
  	this.studentDatabase = new StudentDatabase(this.gProvider, "");
    this.dataSource = new StudentDataSource(this.studentDatabase, this.paginator);
  }

  updateByClasses(id: number){
    console.log("class id: ", id);

    if(id != -1){
      this.studentDatabase = new StudentDatabase(this.gProvider, "/student/all/class/" + id + "/true");
      this.dataSource = new StudentDataSource(this.studentDatabase, this.paginator);
    }else{
      this.fetchData();
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
       <body onload="window.print();window.close()">
       <div style="text-align: center">
          Institution ${this.iname}         
       </div>

       ${printContents}</body>
      </html>`
    );
    popupWin.document.close();
  }

 deleteStudent(): void{
 	this.gProvider.deleteObj(this.codeStd + "", "/student").subscribe(data=>{
 		console.log("String delete student success ...");
    	GlobalFunction.showMsgSuccess();
 	}, error=>{
 		console.log(" delete student error ...");
 	});
 }
 
  private initAddr(){

  }

  openDetailsDialog(param): void {
  	let data: any = new Object();
    console.log("test data: ", param);
    
  	Observable.forkJoin(
  		this.gProvider.getData("/lae_class/" + param.institutionClassId),	// student class
			this.gProvider.getData("/parent/" + param.parentId),				// student parent m
			this.gProvider.getData("/parent/" + param.parentFId)				// student parent f
  	).subscribe(response=>{
  			data.std = param;			//student
  			data.cls = response[0];		//class
  			data.prt = response[1];		//parent male
  			data.prtf = response[2];	//parent female	

    		let dialogRef = this.dialog.open(StudentDetailsComponent, {
		      width: '1200px',
		      height: '650px',
		      data: data
    		}); 

          /*
	        dialogRef.afterClosed().subscribe(result => {
	          console.log('The dialog was closed');
	          this.fetchData();
	        });    
          */  	
    });
  }

  openUpdateDialog(param): void {

    let data: any = new Object();

    Observable.forkJoin(
        this.gProvider.getData("/lae_class/" + param.institutionClassId),
      this.gProvider.getData("/parent/" + param.parentId),
      this.gProvider.getData("/person_ref/" + param.personRefId),
      this.gProvider.getData("/parent/" + param.parentFId)
      ).subscribe(response=>{
        data.std = param;        //student
        data.cls = response[0];      //student class
        data.prt = response[1];      //student parent male
        data.prf = response[2];      //student person ref
        data.prtf = response[3];    //parent female

        let dialogRef = this.dialog.open(StudentUpdateComponent, {
          width: '1550px',
          height: '600px',
          data: data
        });          

          dialogRef.afterClosed().subscribe(result => {
            console.log('The dialog was closed');
            this.fetchData();
          }); 

      }, error=>{
          console.log(" An error occured when execute fork join: student, class, parent, person ref, address", error);
  });  

  }

  openSanctionDialog(param): void {

    let data: any = new Object();
    data.std = param;

    let dialogRef = this.dialog.open(SanctionStdComponent, {
      width: '650px',
      height: '500px',
      data: data
    });          

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
      this.fetchData();
    }); 

  }

  openAbsenceDialog(param): void {

    let data: any = new Object();
    data.std = param;

    let dialogRef = this.dialog.open(AbsenceStdComponent, {
      width: '650px',
      height: '500px',
      data: data
    });          

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
      this.fetchData();
    }); 

  }

}

/* student database */
export class StudentDatabase {
  /** Stream that emits whenever the data has been modified. */
  dataChange: BehaviorSubject<StudentModel[]> = new BehaviorSubject<StudentModel[]>([]);
  
  get data(): StudentModel[] { 
  	return this.dataChange.value; 
  }

  constructor(private gProvider: GenericProvider, url: string){

    let urlCriteria = "/student/all/true";

    if(url.length > 0){
      urlCriteria = url;
    }

  	this.gProvider.getData(urlCriteria).subscribe(data=>{
  		console.log("data std: ", data);
  		this.dataChange.next(<Array<StudentModel>>data);
  	}, error=>{
  		console.log("data error: ", error);
  	})
  }
}


export class StudentDataSource extends DataSource<any> {
  _filterChange = new BehaviorSubject('');
    dateStart: string;
  dateEnd: string;

  get filter(): string { return this._filterChange.value; }
  set filter(filter: string) { this._filterChange.next(filter); }

  constructor(private _studentDatabase: StudentDatabase, private _paginator: MatPaginator) {
    super();
  }

  /** Connect function called by the table to retrieve one stream containing the data to render. */
  connect(): Observable<StudentModel[]> {
    const displayDataChanges = [
      this._studentDatabase.dataChange,
      this._paginator.page,
      this._filterChange,
    ];

    return Observable.merge(...displayDataChanges).map(() => {
      //const data = this._studentDatabase.data.slice();

      // Grab the page's slice of data.
      const startIndex = this._paginator.pageIndex * this._paginator.pageSize;

      //return data.splice(startIndex, this._paginator.pageSize);
      return this._studentDatabase.data.slice().filter((item: StudentModel) => {
        let searchStr = ("#" + item.studentId + item.studentFirstname + item.studentLastname).toLowerCase();
        return searchStr.indexOf(this.filter.toLowerCase()) != -1;
      });    
    });
  }

  disconnect() {}
}

@Component({
  selector: 'app-student-sanction',
  templateUrl: './student-sanction.html',
  styleUrls: ['../student.css'],
  providers: [GenericProvider, AppSettings]
})
export class SanctionStdComponent{
  ptypes: Array<PenalityTypeModel>;
  student: StudentModel;
  PenForm: FormGroup;

  constructor(private gProvider: GenericProvider,  public dialogRef: MatDialogRef<SanctionStdComponent>, private formBuilder: FormBuilder, public dialog: MatDialog, @Inject(MAT_DIALOG_DATA) private data: any){ 
    
    this.student = <StudentModel>this.data.std;
    this.gProvider.getData("/penality_type/all").subscribe(data=>{
      this.ptypes = <Array<PenalityTypeModel>>data;
      console.log("retrieve penality type success: ", data);
    }, error=>{
      console.log("retrieve penality type error: ", error);
    });

    this.PenForm = this.formBuilder.group({
        penalityTypeId:  ['', Validators.compose([Validators.required])],
        penalityDesc: ['', Validators.compose([Validators.required])],
    });

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onClickSave(): void{
    let spen: StudentPenalityModel = new StudentPenalityModel();
    spen.penalityTypeId = this.PenForm.value.penalityTypeId
    spen.studentId = this.student.studentId;
    spen.penalityDesc = this.PenForm.value.penalityDesc;
    spen.createdBy = AppSettings.DEFAULT_USER.userUsername;
    spen.dateCreated = GlobalFunction.getCurrentDate(true);
    spen.modifiedBy = "";
    spen.dateModified = GlobalFunction.getCurrentDate(true);

    this.gProvider.addObj(spen, "/penality").subscribe(data=>{
      console.log("adding penality success: ", data);
      GlobalFunction.showMsgSuccess();
      this.onNoClick();
    }, error=>{
      console.log("adding penality error: ", error);
      GlobalFunction.showMsgError();
      this.onNoClick();
    });

  }
}


@Component({
  selector: 'app-student-absence',
  templateUrl: './student-absence.html',
  styleUrls: ['./student-view.component.css'],
  providers: [GenericProvider, AppSettings]
})
export class AbsenceStdComponent{
  student: StudentModel;
  ABForm: FormGroup;

  constructor(private gProvider: GenericProvider,  public dialogRef: MatDialogRef<AbsenceStdComponent>, private formBuilder: FormBuilder, public dialog: MatDialog, @Inject(MAT_DIALOG_DATA) private data: any){ 
    
    this.student = <StudentModel>this.data.std;

    this.ABForm = this.formBuilder.group({
        absenceMotif:  ['', Validators.compose([Validators.minLength(3), Validators.maxLength(100), Validators.required])],
        absenceDetails: ['', Validators.compose([Validators.required])],
    });

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onClickSave(): void{
    let abs: StudentAbsenceModel = new StudentAbsenceModel();
    abs.studentId = this.student.studentId;
    abs.absenceMotif = this.ABForm.value.absenceMotif
    abs.absenceDetails = this.ABForm.value.absenceDetails;
    abs.createdBy = AppSettings.DEFAULT_USER.userUsername;
    abs.dateCreated = GlobalFunction.getCurrentDate(true);
    abs.modifiedBy = "";
    abs.dateModified = GlobalFunction.getCurrentDate(true);

    this.gProvider.addObj(abs, "/absence").subscribe(data=>{
      console.log("adding absence success: ", data);
      GlobalFunction.showMsgSuccess();
      this.onNoClick();
    }, error=>{
      console.log("adding absence error: ", error);
      GlobalFunction.showMsgError();
      this.onNoClick();
    });

  }
}