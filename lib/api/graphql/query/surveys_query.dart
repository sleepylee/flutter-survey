const String GET_SURVEYS_QUERY = r"""
  query($endCursor: String){
    surveys(first: 5, after: $endCursor){
      edges {
        cursor
        node {
          id
          title
          coverImageUrl
          description
        }
      }
      pageInfo {
        endCursor
      }
    }
  }
""";

const String GET_SURVEY_BY_ID = r"""
  query($surveyId: ID!){
    survey(id: $surveyId){
      title
      coverImageUrl
      description
      questions {
        id,
        text,
        displayType,
        displayOrder,
        coverImageUrl,
        answers {
          text
          score
        }
      }
    }
  }
""";
