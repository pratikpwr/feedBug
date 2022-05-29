import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:setuback/src/core/constants/api_constants.dart';
import 'package:setuback/src/core/enums/http_method.dart';
import 'package:setuback/src/core/network/api_client.dart';

import '../../../core/errors/failures.dart';
import '../../../core/graphql/gql_client.dart';
import '../../../core/graphql/gql_query.dart';
import '../../../core/network/network_info.dart';
import '../models/project_model.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<Project>>> getProjects();
}

class ProjectRepositoryImpl implements ProjectRepository {
  final GQLClient client;
  final ApiClient apiClient;
  final NetworkInfo networkInfo;

  const ProjectRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
    required this.client,
  });

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    if (await networkInfo.isConnected) {
      // final result = await GQLClient.query(
      //   document: GQLQuery.getProjects,
      //   variables: {},
      // );
      //
      // if (result.hasException || result.data == null) {
      //   debugPrint(result.exception.toString());
      //   return Left(ServerFailure(result.exception.toString()));
      // }
      //
      // if (result.data?["queryProject"] == null) {
      //   return const Left(NoDataFailure());
      // }

      final result = await apiClient.request(
        HttpMethod.post,
        ApiConstants.gqlUrl,
        body: jsonEncode({
          "query": GQLQuery.getProjects,
          "variables": {},
        }),
        headers: {
          "content-type": 'application/json',
        },
      );

      print(result.data);
      try {
        final projects = List<Project>.from(
            result.data?["data"]["queryProject"].map((e) => Project.fromJson(e)));
        return Right(projects);
      } catch (e) {
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
