import { notesRef } from "../config/firestoreConfig";
import { logReturnFalse } from "../helpers/errorHelpers";

/**
 * Adds a tag to the given note.
 *
 * @param noteId The noteId of the note to add the tag to.
 * @param tagId The tagId of the tag to add.
 * @return A Promise containing false if there was an error; true otherwise.
 */
export const addTag = (noteId: string, tagId: string) => {
  return notesRef
    .doc(noteId)
    .get()
    .then((doc) => {
      const tags = doc.data()?.tags as string[] | undefined;

      if (tags === undefined) {
        // Document has no data
        return false;
      }

      if (tags.indexOf(tagId) >= 0) {
        // Tag already exists on note
        return true;
      }

      tags.push(tagId);
      return notesRef
        .doc(noteId)
        .update({ tags })
        .then(() => true)
        .catch(logReturnFalse);
    })
    .catch(logReturnFalse);
};

/**
 * Removes a tag from the given note.
 *
 * @param noteId The noteId of the note to remove the tag from.
 * @param tagId The tagId of the tag to remove.
 * @return A Promise containing false if there was an error; true otherwise.
 */
export const removeTag = (noteId: string, tagId: string) => {
  return notesRef
    .doc(noteId)
    .get()
    .then((doc) => {
      const tags = doc.data()?.tags as string[] | undefined;

      if (tags === undefined) {
        // Document has no data
        return false;
      }

      if (tags.indexOf(tagId) < 0) {
        // Tag is already not on the note
        return true;
      }

      tags.splice(tags.indexOf(tagId), 1);
      return notesRef
        .doc(noteId)
        .update({ tags })
        .then(() => true)
        .catch(logReturnFalse);
    })
    .catch(logReturnFalse);
};
