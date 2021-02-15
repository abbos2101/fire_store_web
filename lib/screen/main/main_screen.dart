import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_store_web/data/model/content_model.dart';
import 'package:fire_store_web/data/model/menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static String route = "/main";

  static Widget screen() => MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Stream<QuerySnapshot> menuStream =
      FirebaseFirestore.instance.collection("items").orderBy("id").snapshots();

  int menuId = 0;
  String contentUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter kursi")),
      body: Row(
        children: [
          Expanded(child: widgetMenu()),
          Expanded(flex: 3, child: widgetBody()),
        ],
      ),
    );
  }

  Widget widgetMenu() {
    return StreamBuilder(
      stream: menuStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (!snapshot.hasData) return SizedBox();

        ///
        final List<MenuModel> menuList = (snapshot.data.docs as List)
            .map((e) => MenuModel.fromDoc(e))
            .toList();
        return Container(
          margin: EdgeInsets.only(right: 2),
          color: Colors.blueGrey[300],
          child: ListView.builder(
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                margin: EdgeInsets.all(2),
                color: index != menuId ? Colors.white : Colors.grey[300],
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      contentUrl = menuList[index].content;
                      menuId = index;
                    });
                  },
                  child: Text(
                    "${menuList[index].nameEn}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget widgetBody() {
    if (contentUrl.isEmpty) return Center(child: Text("Ma'lumot mavjud emas"));
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("$contentUrl")
          .orderBy("id")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(child: Text("Ma'lumot mavjud emas"));
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (!snapshot.hasData)
          return Center(child: Text("Ma'lumot mavjud emas"));

        ///
        final List<ContentModel> contentList = (snapshot.data.docs as List)
            .map((e) => ContentModel.fromDoc(e))
            .toList();
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 300,
              childAspectRatio: 3 / 2,
            ),
            itemCount: contentList.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(child: SizedBox(width: double.infinity)),
                      Text(
                        "${contentList[index].name}",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        flex: 3,
                        child: Text("${contentList[index].description}"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
