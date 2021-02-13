import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fire_store_web/data/hive/hive.dart';
import 'package:fire_store_web/data/net/auth_service.dart';
import 'package:fire_store_web/di/locator.dart';
import 'package:fire_store_web/screen/auth/signup/signup_screen.dart';
import 'package:fire_store_web/screen/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BuildContext context;

  final AuthService _authService = locator.get<AuthService>();
  final HiveDB _hiveDB = locator.get<HiveDB>();

  LoginBloc(this.context) : super(InitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignEvent)
      yield* _eventSign(event);
    else if (event is SignupEvent)
      Navigator.pushNamed(context, SignupScreen.route);
  }

  Stream<LoginState> _eventSign(SignEvent event) async* {
    yield LoadingState();
    try {
      String userId = await _authService.onLogin(
        login: event.login,
        password: event.password,
      );
      await _hiveDB.saveUserId(userId);
      yield SuccessState();
      while (Navigator.canPop(context)) Navigator.pop(context);
      Navigator.pushReplacementNamed(context, MainScreen.route);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        webShowClose: true,
      );
      yield FailState(message: "$e");
    }
  }
}
