import { nanoid } from "nanoid";
import { notesRef } from "../config/firestoreConfig";
import { logReturnEmptyString, logReturnFalse } from "../helpers/errorHelpers";

export const createNote = (content: string) => {
  const noteId = nanoid();
  notesRef
    .doc(noteId)
    .set({ noteId, content, tags: [], updated: new Date(), complete: false })
    .then(() => noteId)
    .catch(logReturnEmptyString);
};

export const editNote = (noteId: string, content: string) => {
  notesRef
    .doc(noteId)
    .update({ content, updated: new Date() })
    .then(() => true)
    .catch(logReturnFalse);
};

export const deleteNote = (noteId: string) => {
  notesRef
    .doc(noteId)
    .delete()
    .then(() => true)
    .catch(logReturnFalse);
};
