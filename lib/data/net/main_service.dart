import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_store_web/data/model/menu_model.dart';

class MainService {
  final StreamController<List<MenuModel>> subscription = StreamController();

  void dispose() {
    subscription.close();
  }

  void onGetMenu() async {
    final QuerySnapshot collection = await FirebaseFirestore.instance
        .collection("items")
        .orderBy("id")
        .get();
    subscription.add(
      (collection.docs).map((e) => MenuModel.fromDoc(e)).toList(),
    );
    //yield (collection.docs).map((e) => MenuModel.fromDoc(e)).toList();
  }
}
