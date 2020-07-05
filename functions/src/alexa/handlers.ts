import * as functions from "firebase-functions";
import { createNote } from "../cross-platform/manageNotes";
import { getNotes } from "../cross-platform/getNotesAndTags";
import { Note } from "../@types";

export const alexaSkill = functions.https.onRequest((request, response) => {
  const type = JSON.stringify(request.body.request.type);
  let name = "";
  let note = "";
  let tag = "";
  let number = 0;

  try {
    name = JSON.stringify(request.body.request.intent.name);
    if (name.indexOf("AddNote") >= 0) {
      note = JSON.stringify(request.body.request.intent.slots["note"].value);
    } else if (name.indexOf("AddTag") >= 0) {
      tag = JSON.stringify(request.body.request.intent.slots["tag"].value);
    } else if (name.indexOf("GetNotes") >= 0) {
      number = parseInt(
        JSON.stringify(request.body.request.intent.slots["number"].value)
      );
    } else if (name.indexOf("GetTaggedNotes") >= 0) {
      // number = parseInt(
      //   JSON.stringify(request.body.request.intent.slots["number"].value)
      // );
      number = 5;
      tag = JSON.stringify(request.body.request.intent.slots["tag"].value);
    }
  } catch (e) {}

  getAlexaResponse(type, name, note, tag, number)
    .then((results) => {
      response.status(200).send(results);
    })
    .catch((err) => {
      console.log(err);
      response
        .status(500)
        .send(
          "Sorry, but we're unable to fulfill your request at this time. Please try again later."
        );
    });
});

const getAlexaResponse = async (
  type: string,
  name: string,
  note: string,
  tag: string,
  number: number
) => {
  const AlexaDefaultAnswer = {
    version: "1.0",
    response: {
      outputSpeech: {
        type: "SSML",
        ssml:
          "<speak>Welcome to Brain Dump, you can give me any thoughts to remember.</speak>",
      },
      shouldEndSession: false,
      card: {
        type: "Simple",
        title: "LaunchRequest",
        content:
          "Welcome to Brain Dump, you can give me any thoughts to remember.",
      },
    },
    userAgent: "ask-node/2.3.0 Node/v8.10.0",
    sessionAttributes: {},
  };

  if (type.indexOf("LaunchRequest") >= 0) {
    return AlexaDefaultAnswer;
  } else if (
    type.indexOf("IntentRequest") >= 0 &&
    name.indexOf("AddTag") >= 0
  ) {
    AlexaDefaultAnswer.response.outputSpeech.ssml =
      "<speak>" +
      "Added tag: " +
      tag +
      "to: " +
      "your previous note" +
      "</speak>";
    AlexaDefaultAnswer.response.card.content =
      "Added tag: " + tag + " to: " + "your previous note";
    return AlexaDefaultAnswer;
  } else if (
    type.indexOf("IntentRequest") >= 0 &&
    name.indexOf("GetNotes") >= 0
  ) {
    AlexaDefaultAnswer.response.outputSpeech.ssml =
      "<speak>" + "Getting your last " + number + " notes.";
    AlexaDefaultAnswer.response.card.content =
      "Getting your last " + number + " notes. \n";
    return getNotes(false, [], number)
      .then((notes) => {
        for (let i = 0; i < notes.length; i++) {
          AlexaDefaultAnswer.response.outputSpeech.ssml +=
            "<speak>" + "Note " + i + ": " + notes[i].content;
          AlexaDefaultAnswer.response.card.content +=
            "Note " + i + ": " + notes[i].content + "\n";
        }
        AlexaDefaultAnswer.response.outputSpeech.ssml += "</speak>";
        return AlexaDefaultAnswer;
      })
      .catch((err) => {
        console.log(err);
        AlexaDefaultAnswer.response.outputSpeech.ssml =
          "<speak>There was an error completing your request. Please try again later.</speak>";
        AlexaDefaultAnswer.response.card.content =
          "There was an error completing your request. Please try again later.";
        return AlexaDefaultAnswer;
      });
  } else if (
    type.indexOf("IntentRequest") >= 0 &&
    name.indexOf("GetTaggedNotes") >= 0
  ) {
    AlexaDefaultAnswer.response.outputSpeech.ssml =
      "<speak>" + "Getting your last " + number + " notes." + "</speak>";
    AlexaDefaultAnswer.response.card.content =
      "Getting your last " + number + " notes. \n";
    let notes: Note[] = [];
    return getNotes(false, [tag], number)
      .then((value) => {
        notes = value;
        for (let i = 0; i < notes.length; i++) {
          AlexaDefaultAnswer.response.outputSpeech.ssml +=
            "<speak>" + "Note " + i + ": " + notes[i].content + "</speak>";
          AlexaDefaultAnswer.response.card.content +=
            "Note " + i + ": " + notes[i].content + "\n";
        }
        return AlexaDefaultAnswer;
      })
      .catch((err) => {
        console.log(err);
        AlexaDefaultAnswer.response.outputSpeech.ssml =
          "<speak>There was an error completing your request. Please try again later.</speak>";
        AlexaDefaultAnswer.response.card.content =
          "There was an error completing your request. Please try again later.";
        return AlexaDefaultAnswer;
      });
  } else {
    return AlexaDefaultAnswer;
  }
};
