import 'package:graphql/src/graphql_client.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:survey/repositories/oauth_repository.dart' as _i3;
import 'package:survey/repositories/user_repository.dart' as _i2;

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i2.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [OAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOAuthRepository extends _i1.Mock implements _i3.OAuthRepository {
  MockOAuthRepository() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [GraphQLClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockGraphQLClient extends _i1.Mock implements _i4.GraphQLClient {
  MockGraphQLClient() {
    _i1.throwOnMissingStub(this);
  }
}