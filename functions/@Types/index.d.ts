declare interface Note {
  noteId: string;
  content: string;
  updated: Date;
  tags: string[];
  complete: boolean;
}

declare interface Tag {
  tagId: string;
  tagName: string;
}
