import { NgModule, provideBrowserGlobalErrorListeners } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing-module';
import { App } from './app';
import { TicketViewer } from './ticket-viewer/ticket-viewer';
import { KnowledgebaseEditor } from './knowledgebase-editor/knowledgebase-editor';
import { LiveLogsPanel } from './live-logs-panel/live-logs-panel';
import { Navigation } from './navigation/navigation';
import { MarkdownPipe } from './markdown.pipe';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    App,
    TicketViewer,
    KnowledgebaseEditor,
    LiveLogsPanel,
    Navigation
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    MarkdownPipe,
    FormsModule

  ],
  providers: [
    provideBrowserGlobalErrorListeners()
  ],
  bootstrap: [App]
})
export class AppModule { }
