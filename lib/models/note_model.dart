class Note {
  int id;
  String contents;

  Note({this.id, this.contents});

  factory Note.fromJSON(Map<String, dynamic> json) => Note(
        id: json["id"],
        contents: json["contents"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "contents": contents,
    };
  }
}
