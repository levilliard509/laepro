import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { AppSettings } from '../../../providers/app-settings';

@Component({
  selector: 'app-employee-mgr',
  templateUrl: './employee-mgr.component.html',
  styleUrls: ['../employee.css']
})
export class EmployeeMgrComponent implements OnInit {

  constructor(private router: Router){ 

  }
  ngOnInit() {
  }

  goToRefresh(){
    if(AppSettings.EMPLOYEE_TYPE == 'teacher'){
      this.router.navigate(["/home:tch_mgr"]);
    }else{
      this.router.navigate(["/home:emp_mgr"]);
    }
  }
}
