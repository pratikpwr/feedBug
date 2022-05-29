import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

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
  final NetworkInfo networkInfo;

  const ProjectRepositoryImpl({
    required this.networkInfo,
    required this.client,
  });

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    if (await networkInfo.isConnected) {
      final result = await GQLClient.query(
        document: GQLQuery.getProjects,
        variables: {},
      );

      if (result.hasException || result.data == null) {
        debugPrint(result.exception.toString());
        return Left(ServerFailure(result.exception.toString()));
      }

      if (result.data?["queryProject"] == null) {
        return const Left(NoDataFailure());
      }

      try {
        final projects = List<Project>.from(
            result.data?["queryProject"].map((e) => Project.fromJson(e)));
        return Right(projects);
      } catch (e) {
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
