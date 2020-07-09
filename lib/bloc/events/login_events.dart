import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BlocEventLogin extends Equatable {
  final _props;
  const BlocEventLogin({props = const []}): _props=props;

  @override
  List<Object> get props => _props;

}

class BlocEventLoginButtonPressed extends BlocEventLogin {
  final String username;
  final String password;

  BlocEventLoginButtonPressed({
    @required this.username,
    @required this.password,
  }): super(props: [username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
