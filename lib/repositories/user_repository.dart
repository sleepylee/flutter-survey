import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/api/graphql/query/profile_query.dart';
import 'package:survey/api/graphql/response/user_response.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/user.dart';
import 'package:survey/preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<User> getProfile();

  Future<bool> isLoggedIn();
}

class UserRepositoryImpl implements UserRepository {
  GraphQLClientProvider _graphQLClientProvider;
  SharedPreferencesStorage _sharedPreferencesStorage;

  UserRepositoryImpl(
      this._graphQLClientProvider, this._sharedPreferencesStorage);

  @override
  Future<User> getProfile() async {
    final queryOptions = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
      document: gql(GET_PROFILE_QUERY),
    );
    return _graphQLClientProvider.client.query(queryOptions).then((value) {
      if (value.data != null) {
        final response = UserResponse.fromJson(value.data['profile']);
        return User(
          id: response.id,
          email: response.email,
          avatarUrl: response.avatarUrl,
        );
      } else {
        throw NetworkExceptions.fromDioException(value);
      }
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    final refreshToken = await _sharedPreferencesStorage.getRefreshToken();
    final hasValidTokenStored = refreshToken != null && refreshToken.isNotEmpty;
    if (hasValidTokenStored) {
      _graphQLClientProvider.tokenIsReadyToUse();
    }
    return hasValidTokenStored;
  }
}
