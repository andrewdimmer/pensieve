import { alexaSkill } from "./alexa/handlers";
import { tagLastNoteHelperTest } from "./alexa/tagLastNoteHelper";
import {
  deleteNoteFlutter,
  editNoteCompletenessFlutter,
  editNoteOrderFlutter,
  getNotesFlutter,
} from "./flutter/manageNotesFlutter";
import {
  addTagFlutter,
  getTagsFlutter,
  removeTagFlutter,
} from "./flutter/manageTagsFlutter";

// Alexa Skill
export const alexa_handlers = alexaSkill;

// Flutter App
export const get_notes_flutter = getNotesFlutter;
export const get_tags_flutter = getTagsFlutter;
export const edit_note_completeness_flutter = editNoteCompletenessFlutter;
export const edit_note_order_flutter = editNoteOrderFlutter;
export const delete_note_flutter = deleteNoteFlutter;
export const add_tag_flutter = addTagFlutter;
export const remove_tag_flutter = removeTagFlutter;

// Test
export const tag_last_note_helper_test = tagLastNoteHelperTest;
