import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LiveLogsPanel } from './live-logs-panel';

describe('LiveLogsPanel', () => {
  let component: LiveLogsPanel;
  let fixture: ComponentFixture<LiveLogsPanel>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [LiveLogsPanel]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LiveLogsPanel);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
