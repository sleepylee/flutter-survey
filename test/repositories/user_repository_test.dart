import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/user.dart';
import 'package:survey/repositories/user_repository.dart';

import '../fakers/fake_shared_preferences_storage.dart';
import '../mocks/generate_mocks.mocks.dart';

main() {
  final mockClient = MockGraphQLClient();
  final graphqlClientProvider =
      GraphQLClientProvider(injectedClient: mockClient);
  final fakeSharedPref = FakeSharedPreferencesStorage();
  TestWidgetsFlutterBinding.ensureInitialized();

  final testedUserRepository =
      UserRepositoryImpl(graphqlClientProvider, fakeSharedPref);

  group('Validate getProfile', () {
    test('When get Profile successfully, it returns User data', () async {
      when(mockClient.query(any))
          .thenAnswer((_) async => QueryResult.optimistic(data: {
                "profile": {
                  "id": "mock id",
                  "email": "mock email",
                  "avatarUrl": "mock url",
                },
              }));

      final profile = await testedUserRepository.getProfile();

      expect(profile, isA<User>());
      expect(profile.id, "mock id");
      expect(profile.email, "mock email");
      expect(profile.avatarUrl, "mock url");
    });

    test('When get Profile unsuccessfully, it returns NetworkExceptions',
        () async {
      when(mockClient.query(any))
          .thenAnswer((_) async => QueryResult.optimistic(data: null));
      expect(() => testedUserRepository.getProfile(),
          throwsA(isA<NetworkExceptions>()));
    });
  });

  group('Validate isLoggedIn', () {
    test('When the user has logged in, it returns corresponding status',
        () async {
      fakeSharedPref.saveRefreshToken("fake refreshToken");
      final result = await testedUserRepository.isLoggedIn();
      expect(result, true);

      // FIXME: somehow I cannot separate this to another test/group, it fails the test mysteriously
      fakeSharedPref.saveRefreshToken("");
      final negativeResult = await testedUserRepository.isLoggedIn();
      expect(negativeResult, false);
    });
  });
}
