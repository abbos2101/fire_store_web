import 'package:fire_store_web/data/net/main_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static String route = "/main";

  static Widget screen() => MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainService mainService = MainService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter kursi")),
      // body: StreamBuilder(
      //   stream: mainService.onGetMenu(),
      //   builder: (context, snapshot) {
      //     if (snapshot.data == null) return Center(child: Text("null"));
      //     if (snapshot.data == true) return Center(child: Text("null"));
      //     return Center(child: Text("Xato"));
      //   },
      // ),
    );
  }
}
