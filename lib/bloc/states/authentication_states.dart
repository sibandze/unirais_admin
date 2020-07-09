import 'package:equatable/equatable.dart';

abstract class BlocStateAuthentication extends Equatable {
  final _props;

  BlocStateAuthentication({props=const[]}):this._props=props;

  @override
  List<Object> get props => _props;
}

class BlocStateAuthenticationUninitialized extends BlocStateAuthentication {}

class BlocStateAuthenticationAuthenticated extends BlocStateAuthentication {}

class BlocStateAuthenticationUnauthenticated extends BlocStateAuthentication {}

class BlocStateAuthenticationLoading extends BlocStateAuthentication {}
