
class FactModelFields {
  static const String id = "_id";
  static const String name = "name";
  static const String date = "phone";
  static const String imagePath = "imagePath";

  static const String catFactTable = "my_contacts";
}

class FactModelSql {
  int? id;
  final String name;
  final String date;
  final String imagePath;

  FactModelSql({
    this.id,
    required this.date,
    required this.name,
    required this.imagePath,
  });

  FactModelSql copyWith({
    String? name,
    String? date,
    String? imagePath,
    int? id,
  }) {
    return FactModelSql(
      name: name ?? this.name,
      date: date ?? this.date,
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
    );
  }

  factory FactModelSql.fromJson(Map<String, dynamic> json) {
    return FactModelSql(
      name: json[FactModelFields.name] ?? "",
      date: json[FactModelFields.date] ?? "",
      imagePath: json[FactModelFields.imagePath] ?? "",
      id: json[FactModelFields.id] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FactModelFields.name: name,
      FactModelFields.date: date,
      FactModelFields.imagePath: imagePath,
    };
  }

  @override
  String toString() {
    return '''
      name: $name
      phone: $date
      imagePath: $imagePath
      id: $id, 
    ''';
  }
}
