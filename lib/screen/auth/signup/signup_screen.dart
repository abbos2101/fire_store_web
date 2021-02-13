import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/signup_bloc.dart';

class SignupScreen extends StatefulWidget {
  static String route = "/signup";

  static Widget screen() => BlocProvider(
        create: (context) => SignupBloc(context),
        child: SignupScreen(),
      );

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupBloc bloc;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<SignupBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    loginController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: widgetBody(state),
      ),
    );
  }

  Widget widgetBody(SignupState state) {
    return Center(
      child: Container(
        width: 500,
        height: 450,
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
              "Ro'yxatdan o'tish",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Familiya",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Ism",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
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
                  : () => bloc.add(RegisterEvent(
                        login: loginController.text,
                        password: passwordController.text,
                        lastname: lastnameController.text,
                        firstname: firstnameController.text,
                      )),
              minWidth: 200,
              height: 60,
              color: Colors.white,
              child: Text(
                "Ro'yxatdan o'tish",
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
          ],
        ),
      ),
    );
  }
}
