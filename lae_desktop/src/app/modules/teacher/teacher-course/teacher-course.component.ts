import { Component, OnInit, Input } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { Inject } from '@angular/core';

import { Course, ClassCourse } from '../../../models/institution-model';
import { FormBuilder, FormGroup, Validators} from '@angular/forms';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';

@Component({
  selector: 'teacher-course',
  templateUrl: './teacher-course.component.html',
  styleUrls: ['./teacher-course.component.css']
})
export class TeacherCourseComponent implements OnInit {

  @Input("teacherId") teacherId;

  cls_courses: any;

  constructor(
    private gProvider: GenericProvider,
    private dialog: MatDialog
  ){ 
  }

  ngOnInit() {
    console.log("teacher id: ", this.teacherId);
    this.fetchData();
  }

  private fetchData(){
    if(this.teacherId != 0 && this.teacherId != null){
      this.gProvider.getData("/class_course/teacher/" + this.teacherId).subscribe(data=>{
        console.log("class courses data: ", data);
        this.cls_courses = data;
      }, error=>{
        console.log("class course error: ", error);
      })
    }
  }

  convertToNormalDate(dt: any){
    return new Date(dt).toDateString();
  }


  openCUDDialog(): void {
    let dialogRef = this.dialog.open(CourseCUDDialog, {
      width: '450px',
      height: '400px',
      data: this.teacherId
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
      this.fetchData();
    });
  }

  deleteCourse(id: number){
    this.gProvider.deleteObj(id + "", "/class_course").subscribe(data=>{
      console.log("on delete class course success");
    }, error=>{
      console.log("on delete class course error");
    });

    setTimeout(()=>{
      this.fetchData();
    }, 5000);
  }
}

@Component({
  selector: 'teacher-course-cud',
  templateUrl: './teacher-course-cud.html',
  styleUrls: ['../teacher.css']
})
export class CourseCUDDialog implements OnInit{
  CourseForm: FormGroup;
  courses: Array<Course>;
  cId: number = 0;

  constructor(public dialogRef: MatDialogRef<CourseCUDDialog>, private formBuilder: FormBuilder, private gProvider: GenericProvider, @Inject(MAT_DIALOG_DATA) public data: any){
    this.CourseForm = this.formBuilder.group({
      courseId:['', Validators.required],
      //institutionClassId:['', Validators.required],
      dateStart:['', Validators.required],
      dateEnd:['', Validators.required],
      classCourseDetails:['', Validators.compose([Validators.minLength(3), Validators.maxLength(200), Validators.required])],
    });

    // if(this.isDelete){
    //   this.CourseForm.setValue( {
    //     "courseId": this.classc.courseId,
    //     //"institutionClassId": this.classc.institutionClassId,
    //     "dateStart": this.classc.dateStart,
    //     "dateEnd": this.classc.dateEnd,
    //     "classCourseDetails": this.classc.classCourseDetails
    //   });  
    // }
  }

  ngOnInit(){
    console.log(" with teacher id: ", this.data);

    this.gProvider.getData("/course/all/1").subscribe(data=>{
      this.courses = <Array<Course>>data;
      console.log("course data found: ", data);
    }, error=>{
      console.log(" get all course data error: ", error);
    })
  }

  selectCourse(obj: Course){
    this.cId = obj.institutionClassId;
  }


  onClickSave(): void{

    if(this.cId <=0 || this.data == null){
      alert("Une erreur s'est produite !");
      return;
    }

    let obj: ClassCourse = <ClassCourse>this.CourseForm.value;
    obj.teacherId = this.data;
    obj.institutionClassId = this.cId;
    obj.createdBy = AppSettings.DEFAULT_USER.userUsername;
    obj.dateCreated = new Date().getTime() + "";
    obj.dateStart = new Date(Date.parse(obj.dateStart)).toISOString().split("T")[0];
    obj.dateEnd = new Date(Date.parse(obj.dateEnd)).toISOString().split("T")[0];
        
    this.gProvider.addObj(obj, "/class_course").subscribe(data=>{
      console.log("course class add");
      this.onNoClick();
    }, error=>{
      console.log("course class error: ", error);
      this.onNoClick();
    })	;
	}
  onNoClick(): void {
    this.dialogRef.close();
  }
}