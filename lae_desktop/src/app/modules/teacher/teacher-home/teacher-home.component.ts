
import { Component, OnInit, ViewChild, ChangeDetectionStrategy } from '@angular/core';
import { Chart } from 'chart.js';

import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { InstitutionClassModel } from '../../../models/institution-model';
import { InstitutionModel } from '../../../models/institution-model'

@Component({
  selector: 'app-teacher-home',
  templateUrl: './teacher-home.component.html',
  styleUrls: ['../teacher.css']
})
export class TeacherHomeComponent implements OnInit {

  barChart: any;
  iclasses: Array<InstitutionClassModel>;
  labels: Array<string>;
  data: Array<number>;
  nbtch: string;
  inst: InstitutionModel;

  constructor(private gProvider: GenericProvider) { 
      this.inst = <InstitutionModel>JSON.parse(window.localStorage.getItem("INSTITUTION"));  
      
      if(this.inst == null){
        this.inst = new InstitutionModel();
      }

      this.labels = [];
      this.data = [];

      window.localStorage.setItem("EMPLOYEE_TYPE", "teacher");

      this.gProvider.getData("/teacher/count").subscribe(data=>{
        this.nbtch = data + "";
      }, error=>{
          console.log("lae class error", error);
      });
  }

  ngOnInit() {

  }

}
