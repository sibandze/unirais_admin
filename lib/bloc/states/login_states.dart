import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final List _props;

  LoginState([this._props = const []]);

  @override
  List<Object> get props => _props;
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginSuccess extends LoginState {}
