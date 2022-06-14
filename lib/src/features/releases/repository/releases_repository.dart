import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/firebase_client.dart';
import '../../../core/network/network_info.dart';
import '../models/release_model.dart';

abstract class ReleaseRepository {
  Future<Either<Failure, List<Release>>> getReleases(String projectId);

  Future<Either<Failure, void>> submitRelease(Release release);

  Future<Either<Failure, void>> updateRelease(Release release);
}

class ReleaseRepositoryImpl implements ReleaseRepository {
  final NetworkInfo networkInfo;
  final FirebaseClient firebaseClient;

  const ReleaseRepositoryImpl({
    required this.networkInfo,
    required this.firebaseClient,
  });

  CollectionReference<Release> get releaseRef =>
      firebaseClient.collection('release').withConverter<Release>(
            fromFirestore: (snapshot, _) => Release.fromJson(
              snapshot.id,
              snapshot.data()!,
            ),
            toFirestore: (release, _) => release.toJson(),
          );

  @override
  Future<Either<Failure, List<Release>>> getReleases(String projectId) async {
    if (await networkInfo.isConnected) {
      // try {
      List<QueryDocumentSnapshot<Release>> result = await releaseRef
          .where('project_id', isEqualTo: projectId)
          .orderBy('created_at', descending: true)
          .get()
          .then((snapshot) => snapshot.docs);

      final releases = result.map((snapshot) => snapshot.data()).toList();

      if (releases.isEmpty) {
        return const Left(NoDataFailure());
      }

      return Right(releases);
      // } catch (e) {
      //   return Left(InternalFailure(e.toString()));
      // }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, void>> submitRelease(Release release) async {
    if (await networkInfo.isConnected) {
      await releaseRef.add(release).onError((error, stackTrace) {
        throw (ServerFailure(error.toString()));
      });
      return const Right(null);
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateRelease(Release release) async {
    if (await networkInfo.isConnected) {
      releaseRef.doc(release.id).update(release.toJson());
      return const Right(null);
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
