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
  notesRef
    .doc(noteId)
    .set({ noteId, content, tags: [], updated: new Date(), complete: false })
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
export const editNote = (noteId: string, content: string) => {
  notesRef
    .doc(noteId)
    .update({ content, updated: new Date() })
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
  notesRef
    .doc(noteId)
    .delete()
    .then(() => true)
    .catch(logReturnFalse);
};
