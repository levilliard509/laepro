import { Component, OnInit } from '@angular/core';
import { GenericProvider } from '../../../providers/generic';
import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';
import 'rxjs/add/observable/forkJoin';

import { Counter } from '../../../models/institution-model';
import { AppSettings } from '../../../providers/app-settings';

@Component({
  selector: 'app-default-view',
  templateUrl: './default-view.component.html',
  styleUrls: ['./default-view.component.css']
})
export class DefaultViewComponent implements OnInit {
  count: Counter;

  constructor(private gProvider: GenericProvider) {

  }

  getCount(): void{
    this.count = new Counter();

    Observable.forkJoin(
      this.gProvider.getData("/student/count"), 
      this.gProvider.getData("/teacher/count"), 
      this.gProvider.getData("/employee/count")).subscribe(response=>{
        this.count.stdCounter = parseInt(response[0].toString());
        this.count.tchCounter = parseInt(response[1].toString());
        this.count.empCounter = parseInt(response[2].toString()); 
        AppSettings.count = this.count.empCounter;
    }, error=>{
        console.log("error count data: ", error);
    });
  }

  ngOnInit(){
    this.getCount();
  }

}
