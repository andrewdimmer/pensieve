import { nanoid } from "nanoid";
import { tagsRef } from "../config/firestoreConfig";
import { logReturnEmptyString, logReturnFalse } from "../helpers/errorHelpers";

export const createTag = (tagName: string) => {
  const tagId = nanoid();
  tagsRef
    .doc(tagId)
    .set({ tagId, tagName })
    .then(() => tagId)
    .catch(logReturnEmptyString);
};

export const editTag = (tagId: string, tagName: string) => {
  tagsRef
    .doc(tagId)
    .update({ tagName })
    .then(() => true)
    .catch(logReturnFalse);
};

export const deleteTag = (tagId: string) => {
  tagsRef
    .doc(tagId)
    .delete()
    .then(() => true)
    .catch(logReturnFalse);
};
