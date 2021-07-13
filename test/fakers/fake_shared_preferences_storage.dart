import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey/preferences/shared_preferences.dart';

class FakeSharedPreferencesStorage extends Fake
    implements SharedPreferencesStorage {
  Map<String, dynamic> _fakeStorage = HashMap();

  @override
  Future<bool> saveTokenType(String tokenType) async {
    _fakeStorage['token-type'] = tokenType;
    return true;
  }

  @override
  Future<bool> saveAccessToken(String token) async {
    _fakeStorage['access-token'] = token;
    return true;
  }

  @override
  Future<bool> saveTokenExpiration(int expiration) async {
    _fakeStorage['expires-in'] = expiration;
    return true;
  }

  @override
  Future<bool> saveRefreshToken(String refreshToken) async {
    _fakeStorage['refresh-token'] = refreshToken;
    return true;
  }
}
