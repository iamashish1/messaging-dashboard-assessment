import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TicketViewer } from './ticket-viewer/ticket-viewer';
import { KnowledgebaseEditor } from './knowledgebase-editor/knowledgebase-editor';
import { LiveLogsPanel } from './live-logs-panel/live-logs-panel';

const routes: Routes = [
  { path: 'tickets', component: TicketViewer },
  { path: 'editor', component: KnowledgebaseEditor },
  { path: 'logs', component: LiveLogsPanel },
  { path: '', redirectTo: '/tickets', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
