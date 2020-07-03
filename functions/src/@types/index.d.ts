export declare interface Note {
  noteId: string;
  content: string;
  updated: Date;
  tags: string[];
  complete: boolean;
}

export declare interface Tag {
  tagId: string;
  tagName: string;
}
