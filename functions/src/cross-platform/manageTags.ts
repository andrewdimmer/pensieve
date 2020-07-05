import { nanoid } from "nanoid";
import { tagsRef } from "../config/firestoreConfig";
import { logReturnEmptyString, logReturnFalse } from "../helpers/errorHelpers";

/**
 *  Adds a new tag to the database.
 *
 * @param tagName The tag name/label to save to the database.
 * @returns The id of the newly created tag.
 */
export const createTag = (tagName: string) => {
  const tagId = nanoid();
  return tagsRef
    .doc(tagId)
    .set({ tagId, tagName })
    .then(() => tagId)
    .catch(logReturnEmptyString);
};

/**
 * Modifies the content of a tag already in the database.
 *
 * @param tagId The tagId of the tag to update.
 * @param content The new tag name/label to save to the database.
 * @returns A promise containing true if the update was successful; false otherwise.
 */
export const editTag = (tagId: string, tagName: string) => {
  return tagsRef
    .doc(tagId)
    .update({ tagName })
    .then(() => true)
    .catch(logReturnFalse);
};

/**
 * Deletes a tag from the database.
 *
 * @param tagId The tagId of the tag to delete.
 * @returns A promise containing true if the was deleted successful; false otherwise.
 */
export const deleteTag = (tagId: string) => {
  return tagsRef
    .doc(tagId)
    .delete()
    .then(() => true)
    .catch(logReturnFalse);
};
