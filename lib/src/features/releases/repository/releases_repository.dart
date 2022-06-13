import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/firebase_client.dart';
import '../../../core/network/network_info.dart';
import '../models/release_model.dart';

abstract class ReleaseRepository {
  Future<Either<Failure, List<Release>>> getReleases(String projectId);
}

class ReleaseRepositoryImpl implements ReleaseRepository {
  final NetworkInfo networkInfo;
  final FirebaseClient firebaseClient;

  const ReleaseRepositoryImpl({
    required this.networkInfo,
    required this.firebaseClient,
  });

  @override
  Future<Either<Failure, List<Release>>> getReleases(String projectId) async {
    if (await networkInfo.isConnected) {
      final projectRef =
          firebaseClient.collection('release').withConverter<Release>(
                fromFirestore: (snapshot, _) => Release.fromJson(
                  snapshot.id,
                  snapshot.data()!,
                ),
                toFirestore: (release, _) => release.toJson(),
              );

      try {
        List<QueryDocumentSnapshot<Release>> result = await projectRef
            .where('project_id', isEqualTo: projectId)
            .orderBy('created_at', descending: true)
            .get()
            .then((snapshot) => snapshot.docs);

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
