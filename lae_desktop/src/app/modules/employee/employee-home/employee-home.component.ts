
import { Component, OnInit, ViewChild, ChangeDetectionStrategy } from '@angular/core';
import { Chart } from 'chart.js';

import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { InstitutionClassModel } from '../../../models/institution-model';
import { InstitutionModel } from '../../../models/institution-model'

@Component({
  selector: 'app-employee-home',
  templateUrl: './employee-home.component.html',
  styleUrls: ['../employee.css']
})
export class EmployeeHomeComponent implements OnInit {
  data: any;
  inst: InstitutionModel;

  constructor(private gProvider: GenericProvider) { 
      this.inst = <InstitutionModel>JSON.parse(window.localStorage.getItem("INSTITUTION"));    

      window.localStorage.setItem("EMPLOYEE_TYPE", "smallstaff");

      this.gProvider.getData("/employee/count").subscribe(data=>{
         this.data = data;
      }, error=>{
          console.log("lae class error", error);
      });
  }

  ngOnInit() {
  }

}
