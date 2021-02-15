import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel {
  final int id;
  final String name;
  final String description;
  final String type;

  const ContentModel({this.id, this.name, this.description, this.type});

  factory ContentModel.fromDoc(QueryDocumentSnapshot doc) {
    int id = 0;
    String name = "";
    String description = "";
    String type = "";
    try {
      id = int.parse(doc["id"].toString());
      name = doc["name"];
      description = doc["description"];
      type = doc["type"];
    } catch (_) {}
    return ContentModel(
      id: id,
      name: name,
      description: description,
      type: type,
    );
  }
}
