import { Component } from '@angular/core';

interface Ticket {
  id: number;
  subject: string;
  status: 'Open' | 'In Progress' | 'Closed';
  createdAt: string;
}

@Component({
  selector: 'app-ticket-viewer',
  templateUrl: './ticket-viewer.html',
  standalone: false
})
export class TicketViewer {
  tickets: Ticket[] = [
    { id: 1, subject: 'Login issue', status: 'Open', createdAt: '2025-07-25' },
    { id: 2, subject: 'Payment failed', status: 'In Progress', createdAt: '2025-07-24' },
    { id: 3, subject: 'Bug in dashboard', status: 'Closed', createdAt: '2025-07-23' },
    { id: 4, subject: 'Feature request', status: 'Open', createdAt: '2025-07-22' }
  ];

  filterStatus: 'All' | 'Open' | 'In Progress' | 'Closed' = 'All';

  get filteredTickets(): Ticket[] {
    if (this.filterStatus === 'All') {
      return this.tickets;
    }
    return this.tickets.filter(t => t.status === this.filterStatus);
  }

  setFilter(status: 'All' | 'Open' | 'In Progress' | 'Closed') {
    this.filterStatus = status;
  }
}
