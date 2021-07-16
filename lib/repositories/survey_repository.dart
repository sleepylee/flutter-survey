import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:survey/api/graphql/query/surveys_query.dart';
import 'package:survey/api/graphql/response/survey_response.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/mappers/survey_mapper.dart';
import 'package:survey/models/survey.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys(String cursor);

  Future<Survey> getSurveyById(String id);
}

class SurveyRepositoryImpl implements SurveyRepository {
  GraphQLClient _graphQlClient;

  SurveyRepositoryImpl(this._graphQlClient);

  @override
  Future<List<Survey>> getSurveys(String cursor) {
    final queryOptions = QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(GET_SURVEYS_QUERY),
        variables: {'endCursor': cursor});
    return _graphQlClient.query(queryOptions).then((value) {
      if (value.data != null) {
        final surveysResponse = SurveysResponse.fromJson(value.data['surveys']);
        return surveysResponse.edges.map((item) => item.toSurvey()).toList();
      } else {
        throw NetworkExceptions.notFound("Something is wrong");
      }
    });
  }

  @override
  Future<Survey> getSurveyById(String id) {
    final queryOptions = QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(GET_SURVEY_BY_ID),
        variables: {'surveyId': id});
    return _graphQlClient.query(queryOptions).then((value) {
      if (value.data != null) {
        final surveyResponse = SurveyResponse.fromJson(value.data['survey']);
        return surveyResponse.toSurvey();
      } else {
        throw NetworkExceptions.notFound("Something is wrong");
      }
    });
  }
}
