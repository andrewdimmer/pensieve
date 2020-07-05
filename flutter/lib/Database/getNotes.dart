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
