import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final UserRepository userRepository = UserRepository();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  Future<int> getUser() async => 1;

  Future<void> deleteToken() async {
    /// delete from keychain/keystore
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey('token')) prefs.remove('token');
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<void> persistToken({@required String token}) async {
    /// write to keychain/keystore
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keychain/keystore
    await Future.delayed(Duration(seconds: 2));
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey('token');
  }
}
