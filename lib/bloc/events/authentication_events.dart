import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BlocEventAuthentication extends Equatable {
  final List _props;

  BlocEventAuthentication([this._props = const []]);

  @override
  List<Object> get props => _props;
}

class BlocEventAuthenticationAppStarted extends BlocEventAuthentication {
  @override
  String toString() => 'AppStarted';
}

class BlocEventAuthenticationLoggedIn extends BlocEventAuthentication {
  final String token;

  BlocEventAuthenticationLoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn {token: $token}';
}

class BlocEventAuthenticationLoggedOut extends BlocEventAuthentication {
  @override
  String toString() => 'LoggedOut';
}