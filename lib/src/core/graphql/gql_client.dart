import 'package:graphql/client.dart';

const gqlUrl =
    "https://green-feather-480011.ap-south-1.aws.cloud.dgraph.io/graphql";

class GraphQlHelper {
  Future<QueryResult> mutate({
    required String document,
    required Map<String, dynamic> variables,
    String url = gqlUrl,
    FetchPolicy fetchPolicy = FetchPolicy.noCache,
    Map<String, String>? otherHeaders,
    bool isAnonymous = false,
  }) async {
    final headers = await getHeaders();
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

  Future<QueryResult> query({
    required String document,
    required Map<String, dynamic> variables,
    String url = gqlUrl,
    FetchPolicy fetchPolicy = FetchPolicy.noCache,
    Map<String, String>? otherHeaders,
  }) async {
    final headers = await getHeaders();
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

  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = {"content-type": 'application/json'};

    return headers;
  }
}
