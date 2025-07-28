import {
  Component,
  ElementRef,
  OnDestroy,
  ViewChild,
  AfterViewChecked
} from '@angular/core';

@Component({
  selector: 'app-live-logs-panel',
  standalone: false,
  templateUrl: './live-logs-panel.html',
})
export class LiveLogsPanel implements OnDestroy, AfterViewChecked {
  private logsArray: string[] = [];
  private logInterval: any;

  @ViewChild('logContainer') private logContainer!: ElementRef<HTMLDivElement>;

  constructor() {
    this.startLogging();
  }

  startLogging() {
    this.logInterval = setInterval(() => {
      const timestamp = new Date().toISOString();
      this.logsArray.push(`[${timestamp}] Log entry`);
    }, 1000);
  }

  logs() {
    return this.logsArray;
  }

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    try {
      const container = this.logContainer.nativeElement;
      container.scrollTop = container.scrollHeight;
    } catch (err) {
      console.error('Scroll error:', err);
    }
  }

  ngOnDestroy() {
    clearInterval(this.logInterval);
  }
}