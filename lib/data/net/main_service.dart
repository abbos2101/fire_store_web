import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_store_web/data/model/menu_model.dart';

class MainService {
  Future<List<MenuModel>> onGetMenu() async {
    final collection = await FirebaseFirestore.instance
        .collection("items")
        .get()
        .timeout(Duration(seconds: 30));
    return (collection.docs).map(
      (e) => MenuModel(
        id: e["id"],
        name: e["name"],
        type: e["type"],
        icon: e["icon"],
      ),
    );
  }
}
