import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:mockito/mockito.dart';

class FakeTokenStorage extends Fake implements TokenStorage<OAuth2Token> {
  @override
  Future<OAuth2Token> read() async {
    return OAuth2Token(accessToken: 'fake token');
  }
}
