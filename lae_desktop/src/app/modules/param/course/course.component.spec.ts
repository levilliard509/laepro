import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PaymentPeriodeComponent } from './payment-periode.component';

describe('PaymentPeriodeComponent', () => {
  let component: PaymentPeriodeComponent;
  let fixture: ComponentFixture<PaymentPeriodeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PaymentPeriodeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentPeriodeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
