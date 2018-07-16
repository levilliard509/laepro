import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';
import { RouterModule, Routes } from '@angular/router';

import { SecurityModule } from './security/security.module';
import { HomeModule } from './modules/home/home.module';
import { StudentModule } from './modules/student/student.module';
import { EmployeeModule } from './modules/employee/employee.module';
import { TeacherModule } from './modules/teacher/teacher.module';
import { UserModule } from './modules/user/user.module';
import { ParamModule } from './modules/param/param.module';

import { appRoutes } from './app-routing.module';

import { AppComponent } from './app.component';
import { DateAdapter, NativeDateAdapter, MAT_DATE_FORMATS } from '@angular/material/core';

export class AppDateAdapter extends NativeDateAdapter {

  format(date: Date, displayFormat: Object): string {

      if (displayFormat === 'input') {
          return date.toISOString().split("T")[0];
      } else {
          return date.toDateString();
      }
  }
}

export const APP_DATE_FORMATS =
{
    parse: {
        dateInput: { month: 'short', year: 'numeric', day: 'numeric' },
    },
    display: {
        dateInput: 'input',
        monthYearLabel: { year: 'numeric', month: 'numeric' },
        dateA11yLabel: { year: 'numeric', month: 'long', day: 'numeric' },
        monthYearA11yLabel: { year: 'numeric', month: 'long' },
    }
};

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
	NoopAnimationsModule,
    SecurityModule,
    StudentModule,
    TeacherModule,
    EmployeeModule,
    HomeModule,
    UserModule,
    ParamModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [
    {
        provide: DateAdapter, useClass: AppDateAdapter
    },
    {
        provide: MAT_DATE_FORMATS, useValue: APP_DATE_FORMATS
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
