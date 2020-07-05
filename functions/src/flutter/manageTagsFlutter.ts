import * as functions from "firebase-functions";
import { getTags } from "../cross-platform/getNotesAndTags";
import { addTag, removeTag } from "../cross-platform/tagUntag";

export const getTagsFlutter = functions.https.onRequest((request, response) => {
  response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
  getTags()
    .then((tags) => response.status(200).send({ tags }))
    .catch((err) => {
      console.log(err);
      response.status(500).send("Unable to get tags.");
    });
});

export const addTagFlutter = functions.https.onRequest((request, response) => {
  response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
  const requestBody = JSON.parse(request.body) as {
    noteId: string;
    tagId: string;
  };
  addTag(requestBody.noteId, requestBody.tagId)
    .then((status) => response.status(200).send(status))
    .catch((err) => {
      console.log(err);
      response.status(500).send("Unable to update completeness.");
    });
});

export const removeTagFlutter = functions.https.onRequest(
  (request, response) => {
    response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
    const requestBody = JSON.parse(request.body) as {
      noteId: string;
      tagId: string;
    };
    removeTag(requestBody.noteId, requestBody.tagId)
      .then((status) => response.status(200).send(status))
      .catch((err) => {
        console.log(err);
        response.status(500).send("Unable to update completeness.");
      });
  }
);
