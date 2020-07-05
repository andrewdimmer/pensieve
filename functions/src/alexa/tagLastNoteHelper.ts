import * as functions from "firebase-functions";
import { getNotes, getTags } from "../cross-platform/getNotesAndTags";
import { createTag } from "../cross-platform/manageTags";
import { addTag } from "../cross-platform/tagUntag";
import { logReturnEmptyString } from "../helpers/errorHelpers";
import { cleanRawTagName } from "../helpers/tagHelpers";


/**
 * Addes the given tag to the last updated note.
 *
 * @param tagNameRaw The raw name of the tag before normalizing it.
 * @returns The contents of the note that was updated if the tag was added successfully; otherwise an empty string.
 */
export const tagLastNoteHelper = (tagNameRaw: string) => {
  const tagName = cleanRawTagName(tagNameRaw);

  // Get the most recent open note
  return getNotes(false, [], 1)
    .then((notes) => {
      if (notes.length > 0) {
        // There exists a note
        // Check if the tag name already exists
        return getTags(tagName)
          .then((tags) => {
            if (tags.length > 0) {
              // Tag already exists, add the tag to the note
              return addTag(notes[0].noteId, tags[0].tagId)
                .then((status) => (status ? notes[0].content : ""))
                .catch(logReturnEmptyString);
            } else {
              // Tag does not exists, create a new tag
              return createTag(tagName)
                .then((tagId) => {
                  // Add the new tag to the note
                  return addTag(notes[0].noteId, tagId)
                    .then((status) => (status ? notes[0].content : ""))
                    .catch(logReturnEmptyString);
                })
                .catch(logReturnEmptyString);
            }
          })
          .catch(logReturnEmptyString);
      } else {
        // No note exists to add a tag to
        console.log("There are no open notes to tag.");
        return "";
      }
    })
    .catch(logReturnEmptyString);
};

export const tagLastNoteHelperTest = functions.https.onRequest(
  (request, response) => {
    response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
    tagLastNoteHelper(request.body)
      .then((status) => response.status(200).send(status))
      .catch((err) => {
        console.log(err);
        response.status(500).send("Unable to add tag.");
      });
  }
);
