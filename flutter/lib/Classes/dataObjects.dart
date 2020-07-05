class NoteObject {
  NoteObject({this.noteId, this.content, this.order, this.tags, this.complete});

  final String noteId;
  String content;
  int order;
  List<String> tags;
  bool complete;

  factory NoteObject.fromJson(Map<String, dynamic> json) {
    return NoteObject(
      noteId: json["noteId"],
      content: json["content"],
      order: json["order"],
      tags: (json["tags"]).map<String>((tag) => tag.toString()).toList(),
      complete: json["complete"],
    );
  }
}

class TagObject {
  TagObject({this.tagId, this.tagName});

  final String tagId;
  String tagName;

  factory TagObject.fromJson(Map<String, dynamic> json) {
    return TagObject(
      tagId: json["tagId"],
      tagName: json["tagName"],
    );
  }
}
