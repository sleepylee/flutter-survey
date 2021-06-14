import 'package:shared_preferences/shared_preferences.dart';

const String _PREF_KEY_TYPE = 'PREF_KEY_TYPE';
const String _PREF_KEY_ACCESS_TOKEN = 'PREF_KEY_TOKEN';
const String _PREF_KEY_REFRESH_TOKEN = 'PREF_KEY_REFRESH_TOKEN';
const String _PREF_KEY_TOKEN_EXPIRATION = 'PREF_KEY_TOKEN_EXPIRATION';

abstract class SharedPreferencesStorage {
  Future<String> getTokenType();

  Future<void> saveTokenType(String tokenType);

  Future<String> getAccessToken();

  Future<void> saveAccessToken(String token);

  Future<String> getRefreshToken();

  Future<void> saveRefreshToken(String refreshToken);

  Future<double> getTokenExpiration();

  Future<void> saveTokenExpiration(int expiration);
}

// TODO: switch to secured_storage: https://pub.dev/packages/flutter_secure_storage
class LocalSharedPreferencesStorage implements SharedPreferencesStorage {
  @override
  Future<void> saveTokenType(String tokenType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_PREF_KEY_TYPE, tokenType);
  }

  @override
  Future<String> getTokenType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_KEY_TYPE);
  }

  @override
  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_KEY_ACCESS_TOKEN);
  }

  @override
  Future<void> saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_PREF_KEY_ACCESS_TOKEN, token);
  }

  @override
  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_KEY_REFRESH_TOKEN);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_PREF_KEY_REFRESH_TOKEN, refreshToken);
  }

  @override
  Future<double> getTokenExpiration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_PREF_KEY_TOKEN_EXPIRATION) ?? 0;
  }

  @override
  Future<void> saveTokenExpiration(int expiration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(_PREF_KEY_TOKEN_EXPIRATION, expiration);
  }
}
