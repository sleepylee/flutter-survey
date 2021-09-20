import 'package:dio/src/adapter.dart' as _i7;
import 'package:graphql/src/core/query_manager.dart' as _i8;
import 'package:graphql/src/graphql_client.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:survey/api/http/api_client.dart' as _i6;
import 'package:survey/repositories/oauth_repository.dart' as _i3;
import 'package:survey/repositories/user_repository.dart' as _i2;
import 'package:survey/use_cases/get_profile_use_case.dart' as _i5;

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

/// A class which mocks [GetProfileUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProfileUseCase extends _i1.Mock implements _i5.GetProfileUseCase {
  MockGetProfileUseCase() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [ApiClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiClient extends _i1.Mock implements _i6.ApiClient {
  MockApiClient() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [HttpClientAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClientAdapter extends _i1.Mock implements _i7.HttpClientAdapter {
  MockHttpClientAdapter() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [QueryManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockQueryManager extends _i1.Mock implements _i8.QueryManager {
  MockQueryManager() {
    _i1.throwOnMissingStub(this);
  }
}
