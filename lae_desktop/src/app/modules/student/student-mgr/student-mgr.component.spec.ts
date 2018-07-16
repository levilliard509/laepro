import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StudentMgrComponent } from './student-mgr.component';

describe('StudentMgrComponent', () => {
  let component: StudentMgrComponent;
  let fixture: ComponentFixture<StudentMgrComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StudentMgrComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StudentMgrComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
