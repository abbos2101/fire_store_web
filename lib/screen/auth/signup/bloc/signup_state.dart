part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class InitialState extends SignupState {}

class LoadingState extends SignupState {}

class SuccessState extends SignupState {}

class FailState extends SignupState {
  final String message;

  FailState({this.message});
}
