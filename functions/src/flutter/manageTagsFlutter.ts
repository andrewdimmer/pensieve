import * as functions from "firebase-functions";
import { getTags } from "../cross-platform/getNotesAndTags";

export const getTagsFlutter = functions.https.onRequest((request, response) => {
  response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
  getTags()
    .then((tags) => response.status(200).send({ tags }))
    .catch((err) => {
      console.log(err);
      response.status(500).send("Unable to get tags.");
    });
});
