part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class RegisterEvent extends SignupEvent {
  final String lastname;
  final String firstname;
  final String login;
  final String password;

  RegisterEvent({this.lastname, this.firstname, this.login, this.password});
}
