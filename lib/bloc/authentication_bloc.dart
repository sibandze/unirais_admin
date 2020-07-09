import 'dart:async';

import 'package:bloc/bloc.dart';

import './../const/_const.dart';
import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocAuthentication
    extends Bloc<BlocEventAuthentication, BlocStateAuthentication> {
  final UserRepository userRepository = UserRepository();

  @override
  BlocStateAuthentication get initialState => BlocStateAuthenticationUninitialized();

  @override
  Stream<BlocStateAuthentication> mapEventToState(
      BlocEventAuthentication event) async* {
    if (event is BlocEventAuthenticationAppStarted) {
      yield BlocStateAuthenticationUninitialized();
      final bool hasToken = await userRepository.hasToken();
      await Future.delayed(Duration(
        milliseconds: LOADING_DELAY_TIME,
      ));
      if (hasToken)
        yield BlocStateAuthenticationAuthenticated();
      else
        yield BlocStateAuthenticationUnauthenticated();
    } else if (event is BlocEventAuthenticationLoggedIn) {
      yield BlocStateAuthenticationLoading();
      await userRepository.persistToken(token: event.token);
      await Future.delayed(Duration(
        milliseconds: LOADING_DELAY_TIME,
      ));
      yield BlocStateAuthenticationAuthenticated();
    } else if (event is BlocEventAuthenticationLoggedOut) {
      yield BlocStateAuthenticationUninitialized();
      await userRepository.deleteToken();
      await Future.delayed(Duration(
        milliseconds: LOADING_DELAY_TIME,
      ));
      yield BlocStateAuthenticationUnauthenticated();
    }
  }
}
