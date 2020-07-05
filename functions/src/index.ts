import { alexaSkill } from "./alexa/handlers";
import { tagLastNoteHelperTest } from "./alexa/tagLastNoteHelper";
import {
  deleteNoteFlutter,
  editNoteCompletenessFlutter,
  getNotesFlutter,
} from "./flutter/manageNotesFlutter";

// Alexa Skill
export const alexa_handlers = alexaSkill;

// Flutter App
export const get_notes_flutter = getNotesFlutter;
export const edit_note_completeness_flutter = editNoteCompletenessFlutter;
export const delete_note_flutter = deleteNoteFlutter;

// Test
export const tag_last_note_helper_test = tagLastNoteHelperTest;
