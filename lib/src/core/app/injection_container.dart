import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/projects/bloc/get_projects/get_projects_bloc.dart';
import '../../features/projects/repository/project_repository.dart';
import '../../features/releases/repository/releases_repository.dart';
import '../../features/tickets/repository/ticket_repository.dart';
import '../graphql/gql_client.dart';
import '../network/api_client.dart';
import '../network/firebase_client.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory<GetProjectsBloc>(() => GetProjectsBloc(repository: sl()));

  // repository
  sl.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl(
        networkInfo: sl(),
        firebaseClient: sl(),
      ));
  sl.registerLazySingleton<ReleaseRepository>(() => ReleaseRepositoryImpl(
        networkInfo: sl(),
        firebaseClient: sl(),
      ));

  sl.registerLazySingleton<TicketRepository>(() => TicketRepositoryImpl(
        networkInfo: sl(),
        firebaseClient: sl(),
      ));

  // core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(dataConnectionChecker: sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(dio: sl()));
  sl.registerLazySingleton<FirebaseClient>(
      () => FirebaseClientImpl(FirebaseFirestore.instance));
  sl.registerLazySingleton(() => GQLClient());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
