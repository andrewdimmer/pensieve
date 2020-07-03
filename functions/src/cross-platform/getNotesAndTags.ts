import { notesRef, tagsRef } from "../config/firestoreConfig";
import { logReturnEmptyArray } from "../helpers/errorHelpers";

/**
 * Gets the notes with the given tags; if no tags are given, it returns all notes.
 *
 * @param tags An array of the tagIds that the note must have
 * @returns An array of the notes with the given tags
 */
export const getNotes = (tags: string[]) => {
  return notesRef
    .where("tags", "array-contains-any", tags)
    .orderBy("updated", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data();
      });
    })
    .catch(logReturnEmptyArray);
};

/**
 * Gets all of the tags from the database.
 *
 * @returns An array of all of the tags in the database.
 */
export const getTags = () => {
  return tagsRef
    .orderBy("tagName", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data();
      });
    })
    .catch(logReturnEmptyArray);
};
