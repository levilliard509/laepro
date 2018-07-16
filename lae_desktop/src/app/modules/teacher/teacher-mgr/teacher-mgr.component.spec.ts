import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TeacherMgrComponent } from './teacher-mgr.component';

describe('TeacherMgrComponent', () => {
  let component: TeacherMgrComponent;
  let fixture: ComponentFixture<TeacherMgrComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TeacherMgrComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TeacherMgrComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
