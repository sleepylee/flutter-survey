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
