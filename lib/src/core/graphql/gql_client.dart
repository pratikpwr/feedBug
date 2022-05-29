import 'package:graphql/client.dart';
import 'package:setuback/src/core/constants/api_constants.dart';

class GQLClient {
  static Future<QueryResult> mutate({
    required String document,
    required Map<String, dynamic> variables,
    String url = ApiConstants.gqlUrl,
    FetchPolicy fetchPolicy = FetchPolicy.noCache,
    Map<String, String>? otherHeaders,
    bool isAnonymous = false,
  }) async {
    final headers = await _getHeaders();
    if (otherHeaders != null) {
      headers.addAll(otherHeaders);
    }

    final link = HttpLink(url, defaultHeaders: headers);

    GraphQLClient client = GraphQLClient(link: link, cache: GraphQLCache());

    QueryResult result = await client.mutate(MutationOptions(
      document: gql(document),
      variables: variables,
      fetchPolicy: fetchPolicy,
    ));

    return result;
  }

  static Future<QueryResult> query({
    required String document,
    required Map<String, dynamic> variables,
    String url = ApiConstants.gqlUrl,
    FetchPolicy fetchPolicy = FetchPolicy.noCache,
    Map<String, String>? otherHeaders,
  }) async {
    final headers = await _getHeaders();
    if (otherHeaders != null) {
      headers.addAll(otherHeaders);
    }

    final link = HttpLink(url, defaultHeaders: headers);

    GraphQLClient client = GraphQLClient(link: link, cache: GraphQLCache());

    QueryResult result = await client.query(QueryOptions(
      document: gql(document),
      variables: variables,
      fetchPolicy: fetchPolicy,
    ));

    return result;
  }

  static Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      "content-type": 'application/json',
      "X-Auth-Token": ApiConstants.xAuthToken,
    };

    return headers;
  }
}
