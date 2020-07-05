class NoteObject {
  NoteObject({this.noteId, this.content, this.order, this.tags, this.complete});

  final String noteId;
  final String content;
  final int order;
  final List<String> tags;
  final bool complete;

  factory NoteObject.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return NoteObject(
      noteId: json["noteId"],
      content: json["content"],
      order: json["order"],
      tags: List<String>(json["tags"]),
      complete: json["complete"],
    );
  }
}

class TagObject {
  TagObject({this.tagId, this.tagName});

  final String tagId;
  final String tagName;

  factory TagObject.fromJson(Map<String, dynamic> json) {
    return TagObject(
      tagId: json["tagId"],
      tagName: json["tagName"],
    );
  }
}
