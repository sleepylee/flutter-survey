import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/preferences/shared_preferences.dart';

main() {
  group('Validate SharedPreferences read/write operator', () {
    final localSharedPref = LocalSharedPreferencesStorage();
    // Initialize the key:value of the sharedPref to run unit test without a device
    SharedPreferences.setMockInitialValues({});

    test('When read and write TokenType, it returns value correctly', () async {
      var result = await localSharedPref.getTokenType();
      expect(result, null);

      await localSharedPref.saveTokenType("token type");
      result = await localSharedPref.getTokenType();
      expect(result, "token type");
    });

    test('When read and write AccessToken, it returns value correctly',
        () async {
      var result = await localSharedPref.getAccessToken();
      expect(result, null);

      await localSharedPref.saveAccessToken("access token");
      result = await localSharedPref.getAccessToken();
      expect(result, "access token");
    });

    test('When read and write RefreshToken, it returns value correctly',
        () async {
      var result = await localSharedPref.getRefreshToken();
      expect(result, null);

      await localSharedPref.saveRefreshToken("refresh token");
      result = await localSharedPref.getRefreshToken();
      expect(result, "refresh token");
    });

    test('When read and write TokenExpiration, it returns value correctly',
        () async {
      var result = await localSharedPref.getTokenExpiration();
      expect(result, 0);

      await localSharedPref.saveTokenExpiration(300);
      result = await localSharedPref.getTokenExpiration();
      expect(result, 300);
    });

    test('When delete storage, it erases everything', () async {
      localSharedPref.delete();

      expect(await localSharedPref.getTokenType(), null);
      expect(await localSharedPref.getAccessToken(), null);
      expect(await localSharedPref.getRefreshToken(), null);
      expect(await localSharedPref.getTokenExpiration(), 0);
    });

    test('When read/write OAuth2Token, it returns correctly', () async {
      await localSharedPref.write(
        OAuth2Token(
            accessToken: "accessToken",
            tokenType: "bearer",
            refreshToken: "refreshToken",
            expiresIn: 300),
      );

      final result = await localSharedPref.read();

      expect(result, isA<OAuth2Token>());
      expect(result.tokenType, "bearer");
      expect(result.accessToken, "accessToken");
      expect(result.refreshToken, "refreshToken");
      expect(result.expiresIn, 300);
    });
  });
}
