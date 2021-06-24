import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:survey/api/graphql/query/surveys_query.dart';
import 'package:survey/api/graphql/response/survey_response.dart';
import 'package:survey/exception/network_exceptions.dart';
import 'package:survey/models/survey.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys(String cursor);
}

class SurveyRepositoryImpl implements SurveyRepository {
  GraphQLClient _graphQlClient;

  SurveyRepositoryImpl(this._graphQlClient);

  @override
  Future<List<Survey>> getSurveys(String cursor) {
    final queryOptions = QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(GET_SURVEYS_QUERY),
        variables: {'after': cursor});
    return _graphQlClient.query(queryOptions).then((value) {
      if (value.data != null) {
        final surveysResponse = SurveysResponse.fromJson(value.data['surveys']);

        final surveysList = <Survey>[];

        surveysResponse.edges.forEach((item) {
          final surveyItem = Survey(
            cursor: item.cursor,
            id: item.node.id,
            title: item.node.title,
            description: item.node.description,
            coverImageUrl: item.node.coverImageUrl,
          );
          surveysList.add(surveyItem);
        });

        return surveysList;
      } else {
        throw NetworkExceptions.notFound("Something is wrong");
      }
    });
  }
}
