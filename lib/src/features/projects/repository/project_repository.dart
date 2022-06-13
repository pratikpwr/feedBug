import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/firebase_client.dart';
import '../../../core/network/network_info.dart';
import '../models/project_model.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<Project>>> getProjects();
}

class ProjectRepositoryImpl implements ProjectRepository {
  final NetworkInfo networkInfo;
  final FirebaseClient firebaseClient;

  const ProjectRepositoryImpl({
    required this.networkInfo,
    required this.firebaseClient,
  });

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    if (await networkInfo.isConnected) {
      final projectRef =
          firebaseClient.collection('projects').withConverter<Project>(
                fromFirestore: (snapshot, _) => Project.fromJson(
                  snapshot.id,
                  snapshot.data()!,
                ),
                toFirestore: (project, _) => project.toJson(),
              );

      try {
        List<QueryDocumentSnapshot<Project>> result =
            await projectRef.get().then((snapshot) => snapshot.docs);

        final projects = result.map((snapshot) => snapshot.data()).toList();

        if (projects.isEmpty) {
          return const Left(NoDataFailure());
        }
        return Right(projects);
      } catch (e) {
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
