import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { EmployeeHomeComponent } from './employee-home/employee-home.component';
import { EmployeeMgrComponent } from './employee-mgr/employee-mgr.component';
import { EmployeeDeleteComponent } from './employee-delete/employee-delete.component';
import { EmployeeUpdateComponent } from './employee-update/employee-update.component';
import { EmployeeAddComponent } from './employee-add/employee-add.component';
import { EmployeeViewComponent, EmployeeDetails } from './employee-view/employee-view.component';
import { EmployeePayComponent } from './employee-pay/employee-pay.component';
import { EmployeeReportComponent } from './employee-report/employee-report.component';
import { EmployeePayMgrComponent } from './employee-pay-mgr/employee-pay-mgr.component';
import { EmployeePaymentDetails, EmployeePayment, EmployeePaymentHistoric } from './employee-pay-util/employee-pay-util.component';


import { NoopAnimationsModule } from '@angular/platform-browser/animations';
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
  MatOptionModule,
  MatPaginatorModule,
  MatSelectModule,
  MatStepperModule,
  MatDatepickerModule,
  MatNativeDateModule,
  MatTooltipModule
} from '@angular/material';

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
    CdkTableModule,
    RouterModule,
    CommonModule,
    FormsModule,
    MatTooltipModule,
    ReactiveFormsModule
  ],
  declarations: [
    EmployeeHomeComponent, 
    EmployeeMgrComponent, 
    EmployeeDeleteComponent, 
    EmployeeUpdateComponent, 
    EmployeeAddComponent, 
    EmployeeViewComponent, 
    EmployeePayComponent, 
    EmployeeDetails,
    EmployeeReportComponent,
    EmployeePaymentDetails,
    EmployeePaymentHistoric,
    EmployeePayment,
    EmployeePayMgrComponent,
  ],
  entryComponents:[
    EmployeeDetails,
    EmployeeUpdateComponent,
    EmployeePaymentDetails,
    EmployeePaymentHistoric,
    EmployeePayment
  ],
  exports: [
    EmployeeViewComponent,
    EmployeeAddComponent,
    EmployeeDeleteComponent,
    EmployeePayMgrComponent
  ]
})
export class EmployeeModule { }
