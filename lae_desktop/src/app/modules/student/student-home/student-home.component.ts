
import { Component, OnInit, ViewChild, ChangeDetectionStrategy } from '@angular/core';
import { Chart } from 'chart.js';

import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { InstitutionClassModel } from '../../../models/institution-model';
import { InstitutionModel } from '../../../models/institution-model'

@Component({
  selector: 'app-student-home',
  templateUrl: './student-home.component.html',
  styleUrls: ['../student.css']
})
export class StudentHomeComponent implements OnInit {

  @ViewChild('barCanvas') barCanvas;
  barChart: any;
  iclasses: Array<InstitutionClassModel>;
  labels: Array<string>;
  data: Array<number>;
  nbstd: number;
  inst: InstitutionModel;

  constructor(private gProvider: GenericProvider) { 
      //http://localhost:8080/laepro/laepro/lae_class/nbr_student
      this.inst = <InstitutionModel>JSON.parse(window.localStorage.getItem("INSTITUTION"));
      this.labels = [];
      this.data = [];
      this.nbstd = 0;
      
      this.gProvider.getData("/lae_class/nbr_student").subscribe(data=>{
          this.iclasses = <Array<InstitutionClassModel>>data;
          for(let i = 0; i < this.iclasses.length; ++i){
            this.labels.push(this.iclasses[i].institutionClassName);
            this.data.push(this.iclasses[i].nbrStudent);
            this.nbstd += this.data[i];
          }
      }, error=>{
          console.log("lae class error", error);
      });
  }

  ngOnInit() {
    this.barChart = new Chart(this.barCanvas.nativeElement, {
      
                 type: 'bar',
                 data: {
                     labels: this.labels,
                     datasets: [{
                         label: '# ELEVES',
                         data: this.data,
                         backgroundColor: [
                             'rgba(255, 99, 132, 0.2)',
                             'rgba(54, 162, 235, 0.2)',
                             'rgba(255, 206, 86, 0.2)',
                             'rgba(75, 192, 192, 0.2)',
                             'rgba(113, 102, 255, 0.2)',
                             'rgba(153, 102, 255, 0.2)',
                             'rgba(103, 192, 255, 0.2)',
                             'rgba(153, 182, 255, 0.2)',
                             'rgba(133, 102, 255, 0.2)',
                             'rgba(193, 192, 255, 0.2)',
                            ],
                         borderColor: [
                             'rgba(255,99,132,1)',
                             'rgba(54, 162, 235, 1)',
                             'rgba(255, 206, 86, 1)',
                             'rgba(75, 192, 192, 1)',
                             'rgba(113, 102, 255, 1)',
                             'rgba(153, 102, 255, 1)',
                             'rgba(103, 192, 255, 0.2)',
                             'rgba(153, 182, 255, 0.2)',
                             'rgba(133, 102, 255, 0.2)',
                             'rgba(193, 192, 255, 0.2)',
                         ],
                         borderWidth: 1
                     }]
                 },
                 options: {
                     scales: {
                         yAxes: [{
                             ticks: {
                                 beginAtZero:true,
                                 stepSize: 1                                 
                             }
                         }]
                     }
                 }
      
             });
  }

}
