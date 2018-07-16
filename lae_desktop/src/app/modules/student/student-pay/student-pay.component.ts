


import { Component, ViewChild, OnInit, Inject } from '@angular/core';
import { DataSource} from '@angular/cdk/collections';
import { BehaviorSubject} from 'rxjs/BehaviorSubject';
import { Observable} from 'rxjs/Observable';
import 'rxjs/add/operator/startWith';
import 'rxjs/add/observable/merge';
import 'rxjs/add/operator/map';

import { MatPaginator, MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';

import { StudentPaymentModel } from '../../../models/student-model';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { GlobalFunction } from '../../../global/global';

import { PaymentPeriodModel } from '../../../models/institution-model'
import { APP_BASE_HREF } from '@angular/common';

@Component({
  selector: 'app-student-pay',
  templateUrl: './student-pay.component.html',
  styleUrls: ['../student.css']
})
export class StudentPayComponent implements OnInit {
  displayedColumns = ['Eleve', 'Classe', 'Montant', 'Balance', 'Status', "Details", "Paye", "Historique"];

  stdDatabase = new StdPaymentDatabase(this.gProvider);
  dataSource: ExampleDataSource | null;

  @ViewChild(MatPaginator) paginator: MatPaginator;

  constructor(private gProvider: GenericProvider, public dialog: MatDialog){

  }
  ngOnInit() {
    this.fetchData();
  }

  private fetchData(): void{
    this.dataSource = new ExampleDataSource(this.stdDatabase, this.paginator);
  }
  openDetailsDialog(obj): void {           
    let dialogRef = this.dialog.open(StdPaymentDetails, {
      width: '950px',
      height: '650px',
      data: obj
    });  

  }

  openPayDialog(data){
    let dialogRef = this.dialog.open(StdPayment, {
      width: '450px',
      height: '350px',
      data: data
    });  

    dialogRef.afterClosed().subscribe(()=>{
      this.fetchData();
    })
  }

  openHistoriqueDialog(data){
	    let dialogRef = this.dialog.open(StdPaymentHistoric, {
	      width: '750px',
	      height: '550px',
	      data: data
	    });   
   }
}
               
/*
 Les montants sont calculer a patir d'une autre table de la base de donnees (payment_periode).
 les montants calcules ici ne seront pas utilises, par le fait qu'elles sont calulees pour des periode
*/
export class StdPaymentDatabase {
  dataChange: BehaviorSubject<Object[]> = new BehaviorSubject<Object[]>([]);
  
  get data(): Object[] { 
  	return this.dataChange.value; 
  }

  constructor(private gProvider: GenericProvider){
  	this.gProvider.getData("/payment_class/all/pay").subscribe(data=>{
  		console.log("data std: ", data);
  		this.dataChange.next(<Array<Object>>data);
  	}, error=>{
  		console.log("data error: ", error);
  	})
  }
}


export class ExampleDataSource extends DataSource<any> {
  constructor(private stDb: StdPaymentDatabase, private _paginator: MatPaginator) {
    super();
}

  /** Connect function called by the table to retrieve one stream containing the data to render. */
  connect(): Observable<Object[]> {
    const displayDataChanges = [
      this.stDb.dataChange,
      this._paginator.page,
    ];

    return Observable.merge(...displayDataChanges).map(() => {
      const data = this.stDb.data.slice();

      // Grab the page's slice of data.
      const startIndex = this._paginator.pageIndex * this._paginator.pageSize;
      return data.splice(startIndex, this._paginator.pageSize);
    });
  }

  disconnect() {}
}

/*
	create details student component dialog
*/

@Component({
  selector: 'app-student-pay-details',
  templateUrl: './student-pay-details.component.html',
  styleUrls: ['../student.css'],
  providers: [GenericProvider]
})
export class StdPaymentDetails{

	stdPay: Array<StudentPaymentModel>;
  pay_param: Array<PaymentPeriodModel>;
  totalPay: number;
  totalPay1: number;
  iname: string = "";

	constructor(@Inject(MAT_DIALOG_DATA) public obj: any, private gProvider: GenericProvider,  public dialogRef: MatDialogRef<StdPaymentDetails>){
    console.log("retrieve data details success... ", this.obj);
    this.pay_param = [];
    this.totalPay = this.obj.totalStudentPayment;
    this.totalPay1 = this.obj.totalStudentPayment;

    this.gProvider.getData("/payment_periode/all/" + this.obj.institutionClassId).subscribe(data => {
      this.pay_param = <Array<PaymentPeriodModel>>data;
      console.log("data payment: ", this.pay_param);

    }, error => {
      console.log("data error: ", error);
    });

    this.iname = AppSettings.INSTITUTION.institutionName + "";
	}

  calculateBalance(data: number): number{
    let temp: number = 0;

    if(data - this.totalPay >= 0){
      temp = this.totalPay;
      this.totalPay = 0;
    }else{
      this.totalPay -= data;
      temp = data;
    }
    
    return temp;
  }

  calculatePay(data: number): number{

    let temp: number = 0;

    if(data - this.totalPay1 >= 0){
      temp = this.totalPay1;
      this.totalPay1 = 0;
    }else{
      this.totalPay1 -= data;
      temp = data;
    }
    
    return temp;
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  printPayDetails(): void {
    
    let printContents, popupWin;
    printContents = document.getElementById('pay_details_id').innerHTML;
    popupWin = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
    popupWin.document.open();
    popupWin.document.write(`
      <html>
        <head>
          <title> Institution ${this.iname} </title>
          <link href="./student-pay.component.css" rel="stylesheet">

          <style>
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
              
              tr{
                border: solid 1px #888;
              }

                                        
              .pay{
                border-right: solid 1px #eee;
                padding: 10px 20px;
              }    
              
              h3{
                background: #eee;
                padding: 4px 6px;
              }
              
              .hidd{
                height: 50px;
              }         
          </style>
        </head>
       <body onload="window.print();window.close()">
       <div style="text-align: center">
          Institution ${this.iname}         
       </div>

       <br/>

        <p>Information générale</p>
          ${printContents}
        </body>
        <footer>
          <br/><br/><br/><hr>
          ${this.obj.studentFirstname + " " + this.obj.studentLastname}
        </footer>
      </html>`
    );
    popupWin.document.close();
  }

}


/*
	create payment student component dialog
*/
@Component({
  selector: 'app-student-paymentf',
  templateUrl: './student-payment.component.html',
  styleUrls: ['../student.css'],
  providers: [GenericProvider]
})
export class StdPayment{
  PaymentForm: FormGroup;
  paym: StudentPaymentModel;
  
	constructor(private formBuilder: FormBuilder, @Inject(MAT_DIALOG_DATA) public data: any, private gProvider: GenericProvider,  public dialogRef: MatDialogRef<StdPaymentDetails>){

		this.PaymentForm = this.formBuilder.group({
			/* student form */
		    paymentStudentValue:  ['', Validators.compose([Validators.minLength(3), Validators.maxLength(20), Validators.required])],
    });
    
	}

  onNoClick(): void {
    this.dialogRef.close();
  }

  onClickSave(){
	//console.log("retrieve data details success... ", this.data);
	let obj: StudentPaymentModel = new StudentPaymentModel();
	obj.studentId = this.data.studentId;
	obj.paymentStudentValue = this.PaymentForm.value.paymentStudentValue;
	obj.createdBy = AppSettings.DEFAULT_USER.userUsername;
	obj.dateCreated = GlobalFunction.getCurrentDate(true);
	obj.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
	obj.dateModified = GlobalFunction.getCurrentDate(true);

  console.log("payment log: ", obj);
  
	this.gProvider.add(obj, "/payment_student/").subscribe(response=>{
		console.log("add payment data success: ", response);
		this.onNoClick();
	}, error=>{
		console.log("add payment data error: ", error);
		this.onNoClick();
	});
  }

}

/*
	create historique student component dialog
*/

@Component({
  selector: 'app-student-pay-details',
  templateUrl: './student-payment-historic.component.html',
  styleUrls: ['../student.css'],
  providers: [GenericProvider]
})
export class StdPaymentHistoric{

  stdPay: Array<StudentPaymentModel>;
  iname: string = "";

	constructor(@Inject(MAT_DIALOG_DATA) public obj: any, private gProvider: GenericProvider,  public dialogRef: MatDialogRef<StdPaymentDetails>){
		console.log("retrieve data payment success... ", this.obj);
		
		this.gProvider.getData("/payment_student/all/"+ this.obj.studentId).subscribe(response=>{
			this.stdPay = <Array<StudentPaymentModel>>response;
			console.log("retrieve student data success: ", response);
		}, error=>{
			console.log("retrieve student data error: ", error);
    });
    this.iname = AppSettings.INSTITUTION.institutionName + "";
	}

  onNoClick(): void {
    this.dialogRef.close();
  }


    printPayHis(): void {
    console.log("print test");

    let printContents, popupWin;
    printContents = document.getElementById('pay_his_id').innerHTML;
    popupWin = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
    popupWin.document.open();
    popupWin.document.write(`
      <html>
        <head>
          <title> Institution ${this.iname} </title>
          <link href="./student-pay.component.css" rel="stylesheet">

          <style>
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
             
             tr{
               border: solid 1px #888;
             }
            
            .hidd{
              height: 50px;
            }    
                        
            .pay{
              border-right: solid 1px #eee;
              padding: 10px 20px;
            }    
            
            h3{
              background: #eee;
              padding: 4px 6px;
            }
         </style>
        </head>
       <body onload="window.print();window.close()">
       <div style="text-align: center">
          Institution ${this.iname}         
        </div>

        <p>Information générale</p>
        ${printContents}
       </body>
       <footer>
          <br/><br/><br/><hr>
          ${this.obj.studentFirstname + " " + this.obj.studentLastname}
       </footer>
      </html>`
    );
    popupWin.document.close();
  }

}