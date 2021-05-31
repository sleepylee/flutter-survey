const String GET_PROFILE_QUERY = r"""
        query profile {
          profile {
            id
            email
            avatarUrl
          }
        }
      """;
