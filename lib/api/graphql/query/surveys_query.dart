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
          questions {
            id,
            text,
            imageUrl,
            displayType,
            isMandatory
            answers {
              id
              text
              score
            }
          }
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
      id
      title
      coverImageUrl
      description
      questions {
        id,
        text,
        imageUrl,
        displayType,
        isMandatory
        answers {
          id
          text
          score
        }
      }
    }
  }
""";
