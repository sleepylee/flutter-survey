import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:survey/api/graphql/query/profile_query.dart';
import 'package:survey/api/graphql/response/user_response.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/user.dart';

abstract class UserRepository {
  Future<User> getProfile();
}

class UserRepositoryImpl implements UserRepository {
  GraphQLClient _graphQlClient;

  UserRepositoryImpl(this._graphQlClient);

  @override
  Future<User> getProfile() async {
    final queryOptions = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
      document: gql(GET_PROFILE_QUERY),
    );
    return _graphQlClient.query(queryOptions).then((value) {
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
}
