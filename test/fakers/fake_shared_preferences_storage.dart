import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:survey/preferences/shared_preferences.dart';

class FakeSharedPreferencesStorage extends Fake
    implements SharedPreferencesStorage {
  Map<String, dynamic> _fakeStorage = HashMap();

  @override
  Future<void> saveTokenType(String tokenType) async {
    _fakeStorage['token-type'] = tokenType;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    _fakeStorage['access-token'] = token;
  }

  @override
  Future<void> saveTokenExpiration(int expiration) async {
    _fakeStorage['expires-in'] = expiration;
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    _fakeStorage['refresh-token'] = refreshToken;
  }
}
