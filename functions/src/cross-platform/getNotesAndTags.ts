import { notesRef, tagsRef } from "../config/firestoreConfig";
import { logReturnEmptyArray } from "../helpers/errorHelpers";
import { Note, Tag } from "../@types";

/**
 * Gets the notes with the given tags; if no tags are given, it returns all notes.
 *
 * @param complete A boolean indicating if the results should return current or completed notes. false gets open notes; true gets completed notes.
 * @param tags An array of the tagIds that the note must have.
 * @param limit The number of notes to get.
 * @returns An array of the notes with the given tags.
 */
export const getNotes = (
  complete: boolean,
  tags: string[],
  limit?: number
): Promise<Note[]> => {
  let activeRef = notesRef.where("complete", "==", complete);

  // Must contain all tags to return
  for (const tag of tags) {
    activeRef = activeRef.where("tags", "array-contains", tag);
  }

  // If a limit exists, reduce the results to this limit length
  if (limit) {
    activeRef.limit(limit);
  }

  return activeRef
    .orderBy("order", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data() as Note;
      });
    })
    .catch(logReturnEmptyArray);
};

/**
 * Gets all of the tags from the database with the given name (if provided).
 *
 * @param tagName The name of the tag to match. If no tagName is provided, gets all tags.
 * @returns An array of all of the tags in the database.
 */
export const getTags = (tagName?: string): Promise<Tag[]> => {
  let activeRef:
    | firebase.firestore.CollectionReference<firebase.firestore.DocumentData>
    | firebase.firestore.Query<firebase.firestore.DocumentData> = tagsRef;

  // If a name is specified, get all tags with that name and only that name
  if (tagName) {
    activeRef = activeRef.where("tagName", "==", tagName);
  }

  return activeRef
    .orderBy("tagName", "desc")
    .get()
    .then((queryResults) => {
      return queryResults.docs.map((snapshot) => {
        return snapshot.data() as Tag;
      });
    })
    .catch(logReturnEmptyArray);
};
