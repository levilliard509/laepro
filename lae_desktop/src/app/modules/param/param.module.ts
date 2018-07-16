import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { ParamMgrComponent } from './param-mgr/param-mgr.component';
import { StudentPenalityComponent, DialogUpdatePenalityType } from './penality/penality.component';
import { InstitutionComponent, PeriodeComponent } from './institution/institution.component';
import { ClassDefComponent, DialogMgrDialog } from './class-def/class-def.component';
import { PaymentPeriodeComponent, PayUpdateDialog } from './payment-periode/payment-periode.component';
import { CourseComponent, CourseUpdateDialog } from './course/course.component';
import { ClassMgrComponent } from './class-mgr/class-mgr.component';

import { StudentModule } from '../student/student.module';

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
  MatExpansionModule,
  MatNativeDateModule,
} from '@angular/material';

@NgModule({
  imports: [
    MatMenuModule, 
    MatExpansionModule,
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
    MatButtonModule,
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
    RouterModule,
    StudentModule
  ],
  declarations: [
    ParamMgrComponent, 
    StudentPenalityComponent, 
    DialogUpdatePenalityType, 
    InstitutionComponent, 
    ClassDefComponent, 
    DialogMgrDialog, 
    PaymentPeriodeComponent, 
    PeriodeComponent,
    ClassMgrComponent,
    PayUpdateDialog,
    CourseUpdateDialog,
    CourseComponent
  ],
  entryComponents: [
    DialogUpdatePenalityType, 
    DialogMgrDialog,
    PayUpdateDialog,
    CourseUpdateDialog,
    PeriodeComponent,
    CourseComponent,
    PaymentPeriodeComponent
  ], 
})
export class ParamModule { }
