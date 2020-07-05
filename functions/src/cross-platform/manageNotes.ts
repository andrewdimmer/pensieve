import { nanoid } from "nanoid";
import { notesRef } from "../config/firestoreConfig";
import { logReturnEmptyString, logReturnFalse } from "../helpers/errorHelpers";

/**
 *  Adds a new note to the database.
 *
 * @param content The message to save to the database.
 * @returns The id of the newly created note.
 */
export const createNote = (content: string) => {
  const noteId = nanoid();
  return notesRef
    .doc(noteId)
    .set({ noteId, content, tags: [], order: Date.now(), complete: false })
    .then(() => noteId)
    .catch(logReturnEmptyString);
};

/**
 * Modifies the content of a note already in the database.
 *
 * @param noteId The noteId of the note to update.
 * @param content The new message to save to the note.
 * @returns A promise containing true if the update was successful; false otherwise.
 */
export const editNoteContent = (noteId: string, content: string) => {
  return notesRef
    .doc(noteId)
    .update({ content, order: Date.now() })
    .then(() => true)
    .catch(logReturnFalse);
};

/**
 * Modifies the completeness of a note already in the database.
 *
 * @param noteId The noteId of the note to update.
 * @param complete The new completeness flag to save to the note.
 * @returns A promise containing true if the update was successful; false otherwise.
 */
export const editNoteCompleteness = (noteId: string, complete: boolean) => {
  return notesRef
    .doc(noteId)
    .update({ complete, order: Date.now() })
    .then(() => true)
    .catch(logReturnFalse);
};

/**
 * Modifies the order of a note already in the database.
 *
 * @param noteId The noteId of the note to update.
 * @param order The new order to save to the note.
 * @returns A promise containing true if the update was successful; false otherwise.
 */
export const editNoteOrder = (noteId: string, order: number) => {
  return notesRef
    .doc(noteId)
    .update({ order })
    .then(() => true)
    .catch(logReturnFalse);
};

/**
 * Deletes a note from the database.
 *
 * @param noteId The noteId of the note to delete.
 * @returns A promise containing true if the was deleted successful; false otherwise.
 */
export const deleteNote = (noteId: string) => {
  return notesRef
    .doc(noteId)
    .delete()
    .then(() => true)
    .catch(logReturnFalse);
};
