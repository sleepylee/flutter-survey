import 'package:flutter_test/flutter_test.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';

class FakeGraphQLClientProvider extends Fake implements GraphQLClientProvider {
  @override
  void tokenIsReadyToUse() {
    // do nothing for now
  }
}
