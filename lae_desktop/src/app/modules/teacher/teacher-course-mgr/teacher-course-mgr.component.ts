
import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';

import { EmployeeModel } from '../../../models/institution-model';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';

@Component({
  selector: 'teacher-course-mgr',
  templateUrl: './teacher-course-mgr.component.html',
  styleUrls: ['./teacher-course-mgr.component.css']
})
export class TeacherCourseMgrComponent implements OnInit {
  isLinear = false;
  firstFormGroup: FormGroup;
  emp: EmployeeModel;
  isFound: boolean = false;
  code: any;
  result: string = "Non Fait !";

  constructor(private _formBuilder: FormBuilder, private gProvider: GenericProvider) { 
    this.emp = new EmployeeModel();
  }

  ngOnInit() {
    this.firstFormGroup = this._formBuilder.group({
      stdCode: ['', Validators.required]
    });
  }

  
  setStd(){
    this.code = this.firstFormGroup.value.stdCode;
    
    if(this.code != null && this.code.length > 0){
      this.gProvider.getData("/employee/delete/" + this.code).subscribe(data=>{
        let obj: Object = data
        this.emp = <EmployeeModel>obj;        
        if(this.emp != null){
          AppSettings.EMPLOYEE_ID = this.emp.employeeId;
          this.result = this.emp.employeeLastname + " " + this.emp.employeeFirstname + ", " + this.emp.employeeFunction;
          this.isFound = true;
        }
        
        console.log("show emp: ", data);
      }, error=>{
        this.emp = new EmployeeModel();
        console.log("Error:", error);
      });
    }
  }
  
  deleteEmp(){

  }

  resetForms(){
    this.firstFormGroup.reset();
  }
}

