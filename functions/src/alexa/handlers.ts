import * as functions from "firebase-functions";
import { createNote } from "../cross-platform/manageNotes";

export const alexaSkill = functions.https.onRequest((request, response) => {
  const type = JSON.stringify(request.body.request.type);
  let name = "";

  try {
    name = JSON.stringify(request.body.request.intent.name);
  } catch (e) {}

  let note = "";

  if (type == '"IntentRequest"') {
    note = JSON.stringify(request.body.request.intent.slots["note"].value);
  }
  const result = getAlexaResponse(type, name, note);
  response.send(result);
});

const getAlexaResponse = (type: string, name: string, note: string) => {
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
  } else {
    return AlexaDefaultAnswer;
  }
};
