
import { async, ComponentFixture, TestBed } from '@angular/core/testing';
import { TeacherPayComponent } from './teacher-pay.component';

describe('TeacherPayComponent', () => {
  let component: TeacherPayComponent;
  let fixture: ComponentFixture<TeacherPayComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TeacherPayComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TeacherPayComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
