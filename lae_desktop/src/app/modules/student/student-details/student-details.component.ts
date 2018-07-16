
import { Inject, Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';

import { StudentModel } from '../../../models/student-model';
import { ParentModel } from '../../../models/parent-model';
import { AddressModel } from '../../../models/address-model';
import { InstitutionClassModel } from '../../../models/institution-model';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { InstitutionModel } from '../../../models/institution-model';

@Component({
  selector: 'student-details',
  templateUrl: './student-details.component.html',
  styleUrls: ['./student-details.component.css']
})

export class StudentDetailsComponent implements OnInit {
  
  std: StudentModel;
  cls: InstitutionClassModel;
  prt: ParentModel;
  prtf: ParentModel;
  adr: AddressModel;
  ins: InstitutionModel;
  imgUrl: string = "";

  constructor(
    @Inject(MAT_DIALOG_DATA) public data: any, 
    private gProvider: GenericProvider, 
    public dialogRef: MatDialogRef<StudentDetailsComponent>,
    ) { 
    console.clear();
  	
    this.std = this.data.std;
    this.cls = this.data.cls;
    this.prt = this.data.prt;
    this.adr = this.data.adr;
    this.prtf = this.data.prtf;
    this.ins = AppSettings.INSTITUTION;
    this.imgUrl = AppSettings.URL_BASE + "/file/download/students/" + this.std.studentId + "?" + new Date();
  }

  ngOnInit(){

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  printStd(): void {
    let printContents, popupWin;
    printContents = document.getElementById('print-section').innerHTML;
    popupWin = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
    popupWin.document.open();
    popupWin.document.write(`
      <html>
        <head>
          <title> Information sur l'eleve: ${this.std.studentFirstname} ${this.std.studentLastname}</title>
          <link href="student-details.component.css" rel="stylesheet">

          <style>
          .header-info{
            padding: 5px 40px;
            background: #eee;
            margin: 20px 10px 0;
          }


          .header-info{
            padding: 5px 40px;
            background: #263238;
            margin: 20px 10px 0;
            color: #fff;
            width: 100%;
          }



          .lab {
            padding: 10px 4px;
            color: #555;
            margin-left: 20px;
          }

          table td, table td * {
              vertical-align: top;
          }

          .hidd{
            height: 50px;
          }         
		</style>
        </head>
       <body onload="window.print();window.close()">
          <div style="text-align: center">
          ${this.ins.institutionName}
          </div>

          <br/>
          <br/>
          ${printContents}</body>
      </html>`
    );
    popupWin.document.close();
  }
}
