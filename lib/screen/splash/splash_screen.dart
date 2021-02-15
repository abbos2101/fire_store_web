import 'package:fire_store_web/data/hive/hive.dart';
import 'package:fire_store_web/di/locator.dart';
import 'package:fire_store_web/screen/auth/login/login_screen.dart';
import 'package:fire_store_web/screen/main/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String route = "/";

  static Widget screen() => SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HiveDB hiveDB = locator.get<HiveDB>();

  @override
  void initState() {
    launch();
    super.initState();
  }

  void launch() async {
    await Future.delayed(Duration.zero);
    while (Navigator.canPop(context)) Navigator.pop(context);
    if (await hiveDB.getUserId() == null)
      Navigator.pushReplacementNamed(context, LoginScreen.route);
    else
      Navigator.pushReplacementNamed(context, MainScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
