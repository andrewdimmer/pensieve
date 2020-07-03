import { notesRef, tagsRef } from "../config/firestoreConfig";
import { logReturnEmptyArray } from "../helpers/errorHelpers";

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
