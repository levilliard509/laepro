
import { Component, OnInit } from '@angular/core';
import { Inject} from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { GlobalFunction } from '../../../global/global';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';

import { ElementRef, ViewChild, Input} from '@angular/core';
import { DataSource } from '@angular/cdk/collections';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';
import { Observable } from 'rxjs/Observable';

import 'rxjs/add/operator/startWith';
import 'rxjs/add/observable/merge';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/debounceTime';
import 'rxjs/add/operator/distinctUntilChanged';
import 'rxjs/add/observable/fromEvent';

import { InstitutionClassModel, Course, Periode } from '../../../models/institution-model';

@Component({
  selector: 'course',
  templateUrl: './course.component.html',
  styleUrls: ['./course.component.css']
})
export class CourseComponent implements OnInit{   

  displayedColumns = ['Niveau', 'Titre', 'Periode', 'NbrHeures', 'Description', 'Update', 'Delete'];
  courseDatabase = new CourseDatabase(this.gProvider, this.data.institutionClassId);
  dataSource: CourseDataSource | null;
  CourseForm: FormGroup;
  @ViewChild('filter') filter: ElementRef;
  clas: InstitutionClassModel;
  isAdd: boolean;
  periodes: Array<Periode>
  courseList: Array<Course>;

  constructor(
    public dialogRef: MatDialogRef<CourseComponent>, 
    private formBuilder: FormBuilder, 
    private gProvider: GenericProvider, 
    public dialog: MatDialog,
    @Inject(MAT_DIALOG_DATA) public data: any){

    this.clas = this.data;
    this.isAdd = false;

    this.CourseForm = this.formBuilder.group({
      periodeId: ['', Validators.compose([Validators.required])],
      courseLevel: ['', Validators.compose([Validators.required])],
      courseTitle: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(100), Validators.required])],
      courseCreditHours: ['', Validators.required],
      courseDesc: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(400), Validators.required])],
    });
    
    //init periodes array
    this.periodes = [];
    
    this.gProvider.getData("/periode/all").subscribe(data=>{
      console.log("periode data: ", data);
      this.periodes = <Array<Periode>>data;
      if(this.periodes.length <= 0){
        alert("Il faut d'abord ajouter les periodes de cours dans l'enregistrement de l'institution !");
      }
    }, error=>{
      console.log("data periode error: ", error);
      alert("Il faut d'abord ajouter les periodes de cours dans l'enregistrement de l'institution !");
    });
  }

  fetchData(): void {
    this.courseDatabase = new CourseDatabase(this.gProvider, this.clas.institutionClassId);
    this.dataSource = new CourseDataSource(this.courseDatabase);
  }

  ngOnInit() {
    this.dataSource = new CourseDataSource(this.courseDatabase);

    this.courseDatabase.dataChange.subscribe(
      (x)=>{
        if(x.length > 0){
          this.courseList = x;
        }
      }, error=>{
        console.log("Error: ", error);
    })

    Observable.fromEvent(this.filter.nativeElement, 'keyup')
      .debounceTime(150)
      .distinctUntilChanged()
      .subscribe(() => {
        if (!this.dataSource) { return; }
        this.dataSource.filter = this.filter.nativeElement.value;
      });
  }

  getPeriode(obj: Course){

    let pname = "";

    if(this.periodes != null && this.periodes.length <= 0){
      return pname;
    }

    for(let i = 0; i != this.periodes.length; ++i){
      if(this.periodes[i].periodeId == obj.periodeId){
        pname = this.periodes[i].periodeName;
        break;
      }
    }

    return pname;
  }

  showAdd(){

    if(this.courseList != null && this.courseList.length > 0){
      this.CourseForm.setValue( {
        "periodeId": "",
        "courseLevel": "",
        "courseTitle": "",
        "courseCreditHours": "",
        "courseDesc": ""
      });  
    }

    this.isAdd = ! this.isAdd;
  }

  onClickSave(): void{
    let obj2: Course = new Course();
    obj2 = <Course>this.CourseForm.value;
    obj2.institutionClassId = this.clas.institutionClassId;
    obj2.createdBy = AppSettings.DEFAULT_USER.userUsername;
    obj2.dateCreated = new Date().getTime() + "";

    console.log("on adding course: ", obj2);

    this.gProvider.addObj(obj2, "/course").subscribe(data=>{
      console.log("course add");
      this.onNoClick();
      GlobalFunction.showMsgSuccess();
    }, error=>{
      console.log("course add error: ", error);
      GlobalFunction.showMsgError();
      this.onNoClick();
    })        
  }
  
  validateCourse(course: number): boolean{
    let good: boolean = true;

    return good;
  }

  openDeleteDialog(data: Object): void {

  }

  openUpdateDialog(obj): void {
    let data: any = {};
    data.course = obj;
    data.periodes = this.periodes;

    let dialogRef = this.dialog.open(CourseUpdateDialog, {
      width: "700px",
      height: "400px",
      data: data
    });
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  deleteCourse(obj: Course){

    for(let i = 0; i <this.courseList.length; ++i){
      if(obj.periodeId < this.courseList[this.courseList.length - 1].periodeId){
        alert("Vous pouvez seulement supprimer le dernier enregistrement");
        return ;
      }
    }

    this.gProvider.deleteObj(obj.courseId + "", "/course").subscribe((data)=>{
      console.log("Delete Object success: ",  data);
      GlobalFunction.showMsgSuccess();
      this.onNoClick();
    },error=>{
      console.log("Delete Object error: ",  error);
      GlobalFunction.showMsgError();
    });
  }

}

export class CourseDatabase {
  dataChange: BehaviorSubject<Course[]> = new BehaviorSubject<Course[]>([]);

  get data(): Course[]{
    return this.dataChange.value;
  }

  constructor(private gProvider: GenericProvider, id:number) {
    this.gProvider.getData("/course/all/" + id).subscribe(data => {
      console.log("data course: ", data);
      this.dataChange.next(<Array<Course>>data);
    }, error => {
      console.log("data error: ", error);
    });
  }
}

export class CourseDataSource extends DataSource<any> {
  _filterChange = new BehaviorSubject('');
  get filter(): string { return this._filterChange.value; }
  set filter(filter: string) { this._filterChange.next(filter); }

  constructor(private _courseDatabase: CourseDatabase) {
    super();
  }

  /** Connect function called by the table to retrieve one stream containing the data to render. */
  connect(): Observable<Course[]> {
    const displayDataChanges = [
      this._courseDatabase.dataChange,
      this._filterChange,
    ];

    return Observable.merge(...displayDataChanges).map(() => {
      return this._courseDatabase.data.slice().filter((item: Course) => {
        let searchStr = (item.courseTitle).toLowerCase();
        return searchStr.indexOf(this.filter.toLowerCase()) != -1;
      });
    });
  }

  disconnect() { }
}


@Component({
  selector: 'course-update',
  templateUrl: './course.update.html',
  styleUrls: ['./course.component.css']
})
export class CourseUpdateDialog implements OnInit{

  course: Course;
  periodes: Array<Periode>;

  CourseForm: FormGroup;
  isDelete: boolean;
  isDetails: boolean;

  constructor(public dialogRef: MatDialogRef<CourseUpdateDialog>, private formBuilder: FormBuilder, private gProvider: GenericProvider, @Inject(MAT_DIALOG_DATA) public data: any){

  this.course = this.data.course;
  this.periodes = this.data.periodes;

  this.CourseForm = this.formBuilder.group({
    periodeId: ['', Validators.compose([Validators.required])],
    courseLevel: ['', Validators.compose([Validators.required])],
    courseTitle: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(100), Validators.required])],
    courseCreditHours: ['', Validators.required],
    courseDesc: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(400), Validators.required])],
  });
  
  this.CourseForm.setValue( {
    "periodeId": this.course.periodeId,
    "courseLevel": this.course.courseLevel,
    "courseTitle": this.course.courseTitle,
    "courseCreditHours": this.course.courseCreditHours,
    "courseDesc": this.course.courseDesc
  });  
  }

  ngOnInit(){
  }

  onClickSave(): void{
    let obj: Course = new Course();
    obj = <Course>this.CourseForm.value;

    obj.courseId = this.course.courseId;
    obj.institutionClassId = this.course.institutionClassId;
    obj.createdBy = this.course.createdBy;
    obj.modifiedBy = this.course.modifiedBy;
    
    obj.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    obj.modifiedBy = new Date().getTime() + "";
    
    console.log("on update course: ", obj);

    this.gProvider.update(obj, "/course").subscribe(data=>{
      console.log("course update");
      this.onNoClick();
      GlobalFunction.showMsgSuccess();
    }, error=>{
      console.log("course update error: ", error);

      GlobalFunction.showMsgError();
      this.onNoClick();
    })	;
	}

  onNoClick(): void {
    this.dialogRef.close();
  }

}