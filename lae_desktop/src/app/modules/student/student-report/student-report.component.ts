
import { Component, ElementRef, ViewChild, Inject } from '@angular/core';
import { DataSource } from '@angular/cdk/collections';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';
import { Observable } from 'rxjs/Observable';
import { MatPaginator, MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { StudentModel, StudentAbsenceModel, StudentPenalityModel } from '../../../models/student-model';
import { GenericProvider } from '../../../providers/generic';

import 'rxjs/add/operator/startWith';
import 'rxjs/add/observable/merge';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/debounceTime';
import 'rxjs/add/operator/distinctUntilChanged';
import 'rxjs/add/observable/fromEvent';

/**
 * @title Table with filtering
 */
@Component({
  selector: 'students-report',
  styleUrls: ['../student.css'],
  templateUrl: 'students-report.component.html',
  providers: [GenericProvider]

})
export class StudentReportComponent {
  displayedColumns = ['Nom', 'Prenom', 'Absence', 'Sanction'];
  stdReportDatabase = new StdReportDatabase(this.gProvider);
  dataSource: ExampleDataSource | null;

  @ViewChild('filter') filter: ElementRef;

  constructor(private gProvider: GenericProvider, public dialog: MatDialog){
      console.clear();
  }

  ngOnInit() {
    this.dataSource = new ExampleDataSource(this.stdReportDatabase);
    Observable.fromEvent(this.filter.nativeElement, 'keyup')
        .debounceTime(150)
        .distinctUntilChanged()
        .subscribe(() => {
          if (!this.dataSource) { return; }
          this.dataSource.filter = this.filter.nativeElement.value;
        });
  }

  openAbsenceDialog(param): void {
      
      let data: any = {};

      data.std = param;

      this.gProvider.getData("/absence/all/" + param.studentId).subscribe(response=>{
        let obj: any = response;
        console.log("absence: ", response);
        let abs: StudentAbsenceModel = <StudentAbsenceModel>obj;
        data.abs = abs;

        let dialogRef = this.dialog.open(StudentReportAbsence, {
          width: '900px',
          height: '400px',
          data: data
        }); 
      })

  }

  openSanctionDialog(param): void {
      
      let data: any = {};

      data.std = param;

      this.gProvider.getData("/penality/student/" + param.studentId).subscribe(response=>{
        let obj: any = response;
        console.log("response data: ", response);
        let sanctions: StudentAbsenceModel = <StudentAbsenceModel>obj;
        data.sanctions = sanctions;

        let dialogRef = this.dialog.open(StudentReportPenality, {
          width: '1000px',
          height: '500px',
          data: data
        }); 
      })

  }

}



export class StdReportDatabase {
  /** Stream that emits whenever the data has been modified. */
  dataChange: BehaviorSubject<StudentModel[]> = new BehaviorSubject<StudentModel[]>([]);
  
  get data(): StudentModel[] { 
  	return this.dataChange.value; 
  }

  constructor(private gProvider: GenericProvider){
  	this.gProvider.getData("/student/all/true").subscribe(data=>{
  		console.log("data std: ", data);
  		this.dataChange.next(<Array<StudentModel>>data);
  	}, error=>{
  		console.log("data error: ", error);
  	})
  }
}



export class ExampleDataSource extends DataSource<any> {
  _filterChange = new BehaviorSubject('');
  dateStart: string;
  dateEnd: string;

  get filter(): string { return this._filterChange.value; }
  set filter(filter: string) { this._filterChange.next(filter); }

  constructor(private _exampleDatabase: StdReportDatabase) {
    super();
  }

  /** Connect function called by the table to retrieve one stream containing the data to render. */
  connect(): Observable<StudentModel[]> {
    const displayDataChanges = [
      this._exampleDatabase.dataChange,
      this._filterChange,
    ];

    
    return Observable.merge(...displayDataChanges).map(() => {
      return this._exampleDatabase.data.slice().filter((item: StudentModel) => {
        let searchStr = (item.studentFirstname + item.studentLastname).toLowerCase();
        return searchStr.indexOf(this.filter.toLowerCase()) != -1;
      });
    });
  }

  disconnect() {}
}




/* 
  Absence dialog
  Use same datasource as SanctionDataSource 
 */
@Component({
  selector: 'student-report-absence',
  styleUrls: ['students-report.component.css'],
  templateUrl: 'student-report-absence.html',
  providers: [GenericProvider]
})
export class StudentReportAbsence{
  std: StudentModel;
  abs: Array<Object>;
  displayedColumns = ['Motif', 'Details', 'Heure'];
  dataSource: any;
  isEmty: boolean = false;

  constructor(private gProvider: GenericProvider,  public dialogRef: MatDialogRef<StudentReportAbsence>, public dialog: MatDialog, @Inject(MAT_DIALOG_DATA) private data: any){ 
      this.std = this.data.std;
      this.abs = this.data.abs;
      this.dataSource = new SanctionDataSource(this.abs);

      if(this.abs.length > 0){
        this.isEmty = true;
      }
  }


  onNoClick(): void {
    this.dialogRef.close();
  }

  printSanctions(): void {
    let printContents, popupWin;
    printContents = document.getElementById('print_sanction').innerHTML;
    popupWin = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
    popupWin.document.open();
    popupWin.document.write(`
      <html>
        <head>
          <title> Information sur l'eleve </title>
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
       <body onload="window.print();window.close()">${printContents}</body>
      </html>`
    );
    popupWin.document.close();
  }

}



/*   */
@Component({
  selector: 'student-report-penality',
  styleUrls: ['students-report.component.css'],
  templateUrl: 'student-report-penality.html',
  providers: [GenericProvider]
})
export class StudentReportPenality{
  std: StudentModel;
  sanctions: Array<Object>;
  displayedColumns = ['Sanction', 'Description', 'Details', 'Frais', 'Date'];
  dataSource: any;
  isEmty: boolean = false;

  constructor(private gProvider: GenericProvider,  public dialogRef: MatDialogRef<StudentReportAbsence>, public dialog: MatDialog, @Inject(MAT_DIALOG_DATA) private data: any){ 
      this.std = this.data.std;
      this.sanctions = this.data.sanctions;
      this.dataSource = new SanctionDataSource(this.sanctions);

      if(this.sanctions.length > 0){
        this.isEmty = true;
      }
  }


  onNoClick(): void {
    this.dialogRef.close();
  }

  printSanctions(): void {
    let printContents, popupWin;
    printContents = document.getElementById('print_sanction').innerHTML;
    popupWin = window.open('', '_blank', 'top=0,left=0,height=100%,width=auto');
    popupWin.document.open();
    popupWin.document.write(`
      <html>
        <head>
          <title> Information sur l'eleve </title>
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

          .hidd{
            height: 50px;
          }         
    </style>
        </head>
       <body onload="window.print();window.close()">${printContents}</body>
      </html>`
    );
    popupWin.document.close();
  }

}


/**
 * Data source to provide what data should be rendered in the table. The observable provided
 * in connect should emit exactly the data that should be rendered by the table. If the data is
 * altered, the observable should emit that new set of data on the stream. In our case here,
 * we return a stream that contains only one set of data that doesn't change.
 */
export class SanctionDataSource extends DataSource<any> {
  data: any;

  constructor(data){
    super();
    this.data = data;
    console.log("data source: ", this.data);
  }

  connect(): Observable<Object[]> {
    return Observable.of(this.data);
  }

  disconnect() {}
}