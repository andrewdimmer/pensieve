import { alexaSkill } from "./alexa/handlers";
import { tagLastNoteHelperTest } from "./alexa/tagLastNoteHelper";
import { getNotesFlutter } from "./flutter/getNotesFlutter";

// Alexa Skill
export const alexa_handlers = alexaSkill;

// Flutter App
export const get_notes_flutter = getNotesFlutter;

// Test
export const tag_last_note_helper_test = tagLastNoteHelperTest;
