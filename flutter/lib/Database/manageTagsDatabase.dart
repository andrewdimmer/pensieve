import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pensieve/Classes/dataObjects.dart';

Future<List<TagObject>> getTagsFromDatabase() async {
  final response = await http.get(
    'https://us-central1-hackcation2020-gcp.cloudfunctions.net/get_tags_flutter',
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> tags = json.decode(response.body)["tags"];
    return tags.map((tag) {
      return TagObject.fromJson(json.decode(json.encode(tag)));
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
