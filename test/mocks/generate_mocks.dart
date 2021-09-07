import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:survey/repositories/oauth_repository.dart';
import 'package:survey/repositories/user_repository.dart';

@GenerateMocks([UserRepository, OAuthRepository, GraphQLClient])
main() {
  // empty class to generate mock repository classes
}
