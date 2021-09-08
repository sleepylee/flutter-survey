import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/repositories/survey_repository.dart';

import '../fakers/fake_graphql_store.dart';
import '../mocks/generate_mocks.mocks.dart';

main() async {
  final mockGraphQLClient = MockGraphQLClient();
  TestWidgetsFlutterBinding.ensureInitialized();

  final testedSurveyRepository = SurveyRepositoryImpl(mockGraphQLClient);
  final file = File('test/test_resources/surveys.json');
  final json = jsonDecode(await file.readAsString());
  final data = json['data'];

  group('Validate getSurveys', () {
    final injectedFakeStorage = FakeStore();
    when(mockGraphQLClient.cache)
        .thenReturn(GraphQLCache(store: injectedFakeStorage));
    when(mockGraphQLClient.query(any)).thenAnswer(
      (_) async => QueryResult.optimistic(
        data: data,
      ),
    );

    test('When get Surveys without forceNetworkData, it returns ListSurvey',
        () async {
      final result = await testedSurveyRepository.getSurveys("", false);

      expect(injectedFakeStorage.isReset, false);
      expect(result, isA<List<Survey>>());
      expect(result.first.title, "Scarlett Bangkok");
    });

    test(
        'When get Surveys with forceNetworkData, it reset cache store and returns ListSurvey',
        () async {
      final result = await testedSurveyRepository.getSurveys("", true);

      expect(result, isA<List<Survey>>());
      expect(result.first.title, "Scarlett Bangkok");
      expect(injectedFakeStorage.isReset, true);
    });

    test('When get Surveys failed, it throws a NetworkException-NotFound',
        () async {
      when(mockGraphQLClient.query(any))
          .thenAnswer((_) async => QueryResult.optimistic(data: null));

      expect(() => testedSurveyRepository.getSurveys("", true),
          throwsA(isA<NotFound>()));
    });
  });
}
