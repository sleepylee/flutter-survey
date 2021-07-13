import 'package:mockito/mockito.dart' as _i1;
import 'package:survey/models/auth_token.dart' as _i2;
import 'package:survey/repositories/oauth_repository.dart' as _i3;
import 'dart:async' as _i4;

class _FakeAuthToken extends _i1.Fake implements _i2.AuthToken {}

/// A class which mocks [OAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOAuthRepository extends _i1.Mock implements _i3.OAuthRepository {
  MockOAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.AuthToken> login(String? email, String? password) =>
      super.noSuchMethod(Invocation.method(#login, [email, password]),
          Future.value(_FakeAuthToken()));
}
