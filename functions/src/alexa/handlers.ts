import * as functions from "firebase-functions";
import { createNote } from "../cross-platform/manageNotes";
import { getNotesLimited } from "../cross-platform/getNotesAndTags";
import { Note } from "../@types";

export const alexaSkill = functions.https.onRequest((request, response) => {
  const type = JSON.stringify(request.body.request.type);
  let name = "";
  let note = "";
  let tag = "";
  let number = 0;

  try {
    name = JSON.stringify(request.body.request.intent.name);
    if (name == '"AddNote"') {
      note = JSON.stringify(request.body.request.intent.slots["note"].value);
    } else if (name == '"AddTag"') {
      tag = JSON.stringify(request.body.request.intent.slots["tag"].value);
    } else if (name == '"GetNotes"') {
      number = parseInt(
        JSON.stringify(request.body.request.intent.slots["number"].value)
      );
    } else if (name == '"GetTaggedNotes"') {
      // number = parseInt(
      //   JSON.stringify(request.body.request.intent.slots["number"].value)
      // );
      number = 5;
      tag = JSON.stringify(request.body.request.intent.slots["tag"].value);
    }
  } catch (e) {}
  const result = getAlexaResponse(type, name, note, tag, number);
  response.send(result);
});

const getAlexaResponse = (
  type: string,
  name: string,
  note: string,
  tag: string,
  number: number
) => {
  var AlexaDefaultAnswer = {
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

  if (type == '"LaunchRequest"') {
    return AlexaDefaultAnswer;
  } else if (type == '"IntentRequest"' && name == '"AddNote"') {
    createNote(note);
    AlexaDefaultAnswer.response.outputSpeech.ssml =
      "<speak>" + "Note added: " + note + "</speak>";
    AlexaDefaultAnswer.response.card.content = "Note added: " + note;
    return AlexaDefaultAnswer;
  } else if (type == '"IntentRequest"' && name == '"AddTag"') {
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
  } else if (type == '"IntentRequest"' && name == '"GetNotes"') {
    AlexaDefaultAnswer.response.outputSpeech.ssml =
      "<speak>" + "Getting your last " + number + " notes.";
    AlexaDefaultAnswer.response.card.content =
      "Getting your last " + number + " notes. \n";
    let notes: Note[] = [];
    return getNotesLimited([], number).then((value) => {
      notes = value;
      for (let i = 0; i < notes.length; i++) {
        AlexaDefaultAnswer.response.outputSpeech.ssml +=
          "<speak>" + "Note " + i + ": " + notes[i].content;
        AlexaDefaultAnswer.response.card.content +=
          "Note " + i + ": " + notes[i].content + "\n";
      }
      AlexaDefaultAnswer.response.outputSpeech.ssml += "</speak>";
      return AlexaDefaultAnswer;
    });
  } else if (type == '"IntentRequest"' && name == '"GetTaggedNotes"') {
    AlexaDefaultAnswer.response.outputSpeech.ssml =
      "<speak>" + "Getting your last " + number + " notes." + "</speak>";
    AlexaDefaultAnswer.response.card.content =
      "Getting your last " + number + " notes. \n";
    let notes: Note[] = [];
    return getNotesLimited([tag], number).then((value) => {
      notes = value;
      for (let i = 0; i < notes.length; i++) {
        AlexaDefaultAnswer.response.outputSpeech.ssml +=
          "<speak>" + "Note " + i + ": " + notes[i].content + "</speak>";
        AlexaDefaultAnswer.response.card.content +=
          "Note " + i + ": " + notes[i].content + "\n";
      }
      return AlexaDefaultAnswer;
    });
  } else {
    return AlexaDefaultAnswer;
  }
};
