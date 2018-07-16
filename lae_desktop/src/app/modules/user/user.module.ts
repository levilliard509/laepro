
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { UserComponent, DialogUserUpdateDialog } from './user/user.component';

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
    CommonModule,
    ReactiveFormsModule,
    FormsModule
  ],
  declarations: [UserComponent, DialogUserUpdateDialog],
  entryComponents: [
    DialogUserUpdateDialog
  ]
})
export class UserModule { }
