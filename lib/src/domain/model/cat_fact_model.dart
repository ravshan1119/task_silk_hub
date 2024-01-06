class CatFactModel {
  String id;
  int v;
  String text;
  DateTime updatedAt;
  bool deleted;
  String source;
  int sentCount;

  CatFactModel({
    required this.id,
    required this.v,
    required this.text,
    required this.updatedAt,
    required this.deleted,
    required this.source,
    required this.sentCount,
  });

  CatFactModel copyWith({
    String? id,
    int? v,
    String? text,
    DateTime? updatedAt,
    bool? deleted,
    String? source,
    int? sentCount,
  }) =>
      CatFactModel(
        id: id ?? this.id,
        v: v ?? this.v,
        text: text ?? this.text,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted,
        source: source ?? this.source,
        sentCount: sentCount ?? this.sentCount,
      );

  factory CatFactModel.fromJson(Map<String, dynamic> json) => CatFactModel(
        id: json["_id"] as String? ?? "",
        v: json["__v"] as int? ?? 0,
        text: json["text"] as String? ?? "",
        updatedAt: DateTime.parse(json["updatedAt"] as String? ?? ""),
        deleted: json["deleted"] as bool? ?? false,
        source: json["source"] as String? ?? "",
        sentCount: json["sentCount"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "__v": v,
        "text": text,
        "updatedAt": updatedAt.toIso8601String(),
        "deleted": deleted,
        "source": source,
        "sentCount": sentCount,
      };
}
