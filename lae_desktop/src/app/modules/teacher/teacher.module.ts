
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { RouterModule } from '@angular/router';
import { HttpModule } from '@angular/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';

import { TeacherHomeComponent } from './teacher-home/teacher-home.component';
import { TeacherMgrComponent } from './teacher-mgr/teacher-mgr.component';
import { TeacherReportComponent } from './teacher-report/teacher-report.component';
import { TeacherViewComponent } from './teacher-view/teacher-view.component';
import { TeacherAddComponent } from './teacher-add/teacher-add.component';
import { TeacherDeleteComponent } from './teacher-delete/teacher-delete.component';
import { TeacherUpdateComponent } from './teacher-update/teacher-update.component';
import { TeacherPayComponent } from './teacher-pay/teacher-pay.component';

import { NoopAnimationsModule } from '@angular/platform-browser/animations';
import { CdkTableModule } from '@angular/cdk/table';
import { FileUploadModule } from 'ng2-file-upload';

import { EmployeeModule } from '../employee/employee.module';
import { TeacherCourseMgrComponent } from './teacher-course-mgr/teacher-course-mgr.component';
import { CourseCUDDialog } from './teacher-course/teacher-course.component';

import { 
  MatMenuModule, 
  MatDialogModule,
  MatFormFieldModule, 
  MatInputModule, 
  MatButtonModule, 
  MatCardModule, 
  MatToolbarModule, 
  MatIconModule,
  MatGridListModule,
  MatTabsModule,
  MatSidenavModule,
  MatListModule,
  MatCheckboxModule,
  MatRadioModule,
  MatTableModule,
  MatPaginatorModule,
  MatOptionModule,
  MatSelectModule,
  MatStepperModule,
  MatDatepickerModule,
  MatNativeDateModule
} from '@angular/material';
import { TeacherCourseComponent } from './teacher-course/teacher-course.component';

@NgModule({
  imports: [
    MatMenuModule, 
    MatDialogModule,
    MatFormFieldModule, 
    MatInputModule, 
    MatButtonModule, 
    MatCardModule, 
    MatToolbarModule, 
    MatIconModule,
    MatGridListModule,
    MatTabsModule,
    MatSidenavModule,
    MatListModule,
    MatCheckboxModule,
    MatRadioModule,
    MatTableModule,
    MatPaginatorModule,
    MatOptionModule,
    MatSelectModule,
    MatStepperModule,
    MatDatepickerModule,
    MatNativeDateModule,
    RouterModule,
    CdkTableModule,
    CommonModule,
    FormsModule, 
    ReactiveFormsModule,
    EmployeeModule,
  ],
  declarations: [
    TeacherHomeComponent, 
    TeacherMgrComponent, 
    TeacherReportComponent, 
    TeacherViewComponent, 
    TeacherAddComponent, 
    TeacherDeleteComponent, 
    TeacherUpdateComponent, 
    TeacherPayComponent, 
    CourseCUDDialog,
    TeacherCourseMgrComponent, 
    TeacherCourseComponent
  ],
  entryComponents: [
    CourseCUDDialog,
  ]
})
export class TeacherModule { }
