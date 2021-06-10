import 'package:graphql_flutter/graphql_flutter.dart';

import '../../flavors.dart';

class GraphQLClientProvider {
  final HttpLink _httpLink;

  const GraphQLClientProvider._(this._httpLink);

  static AuthLink _authLink;

  factory GraphQLClientProvider() {
    return GraphQLClientProvider._(
      HttpLink(F.graphQLEndpoint),
    );
  }

  // Setup a token to all request i.e: 'Bearer - token'
  void setAuthToken(String token) {
    _authLink = AuthLink(
      getToken: () async => token,
    );
  }

  void removeAuthToken() {
    _authLink = null;
  }

  GraphQLClient get client {
    Link _link;
    if (_authLink != null) {
      _link = _authLink.concat(_httpLink);
    } else {
      _link = _httpLink;
    }

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }
}
