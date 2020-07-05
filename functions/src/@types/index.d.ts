export declare interface Note {
  noteId: string;
  content: string;
  order: number;
  tags: string[];
  complete: boolean;
}

export declare interface Tag {
  tagId: string;
  tagName: string;
}
