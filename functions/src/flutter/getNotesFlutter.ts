import * as functions from "firebase-functions";
import { getNotes } from "../cross-platform/getNotesAndTags";

export const getNotesFlutter = functions.https.onRequest(
  (request, response) => {
    response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
    const requestBody = JSON.parse(request.body) as {
      complete: boolean;
      tags: string[];
    };
    getNotes(requestBody.complete, requestBody.tags ? requestBody.tags : [])
      .then((notes) => response.status(200).send({ notes }))
      .catch((err) => {
        console.log(err);
        response.status(500).send("Unable to get notes.");
      });
  }
);
