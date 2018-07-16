

import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';

import { StudentModel } from '../../../models/student-model';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';


@Component({
  selector: 'student-delete',
  templateUrl: './student-delete.component.html',
  styleUrls: ['./student-delete.component.css']
})
export class StudentDeleteComponent implements OnInit {
  isLinear = false;
  firstFormGroup: FormGroup;
  secondFormGroup: FormGroup;
  std: StudentModel;
  code: any;
  result: string = "Non Fait !";

  constructor(private _formBuilder: FormBuilder, private gProvider: GenericProvider) { 

  }

  ngOnInit() {
    this.firstFormGroup = this._formBuilder.group({
      stdCode: ['', Validators.required]
    });

    this.secondFormGroup = this._formBuilder.group({
      stdName: ['', Validators.required],
    });
  }

  setStd(){
    this.code = this.firstFormGroup.value.stdCode;

    if(this.code != null && this.code.length > 0){
      this.gProvider.getData("/student/" + this.code).subscribe(data=>{
        let obj: Object = data
        this.std = <StudentModel>obj;
        if(this.std != null){
          this.secondFormGroup.patchValue({"stdName": this.std.studentFirstname + " " + this.std.studentLastname});
        }
      }, error=>{
        console.log("Error:", error);
      })
      
    }
  }
  
  deleteStd(){
    this.result = "Fait !";
    this.gProvider.deleteObj(this.firstFormGroup.value.stdCode, "/student").subscribe(data=>{
      console.log("delete std: ", data);
    }, error=>{
      console.log("delete error: ", error);
    })
  }

  resetForm(){
    this.firstFormGroup.reset();
    this.secondFormGroup.reset();
  }
}
