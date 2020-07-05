import * as functions from "firebase-functions";
import { getNotes, getTags } from "../cross-platform/getNotesAndTags";
import { createTag } from "../cross-platform/manageTags";
import { addTag } from "../cross-platform/tagUntag";
import { logReturnFalse } from "../helpers/errorHelpers";

export const tagLastNoteHelper = (tagNameRaw: string) => {
  const tagName = tagNameRaw
    .toLowerCase()
    .replace(/ /g, "-")
    .replace(/[^a-z\d-]/g, "");

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
                .then((status) => status)
                .catch(logReturnFalse);
            } else {
              // Tag does not exists, create a new tag
              return createTag(tagName)
                .then((tagId) => {
                  // Add the new tag to the note
                  return addTag(notes[0].noteId, tagId)
                    .then((status) => status)
                    .catch(logReturnFalse);
                })
                .catch(logReturnFalse);
            }
          })
          .catch(logReturnFalse);
      } else {
        // No note exists to add a tag to
        console.log("There are no open notes to tag.");
        return false;
      }
    })
    .catch(logReturnFalse);
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
