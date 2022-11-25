import 'dart:convert';

/// Album model.
class Album {
  Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  final int id;
  final int userId;
  final String title;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) =>
      Album.fromMap(json.decode(source) as Map<String, dynamic>);
}
