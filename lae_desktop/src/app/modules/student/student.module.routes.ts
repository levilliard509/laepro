
/*

student----->|
             |-->home

*/

import { Routes, RouterModule } from '@angular/router';
import { StudentHomeComponent } from './student-home/student-home.component';
import { StudentPayComponent } from './student-pay/student-pay.component';
import { StudentReportComponent } from './student-report/student-report.component';
import { StudentMgrComponent } from './student-mgr/student-mgr.component';

export const StudentRoutes: Routes = [
   {
    	path: 'student',
    	component: StudentHomeComponent,
    
    	children:[
            {
                path: "pay",
                component: StudentPayComponent,
                outlet: "stdroute",
            },

            {
                path: "report",
                component: StudentReportComponent,
                outlet: "stdroute"
            },

            {
                path: "mgr",
                component: StudentMgrComponent,
                outlet: "stdroute"
            }]
         },
      
        {
            path: '',
            component: StudentHomeComponent,
            pathMatch: 'full',
        }
    ];
