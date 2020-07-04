import { notesRef, tagsRef } from "../config/firestoreConfig";
import { logReturnEmptyArray } from "../helpers/errorHelpers";
import { Note, Tag } from "../@types";

/**
 * Gets the notes with the given tags; if no tags are given, it returns all notes.
 *
 * @param tags An array of the tagIds that the note must have.
 * @returns An array of the notes with the given tags.
 */
export const getNotes = (tags: string[]): Promise<Note[]> => {
  return notesRef
    .where("tags", "array-contains-any", tags)
    .orderBy("updated", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data() as Note;
      });
    })
    .catch(logReturnEmptyArray);
};

/**
 * Gets a limited number of notes with the given tags; if no tags are given, it returns all notes.
 *
 * @param tags An array of the tagIds that the note must have.
 * @param limit The number of notes to get.
 * @returns An array of the notes with the given tags.
 */
export const getNotesLimited = (
  tags: string[],
  limit: number
): Promise<Note[]> => {
  return notesRef
    .where("tags", "array-contains-any", tags)
    .orderBy("updated", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data() as Note;
      });
    })
    .catch(logReturnEmptyArray);
};

/**
 * Gets all of the tags from the database.
 *
 * @returns An array of all of the tags in the database.
 */
export const getTags = (): Promise<Tag[]> => {
  return tagsRef
    .orderBy("tagName", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data() as Tag;
      });
    })
    .catch(logReturnEmptyArray);
};
