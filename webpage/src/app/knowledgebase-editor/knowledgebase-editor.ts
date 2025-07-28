import { Component } from '@angular/core';

@Component({
  selector: 'app-knowledgebase-editor',
  templateUrl: './knowledgebase-editor.html',
  standalone: false,
})
export class KnowledgebaseEditor {
  content = '';

  saveContent() {
    alert('Content saved locally');
  }
}
