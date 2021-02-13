part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignEvent extends LoginEvent {
  final String login;
  final String password;

  SignEvent({this.login, this.password});
}

class SignupEvent extends LoginEvent {}
