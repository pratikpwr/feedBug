import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:setuback/src/core/constants/api_constants.dart';
import 'package:setuback/src/core/enums/http_method.dart';
import 'package:setuback/src/core/network/api_client.dart';
import 'package:setuback/src/features/tickets/models/ticket_model.dart';

import '../../../core/errors/failures.dart';
import '../../../core/graphql/gql_client.dart';
import '../../../core/graphql/gql_query.dart';
import '../../../core/network/network_info.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<Ticket>>> getTickets();
}

class TicketRepositoryImpl implements TicketRepository {
  final GQLClient client;
  final ApiClient apiClient;
  final NetworkInfo networkInfo;

  const TicketRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
    required this.client,
  });

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    if (await networkInfo.isConnected) {
      // final result = await GQLClient.query(
      //   document: GQLQuery.getTickets,
      //   variables: {},
      // );
      //
      // if (result.hasException || result.data == null) {
      //   debugPrint(result.exception.toString());
      //   return Left(ServerFailure(result.exception.toString()));
      // }
      //
      // if (result.data?["queryTicket"] == null) {
      //   return const Left(NoDataFailure());
      // }

      final result = await apiClient.request(
        HttpMethod.post,
        ApiConstants.gqlUrl,
        body: jsonEncode({
          "query": GQLQuery.getTickets,
          "variables": {},
        }),
        headers: {
          "content-type": 'application/json',
        },
      );

      try {
        final projects = List<Ticket>.from(
            result.data?["data"]["queryTicket"].map((e) => Ticket.fromJson(e)));
        return Right(projects);
      } catch (e) {

        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
