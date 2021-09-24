import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/api/graphql/query/surveys_query.dart';
import 'package:survey/api/http/api_client.dart';
import 'package:survey/api/http/response/auth_token_response.dart';

import '../../fakers/fake_graphql_store.dart';
import '../../fakers/fake_token_storage.dart';
import '../../mocks/generate_mocks.mocks.dart';

main() {
  setUp(() {
    Get.testMode = true;
  });
  final queryOption = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(GET_SURVEYS_QUERY),
      variables: {'endCursor': ''});

  Get.put<Store>(FakeStore());
  final fakeTokenStorage = FakeTokenStorage();
  Get.put<TokenStorage<OAuth2Token>>(fakeTokenStorage);
  final mockApiClient = MockApiClient();
  Get.put<ApiClient>(mockApiClient);

  group('Validate GraphQLClient behaviors with invalid Authentication', () {
    test(
        'When making an unauthenticated request, it will try to refresh new token and retry',
        () async {
      final graphqlClientProvider = GraphQLClientProvider();
      graphqlClientProvider.tokenIsReadyToUse();

      when(mockApiClient.refreshToken(any)).thenAnswer(
        (_) async => AuthTokenResponseData(
          data: InnerResponseData.fromJson({
            'attributes': {
              'access_token': 'access_token',
              'token_type': 'bearer',
              'expires_in': 100,
              'refresh_token': 'refresh_token',
            }
          }),
        ),
      );

      final authenticatedClient = graphqlClientProvider.client;
      await authenticatedClient.query(queryOption);
      verify(mockApiClient.refreshToken(any)).called(1);
      graphqlClientProvider.removeAuthToken();
    });
  });

  group('Validate GraphQLClient behaviors with Authentication', () {
    final mockQueryManager = MockQueryManager();
    when(mockQueryManager.query(any))
        .thenAnswer((_) async => QueryResult.optimistic(
              data: {'result': 'success'},
            ));
    test('When making a positive request, it returns data', () async {
      final graphqlClientProvider = GraphQLClientProvider();
      final client = graphqlClientProvider.client;
      client.queryManager = mockQueryManager;

      final result = await client.query(queryOption);

      expect(result.data['result'], 'success');
      expect(result.hasException, false);
    });

    test('When making an authenticated request, it returns data', () async {
      final graphqlClientProvider = GraphQLClientProvider();
      graphqlClientProvider.tokenIsReadyToUse();

      final authenticatedClient = graphqlClientProvider.client;
      authenticatedClient.queryManager = mockQueryManager;

      final result = await authenticatedClient.query(queryOption);

      expect(result.data['result'], 'success');
      expect(result.hasException, false);
    });
  });
}
