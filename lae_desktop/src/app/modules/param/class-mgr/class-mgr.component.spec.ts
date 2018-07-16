import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ClassMgrComponent } from './class-mgr.component';

describe('ClassMgrComponent', () => {
  let component: ClassMgrComponent;
  let fixture: ComponentFixture<ClassMgrComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClassMgrComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClassMgrComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
