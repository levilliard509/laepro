
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { DefaultViewComponent } from './default-view/default-view.component';

import { StudentHomeComponent } from '../student/student-home/student-home.component';
import { StudentPayComponent } from '../student/student-pay/student-pay.component';
import { StudentAddComponent } from '../student/student-add/student-add.component';
import { StudentUpdateComponent } from '../student/student-update/student-update.component';
import { StudentViewComponent } from '../student/student-view/student-view.component';
import { StudentReportComponent } from '../student/student-report/student-report.component';
import { StudentMgrComponent } from '../student/student-mgr/student-mgr.component';

export const HomeRoutes: Routes = [
   {
    	path: 'home',
    	component: HomeComponent,
    	children:[
    		{
    			path: "view",
    			component: DefaultViewComponent,
    			outlet: "default"
            },
            {
                path: 'student',
                component: StudentHomeComponent,
                outlet: 'std'
            }
            ]
    }];
