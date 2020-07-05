import * as functions from "firebase-functions";
import { getNotes } from "../cross-platform/getNotesAndTags";
import {
  deleteNote,
  editNoteCompleteness,
  editNoteOrder,
} from "../cross-platform/manageNotes";

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

export const editNoteCompletenessFlutter = functions.https.onRequest(
  (request, response) => {
    response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
    const requestBody = JSON.parse(request.body) as {
      noteId: string;
      complete: boolean;
    };
    editNoteCompleteness(requestBody.noteId, requestBody.complete)
      .then((status) => response.status(200).send(status))
      .catch((err) => {
        console.log(err);
        response.status(500).send("Unable to update completeness.");
      });
  }
);

export const editNoteOrderFlutter = functions.https.onRequest(
  (request, response) => {
    response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
    const requestBody = JSON.parse(request.body) as {
      noteId: string;
      order: number;
    };

    editNoteOrder(requestBody.noteId, requestBody.order)
      .then((status) => response.status(200).send(status))
      .catch((err) => {
        console.log(err);
        response.status(500).send("Unable to update order.");
      });
  }
);

export const deleteNoteFlutter = functions.https.onRequest(
  (request, response) => {
    response.setHeader("Access-Control-Allow-Origin", "*"); // TODO: Make more secure later!
    deleteNote(request.body)
      .then((status) => response.status(200).send(status))
      .catch((err) => {
        console.log(err);
        response.status(500).send("Unable to delete note.");
      });
  }
);
