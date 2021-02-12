import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static Widget screen() => MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fire Store"), centerTitle: true),
      body: StreamBuilder(
        stream: Firestore.instance.collection("movies").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData == null)
            return Center(child: Text("NULL"));
          else if (!snapshot.hasData)
            return Center(child: Text("No data"));
          else
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => ListTile(
                title: Text("${snapshot.data.documents[index]["name"]}"),
                subtitle: Text("${snapshot.data.documents[index]["votes"]}"),
              ),
            );
        },
      ),
    );
  }
}
