import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<String> onLogin({
    @required String login,
    @required String password,
  }) async {
    if ((login ?? "").isEmpty || (password ?? "").isEmpty)
      throw Exception("Ma'lumotlar to'liq emas");

    final QuerySnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .where("login", isEqualTo: "$login")
        .where("password", isEqualTo: "$password")
        .get()
        .timeout(Duration(seconds: 30));

    if (data.size == 0) throw Exception("Login yoki parolda xatolik mavjud");
    return data.docs[0].id;
  }

  Future<String> onSignup({
    @required String lastname,
    @required String firstname,
    @required String login,
    @required String password,
  }) async {
    if ((lastname ?? "").isEmpty ||
        (firstname ?? "").isEmpty ||
        (login ?? "").isEmpty ||
        (password ?? "").isEmpty) throw Exception("Ma'lumotlar to'liq emas");

    final QuerySnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .where("login", isEqualTo: "$login")
        .get()
        .timeout(Duration(seconds: 30));
    if (data.size != 0) throw Exception("Bunday foydalanuvchi mavjud");

    await FirebaseFirestore.instance.collection("users").add({
      "lastname": "$lastname",
      "firstname": "$firstname",
      "login": "$login",
      "password": "$password",
    }).timeout(Duration(seconds: 30));

    return await onLogin(login: login, password: password);
  }
}
