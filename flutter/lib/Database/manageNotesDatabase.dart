import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pensieve/Classes/dataObjects.dart';

Future<List<NoteObject>> getNotesFromDatabase(
    bool complete, List<String> tags) async {
  final response = await http.post(
      'https://us-central1-hackcation2020-gcp.cloudfunctions.net/get_notes_flutter',
      body: '{"tags": ' +
          tags.toString() +
          ', "complete": ' +
          complete.toString() +
          '}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> notes = json.decode(response.body)["notes"];
    return notes.map((note) {
      return NoteObject.fromJson(json.decode(json.encode(note)));
    }).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    throw Exception('Failed to get notes.');
  }
}

Future<bool> editNoteCompletenessDatabase(String noteId, bool complete) async {
  final response = await http.post(
      'https://us-central1-hackcation2020-gcp.cloudfunctions.net/edit_note_completeness_flutter',
      body: '{"noteId": "' +
          noteId +
          '", "complete": ' +
          complete.toString() +
          '}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body) as bool;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    throw Exception('Failed to update note.');
  }
}

Future<bool> editNoteOrderDatabase(String noteId, int order) async {
  final response = await http.post(
      'https://us-central1-hackcation2020-gcp.cloudfunctions.net/edit_note_order_flutter',
      body: '{"noteId": "' + noteId + '", "order": ' + order.toString() + '}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body) as bool;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    throw Exception('Failed to update note.');
  }
}

Future<bool> deleteNoteDatabase(String noteId) async {
  final response = await http.post(
      'https://us-central1-hackcation2020-gcp.cloudfunctions.net/delete_note_flutter',
      body: noteId);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body) as bool;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    throw Exception('Failed to delete note.');
  }
}
