import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:mockito/mockito.dart';
import 'package:survey/api/graphql/mutation/create_response_mutation_input.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/survey.dart';
import 'package:survey/repositories/survey_repository.dart';

import '../fakers/fake_graphql_store.dart';
import '../mocks/generate_mocks.mocks.dart';

main() async {
  final mockGraphQLClient = MockGraphQLClient();
  TestWidgetsFlutterBinding.ensureInitialized();

  final injectedFakeStorage = FakeStore();
  when(mockGraphQLClient.cache)
      .thenReturn(graphql.GraphQLCache(store: injectedFakeStorage));

  group('Validate getSurveys', () {
    final testedSurveyRepository = SurveyRepositoryImpl(mockGraphQLClient);
    final surveysFile = File('test/test_resources/surveys.json');
    final surveysJson = jsonDecode(surveysFile.readAsStringSync());
    final surveysData = surveysJson['data'];

    when(mockGraphQLClient.query(any)).thenAnswer(
      (_) async => graphql.QueryResult.optimistic(
        data: surveysData,
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
          .thenAnswer((_) async => graphql.QueryResult.optimistic(data: null));

      expect(() => testedSurveyRepository.getSurveys("", true),
          throwsA(isA<NotFound>()));
    });
  });

  group('Validate getSurveyById', () {
    final singleSurveyFile = File('test/test_resources/single_survey.json');
    final singleSurveyJson = jsonDecode(singleSurveyFile.readAsStringSync());
    final singleSurveyData = singleSurveyJson['data'];

    final testedSurveyRepository = SurveyRepositoryImpl(mockGraphQLClient);

    test('When getSurveyById successfully, it returns a Survey', () async {
      when(mockGraphQLClient.query(any)).thenAnswer(
        (_) async => graphql.QueryResult.optimistic(
          data: singleSurveyData,
        ),
      );

      final result = await testedSurveyRepository.getSurveyById("any");

      expect(result, isA<Survey>());
      expect(result.title, "Scarlett Bangkok");
    });

    test('When get Survey successfully, it has added extra data', () async {
      when(mockGraphQLClient.query(any)).thenAnswer(
        (_) async => graphql.QueryResult.optimistic(
          data: singleSurveyData,
        ),
      );
      final result = await testedSurveyRepository.getSurveyById("any");

      expect(result.hdCoverImageUrl, result.coverImageUrl + "l");
      expect(result.questions.first.hdCoverImageUrl,
          result.questions.first.coverImageUrl + "l");
      expect(result.questions.first.doesNotRequireAnswer, true);
    });

    test('When getSurveyById failed, it throws a NetworkException-NotFound',
        () async {
      when(mockGraphQLClient.query(any))
          .thenAnswer((_) async => graphql.QueryResult.optimistic(data: null));

      expect(() => testedSurveyRepository.getSurveyById("any"),
          throwsA(isA<NotFound>()));
    });
  });

  group('Validate createResponse', () {
    final testedSurveyRepository = SurveyRepositoryImpl(mockGraphQLClient);
    test('When createResponse successfully, it returns null', () {
      when(mockGraphQLClient.mutate(any)).thenReturn(null);

      final testInput = CreateResponseMutationInput(null);

      final result = testedSurveyRepository.createResponse(testInput);

      expect(result, null);
    });

    test('When createResponse unsuccessfully, it throws NetworkException',
        () async {
      final error = DioError(
          type: DioErrorType.RESPONSE, response: Response(statusCode: 404));
      when(mockGraphQLClient.mutate(any)).thenThrow(error);

      final testInput = CreateResponseMutationInput(null);

      expect(() async => testedSurveyRepository.createResponse(testInput),
          throwsA(isA<NotFound>()));
    });
  });
}
