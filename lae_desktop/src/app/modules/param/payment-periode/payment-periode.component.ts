
import { Component, OnInit } from '@angular/core';
import { Inject} from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';
import { GlobalFunction } from '../../../global/global';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';

import { ElementRef, ViewChild, Input} from '@angular/core';
import { DataSource } from '@angular/cdk/collections';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';
import { Observable } from 'rxjs/Observable';
import { MatPaginator} from '@angular/material';

import 'rxjs/add/operator/startWith';
import 'rxjs/add/observable/merge';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/debounceTime';
import 'rxjs/add/operator/distinctUntilChanged';
import 'rxjs/add/observable/fromEvent';

import { InstitutionClassModel, PaymentPeriodModel } from '../../../models/institution-model';


@Component({
  selector: 'payment-periode',
  templateUrl: './payment-periode.component.html',
  styleUrls: ['./payment-periode.component.css']
})
export class PaymentPeriodeComponent implements OnInit{   

  displayedColumns = ['Versement', 'Valeur', 'Desc', 'DateDebut', 'DateFin', 'Update', 'Delete'];
  exampleDatabase = new PayPeriodeDatabase(this.gProvider, this.data.institutionClassId);
  dataSource: PayPeriodeDataSource | null;
  PayForm: FormGroup;
  @ViewChild('filter') filter: ElementRef;
  currPay: PaymentPeriodModel
  clas: InstitutionClassModel;
  isAdd: boolean;
  payList: Array<PaymentPeriodModel>;

  constructor(
    public dialogRef: MatDialogRef<PaymentPeriodeComponent>, 
    private formBuilder: FormBuilder, 
    private gProvider: GenericProvider, 
    public dialog: MatDialog,
    @Inject(MAT_DIALOG_DATA) public data: any){

    this.currPay = new PaymentPeriodModel();
    this.clas = this.data;
    this.isAdd = false;

    this.PayForm = this.formBuilder.group({
      periodeId: ['', Validators.compose([Validators.required])],
      paymentPeriodeValue: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(20), Validators.required])],
      paymentPeriodeDateStart: ['', Validators.compose([Validators.required])],
      paymentPeriodeDateEnd: ['', Validators.compose([Validators.required])],
      paymentPeriodeDetails: ['', Validators.compose([Validators.minLength(5), Validators.maxLength(200)])],
    });
  }

  fetchData(): void {
    this.exampleDatabase = new PayPeriodeDatabase(this.gProvider, this.clas.institutionClassId);
    this.dataSource = new PayPeriodeDataSource(this.exampleDatabase);
  }

  ngOnInit() {
    this.dataSource = new PayPeriodeDataSource(this.exampleDatabase);

    let subscribetion = this.exampleDatabase.dataChange.subscribe(
      (x)=>{
        if(x.length > 0){
          this.payList = x;
        }
      }, error=>{
        console.log("Error: ", error);
    })

    Observable.fromEvent(this.filter.nativeElement, 'keyup')
      .debounceTime(150)
      .distinctUntilChanged()
      .subscribe(() => {
        if (!this.dataSource) { return; }
        this.dataSource.filter = this.filter.nativeElement.value;
      });
  }

  showAdd(){

    if(this.payList != null && this.payList.length > 0){
      this.PayForm.setValue( {
        "periodeId": this.payList[this.payList.length - 1].periodeId + 1,
        "paymentPeriodeValue": "",
        "paymentPeriodeDateStart": "",
        "paymentPeriodeDateEnd": "",
        "paymentPeriodeDetails": ""
      });  
    }else{
      this.PayForm.patchValue({
        "periodeId": 1
      })
    }

    this.isAdd = ! this.isAdd;
  }
  onClickSave(): void{

    let obj: PaymentPeriodModel = new PaymentPeriodModel();
    obj.institutionClassId = this.clas.institutionClassId;
    obj.periodeId = this.PayForm.value.periodeId;
    obj.paymentPeriodeValue = this.PayForm.value.paymentPeriodeValue;
    obj.paymentPeriodeDateStart = new Date(Date.parse(this.PayForm.value.paymentPeriodeDateStart)).getTime() + "";
    obj.paymentPeriodeDateEnd = new Date(Date.parse(this.PayForm.value.paymentPeriodeDateEnd)).getTime() + "";
    obj.paymentPeriodeDetails = this.PayForm.value.paymentPeriodeDetails;
    obj.createdBy = AppSettings.DEFAULT_USER.userUsername;
    obj.dateCreated = GlobalFunction.getCurrentDate(false);
    obj.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    obj.dateModified = GlobalFunction.getCurrentDate(false);   

    if(!this.validatePay(obj.periodeId)){
      alert("Une erreur s'est produite. Soit vous vous essayez d'ajouter une periode existante, soit la periode n'est pas entre 1 et 5");
      return ;
    }

    this.gProvider.addObj(obj, "/payment_periode").subscribe(data=>{
      console.log("payment_class add: ", obj);
      this.onNoClick();
      GlobalFunction.showMsgSuccess();
    }, error=>{
      GlobalFunction.showMsgError();
      this.onNoClick();
    })        
  }
  
  validatePay(pay: number): boolean{
    let good: boolean = true;

    if(this.payList != null){
      for(let i = 0; i <this.payList.length; ++i){
        if(this.payList[i].periodeId == pay){
            good = false;
        }

        if(pay < 1 || pay > 5){
          good = false;
        }
      }
    }

    return good;
  }

  openDeleteDialog(data: Object): void {

  }

  openUpdateDialog(data): void {
    let dialogRef = this.dialog.open(PayUpdateDialog, {
      width: "700px",
      height: "400px",
      data: data
    });
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  deletePay(obj: PaymentPeriodModel){

    for(let i = 0; i <this.payList.length; ++i){
      if(obj.periodeId < this.payList[this.payList.length - 1].periodeId){
        alert("Vous pouvez seulement supprimer le dernier enregistrement");
        return ;
      }
    }

    this.gProvider.deleteObj(obj.paymentPeriodeId + "", "/payment_periode").subscribe((data)=>{
      console.log("Delete Object success: ",  data);
      GlobalFunction.showMsgSuccess();
      this.onNoClick();
    },error=>{
      console.log("Delete Object error: ",  error);
      GlobalFunction.showMsgError();
    });
  }

}

export class PayPeriodeDatabase {
  dataChange: BehaviorSubject<PaymentPeriodModel[]> = new BehaviorSubject<PaymentPeriodModel[]>([]);

  get data(): PaymentPeriodModel[]{
    return this.dataChange.value;
  }

  constructor(private gProvider: GenericProvider, id:number) {
    this.gProvider.getData("/payment_periode/all/" + id).subscribe(data => {
      console.log("data payment: ", data);
      this.dataChange.next(<Array<PaymentPeriodModel>>data);
    }, error => {
      console.log("data error: ", error);
    });
  }
}

export class PayPeriodeDataSource extends DataSource<any> {
  _filterChange = new BehaviorSubject('');
  get filter(): string { return this._filterChange.value; }
  set filter(filter: string) { this._filterChange.next(filter); }

  constructor(private _exampleDatabase: PayPeriodeDatabase) {
    super();
  }

  /** Connect function called by the table to retrieve one stream containing the data to render. */
  connect(): Observable<PaymentPeriodModel[]> {
    const displayDataChanges = [
      this._exampleDatabase.dataChange,
      this._filterChange,
    ];

    return Observable.merge(...displayDataChanges).map(() => {
      return this._exampleDatabase.data.slice().filter((item: PaymentPeriodModel) => {
        let searchStr = (item.paymentPeriodeDateEnd + item.paymentPeriodeDateStart).toLowerCase();
        return searchStr.indexOf(this.filter.toLowerCase()) != -1;
      });
    });
  }

  disconnect() { }
}




@Component({
  selector: 'payment-periode-update',
  templateUrl: './payment-periode.update.html',
  styleUrls: ['./payment-periode.component.css']
})
export class PayUpdateDialog implements OnInit{

  pay: PaymentPeriodModel;

  PayForm: FormGroup;
  isDelete: boolean;
  isDetails: boolean;

  constructor(public dialogRef: MatDialogRef<PayUpdateDialog>, private formBuilder: FormBuilder, private gProvider: GenericProvider, @Inject(MAT_DIALOG_DATA) public data: any){

  this.pay = this.data;

  this.PayForm = this.formBuilder.group({
    //periodeId: ['', Validators.compose([Validators.required])],
    paymentPeriodeValue: ['', Validators.compose([Validators.minLength(3), Validators.maxLength(20), Validators.required])],
    paymentPeriodeDateStart: ['', Validators.compose([Validators.required])],
    paymentPeriodeDateEnd: ['', Validators.compose([Validators.required])],
    paymentPeriodeDetails: ['', Validators.compose([Validators.minLength(5), Validators.maxLength(200)])],
  });

  this.PayForm.setValue( {
    "paymentPeriodeValue": this.pay.paymentPeriodeValue, 
    "paymentPeriodeDateStart": new Date(Date.parse( this.pay.paymentPeriodeDateStart)).toISOString().split("T")[0], 
    "paymentPeriodeDateEnd": new Date(Date.parse( this.pay.paymentPeriodeDateEnd)).toISOString().split("T")[0], 
    "paymentPeriodeDetails": this.pay.paymentPeriodeDetails 
  });

  }

  ngOnInit(){
  }

  onClickSave(): void{
    let obj: PaymentPeriodModel = new PaymentPeriodModel();
    obj.paymentPeriodeId = this.pay.paymentPeriodeId;
    obj.institutionClassId = this.pay.institutionClassId;
    obj.periodeId = this.pay.periodeId;
    obj.paymentPeriodeValue = this.PayForm.value.paymentPeriodeValue;
    obj.paymentPeriodeDateStart = new Date(Date.parse(this.PayForm.value.paymentPeriodeDateStart)).getTime() + "";
    obj.paymentPeriodeDateEnd = new Date(Date.parse(this.PayForm.value.paymentPeriodeDateEnd)).getTime() + "";
    obj.paymentPeriodeDetails = this.PayForm.value.paymentPeriodeDetails;
    obj.createdBy = AppSettings.DEFAULT_USER.userUsername;
    obj.dateCreated = GlobalFunction.getCurrentDate(false);
    obj.modifiedBy = AppSettings.DEFAULT_USER.userUsername;
    obj.dateModified = GlobalFunction.getCurrentDate(false);   

    this.gProvider.update(obj, "/payment_periode").subscribe(data=>{
      console.log("payment update");
      this.onNoClick();
      GlobalFunction.showMsgSuccess();
    }, error=>{
      GlobalFunction.showMsgError();
      this.onNoClick();
    })	;
	}

  onNoClick(): void {
    this.dialogRef.close();
  }

}