import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  final int id;
  final String nameEn;
  final String nameUz;
  final String type;
  final String icon;
  final String content;

  const MenuModel({
    this.id,
    this.type,
    this.nameEn,
    this.nameUz,
    this.icon,
    this.content,
  });

  factory MenuModel.fromDoc(QueryDocumentSnapshot doc) {
    int id = 0;
    String nameEn = "";
    String nameUz = "";
    String type = "";
    String icon = "";
    String content = "";
    try {
      id = int.parse(doc["id"].toString());
      nameEn = doc["name_uz"];
      nameUz = doc["name_en"];
      type = doc["type"];
      icon = doc["icon"];
      content = doc["content"];
    } catch (_) {}
    return MenuModel(
      id: id,
      nameUz: nameUz,
      nameEn: nameEn,
      type: type,
      icon: icon,
      content: content,
    );
  }
}
