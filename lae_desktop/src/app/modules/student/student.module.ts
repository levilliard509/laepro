/*
  -------------------------------------------------------
*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { HttpModule } from '@angular/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';

import { HomeModule } from '../../modules/home/home.module';
import { StudentHomeComponent } from './student-home/student-home.component';
import { StudentPayComponent, StdPaymentDetails, StdPaymentHistoric, StdPayment } from './student-pay/student-pay.component';
import { StudentAddComponent } from './student-add/student-add.component';
import { StudentUpdateComponent } from './student-update/student-update.component';
import { StudentViewComponent, SanctionStdComponent, AbsenceStdComponent } from './student-view/student-view.component';
import { StudentReportComponent, StudentReportPenality, StudentReportAbsence } from './student-report/student-report.component';
import { StudentMgrComponent } from './student-mgr/student-mgr.component';
import { StudentDetailsComponent } from './student-details/student-details.component';
import { StudentDeleteComponent } from './student-delete/student-delete.component';
import { StudentSearchComponent } from './student-search/student-search.component';

import { CdkTableModule } from '@angular/cdk/table';
import { FileUploadModule } from 'ng2-file-upload';

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
  MatTooltipModule,
  MatNativeDateModule
} from '@angular/material';


@NgModule({
  imports: [
    MatMenuModule, 
    MatSelectModule,
    MatNativeDateModule,
    MatDatepickerModule,
    MatOptionModule,
    MatPaginatorModule,
    RouterModule,
    BrowserModule,
    MatFormFieldModule, 
    HttpModule,
    MatInputModule, 
    MatButtonModule, 
    MatCardModule, 
    MatToolbarModule, 
    MatIconModule,
    MatGridListModule,
    MatTabsModule,
    MatSidenavModule,
    MatDialogModule,
    MatListModule,
    MatCheckboxModule,
    MatRadioModule,
    CdkTableModule,
    FileUploadModule,
    CommonModule,
    RouterModule,
    BrowserModule,
    HttpModule,
    FormsModule,
    MatTableModule,
    ReactiveFormsModule,
    MatStepperModule,
    MatTooltipModule,
    HomeModule,
  ],
  declarations: [
  	StudentHomeComponent, 
  	StudentPayComponent, 
  	StudentAddComponent, 
  	StudentUpdateComponent, 
  	StudentViewComponent, 
    StudentReportComponent, 
    StudentMgrComponent, 
    StudentDetailsComponent,
    StudentDetailsComponent,
    StudentDeleteComponent,
    SanctionStdComponent,
    AbsenceStdComponent,
    StdPaymentDetails,
    StdPaymentHistoric,
    StdPayment,
    StudentReportPenality,
    StudentReportAbsence,
    StudentSearchComponent
  ],
  entryComponents:[
    StudentDetailsComponent,
    StudentUpdateComponent,
    SanctionStdComponent,
    AbsenceStdComponent,
    StdPaymentDetails,
    StdPaymentHistoric,
    StdPayment,
    StudentReportAbsence,
    StudentReportPenality
  ],
  exports: [StudentSearchComponent]
})
export class StudentModule { }
