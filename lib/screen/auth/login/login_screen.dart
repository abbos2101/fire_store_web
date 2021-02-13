import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static String route = "/login";

  static Widget screen() => BlocProvider(
        create: (context) => LoginBloc(context),
        child: LoginScreen(),
      );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: widgetBody(state),
      ),
    );
  }

  Widget widgetBody(LoginState state) {
    return Center(
      child: Container(
        width: 500,
        height: 420,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Parol",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: state is LoadingState
                  ? null
                  : () => bloc.add(SignEvent(
                        login: loginController.text,
                        password: passwordController.text,
                      )),
              minWidth: 200,
              height: 60,
              color: Colors.white,
              child: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 192,
              height: 5,
              child: state is LoadingState
                  ? LinearProgressIndicator(backgroundColor: Colors.grey)
                  : null,
            ),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () => bloc.add(SignupEvent()),
              minWidth: 200,
              height: 60,
              child: Text(
                "Ro'yxatdan o'tish",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
