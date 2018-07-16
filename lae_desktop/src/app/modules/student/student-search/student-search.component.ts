
import { Component, ElementRef, ViewChild } from '@angular/core';
import { DataSource } from '@angular/cdk/collections';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';
import { Observable } from 'rxjs/Observable';
import { StudentModel } from '../../../models/student-model';
import { GenericProvider } from '../../../providers/generic';
import { AppSettings } from '../../../providers/app-settings';

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
  selector: 'app-student-search',
  templateUrl: './student-search.component.html',
  styleUrls: ['../student.css']
})
export class StudentSearchComponent {
  displayedColumns = ['userId', 'Nom', 'Prenom', 'DateNaiss'];
  stdReportDatabase = new StdReportDatabase(this.gProvider);
  dataSource: ExampleDataSource | null;
  mode: number = 0; // mode 0: show all student, mode 1= 0: show all student by class

  @ViewChild('filter') filter: ElementRef;

  constructor(private gProvider: GenericProvider){
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
}


export class StdReportDatabase {
  /** Stream that emits whenever the data has been modified. */
  dataChange: BehaviorSubject<StudentModel[]> = new BehaviorSubject<StudentModel[]>([]);
  
  get data(): StudentModel[] { 
  	return this.dataChange.value; 
  }

  constructor(private gProvider: GenericProvider){
    let uri: string = "/student/all/true";
    if(AppSettings.CLASS_DATA_MODE != 0){
      uri = "/student/all/class/" + AppSettings.CLASS_DATA_MODE + "/true";
    }

  	this.gProvider.getData(uri).subscribe(data=>{
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
        let searchStr = ("#" + item.studentId + item.studentFirstname + item.studentLastname).toLowerCase();
        return searchStr.indexOf(this.filter.toLowerCase()) != -1;
      });
    });
  }

  disconnect() {}
}