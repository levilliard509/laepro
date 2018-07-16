import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { SecurityRoutes } from './security/security.routes';
import { HomeRoutes } from './modules/home/home.module.routes';
import { StudentRoutes } from './modules/student/student.module.routes';

/* security component */
import { LoginComponent } from './security/login/login.component';

/* home component */
import { HomeComponent } from './modules/home/home/home.component';
import { DefaultViewComponent } from './modules/home/default-view/default-view.component';

/* student component */
import { StudentHomeComponent } from './modules/student/student-home/student-home.component';
import { StudentPayComponent } from './modules/student/student-pay/student-pay.component';
import { StudentReportComponent } from './modules/student/student-report/student-report.component';
import { StudentMgrComponent } from './modules/student/student-mgr/student-mgr.component';

/* teacher component */
import { TeacherHomeComponent } from './modules/teacher/teacher-home/teacher-home.component';
import { TeacherMgrComponent } from './modules/teacher/teacher-mgr/teacher-mgr.component';
import { TeacherReportComponent } from './modules/teacher/teacher-report/teacher-report.component';
import { TeacherPayComponent } from './modules/teacher/teacher-pay/teacher-pay.component';

/* employee component */
import { EmployeeHomeComponent } from './modules/employee/employee-home/employee-home.component';
import { EmployeeViewComponent } from './modules/employee/employee-view/employee-view.component';
import { EmployeeMgrComponent } from './modules/employee/employee-mgr/employee-mgr.component';
import { EmployeePayComponent } from './modules/employee/employee-pay/employee-pay.component';
import { EmployeeReportComponent } from './modules/employee/employee-report/employee-report.component';

/* user component */
import { UserComponent } from './modules/user/user/user.component';

/* param component */
import { ParamMgrComponent } from './modules/param/param-mgr/param-mgr.component'

//securitycomponent
import { AuthGuard } from './security/guards/guards.component';

export const appRoutes: Routes = [
    {
        path: 'login',
        component: LoginComponent,
    },
    {
        path: 'home',
        component: HomeComponent, children: [
           //home menu
            {
                path: 'std',
                component: StudentHomeComponent,
                outlet: 'home',
            },

            {
                path: 'tch',
                component: TeacherHomeComponent,
                outlet: 'home'
            },

            {
              path: 'emp',
              component: EmployeeHomeComponent,
              outlet: 'home'
            },      
          
            {
              path: 'usr',
              component: UserComponent,
              canActivate: [AuthGuard],
              outlet: 'home'
            },

            {
              path: 'param',
              component: ParamMgrComponent,
              canActivate: [AuthGuard],
              outlet: 'home'
            },  

            {
              path: '',
              component: DefaultViewComponent,
              outlet: 'home'
            },

            //student menu
            {
              path: "std_home",
              component: StudentHomeComponent,
              outlet: "home"
            },

            {
              path: "std_mgr",
              component: StudentMgrComponent,
              outlet: "home"
            },            

            {
              path: "std_pay",
              component: StudentPayComponent,
              outlet: "home"
            },

            {
              path: "std_report",
              component: StudentReportComponent,
              outlet: "home"
            },

            //teacher menu
            {
              path: "tch_home",
              component: TeacherHomeComponent,
              outlet: "home"
            },

            {
              path: "tch_mgr",
              component: TeacherMgrComponent,
              outlet: "home"
            },            

            {
              path: "tch_pay",
              component: TeacherPayComponent,
              outlet: "home"
            },

            {
              path: "tch_report",
              component: TeacherReportComponent,
              outlet: "home"
            },

            //employee[small staff, teacher, admin] menu
            {
              path: "emp_home",
              component: EmployeeHomeComponent,
              outlet: "home"
            },

            {
              path: "emp_mgr",
              component: EmployeeMgrComponent,
              outlet: "home"
            },            

            {
              path: "emp_pay",
              component: EmployeePayComponent,
              outlet: "home"
            },

            {
              path: "emp_report",
              component: EmployeeReportComponent,
              outlet: "home"
            }
        ]
    },

    { path: '', redirectTo: '/login', pathMatch: 'full' },
    
];
