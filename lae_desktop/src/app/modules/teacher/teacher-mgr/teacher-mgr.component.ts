
import { Component, OnInit } from '@angular/core';
import { InstitutionModel } from '../../../models/institution-model';
import { MatTabChangeEvent } from '@angular/material';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-teacher-mgr',
  templateUrl: './teacher-mgr.component.html',
  styleUrls: ['../teacher.css']
})
export class TeacherMgrComponent implements OnInit {

  constructor(private route: ActivatedRoute, private router: Router) {
    //let obj: Object = localStorage.getItem("INSTITUTION_DATA");
    //let inst:InstitutionModel  = <InstitutionModel>obj;
    console.log("Inst obj convert: ", window.localStorage.getItem("INSTITUTION_DATA"));
  }

  ngOnInit() {

  }


  onTabClick(event: MatTabChangeEvent) {
    /*
    console.log('event => ', event);
    console.log('index => ', event.index);
    console.log('tab => ', event.tab);
    */

    if(event.index == 0){
      this.router.navigate(['/home', {outlets: {'home': ['tch_mgr']}}]);
    }
  }

}
