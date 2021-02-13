import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fire_store_web/data/hive/hive.dart';
import 'package:fire_store_web/data/net/auth_service.dart';
import 'package:fire_store_web/di/locator.dart';
import 'package:fire_store_web/screen/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final BuildContext context;

  final AuthService _authService = locator.get<AuthService>();
  final HiveDB _hiveDB = locator.get<HiveDB>();

  SignupBloc(this.context) : super(InitialState());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is RegisterEvent) yield* _eventRegister(event);
  }

  Stream<SignupState> _eventRegister(RegisterEvent event) async* {
    yield LoadingState();
    try {
      String userId = await _authService.onSignup(
        login: event.login,
        password: event.password,
        firstname: event.firstname,
        lastname: event.lastname,
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
