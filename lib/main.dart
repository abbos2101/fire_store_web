import 'package:flutter/material.dart';
import 'di/locator.dart';
import 'screen/splash/splash_screen.dart';
import 'screen/auth/login/login_screen.dart';
import 'screen/auth/signup/signup_screen.dart';
import 'screen/main/main_screen.dart';

void main() {
  locatorSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: LoginScreen.screen(),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (_) => SplashScreen.screen(),
        LoginScreen.route: (_) => LoginScreen.screen(),
        SignupScreen.route: (_) => SignupScreen.screen(),
        MainScreen.route: (_) => MainScreen.screen(),
      },
    );
  }
}
