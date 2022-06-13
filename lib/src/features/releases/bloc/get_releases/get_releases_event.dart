part of 'get_releases_bloc.dart';

abstract class GetReleasesEvent extends Equatable {
  const GetReleasesEvent();
}

class GetReleases extends GetReleasesEvent {
  final String projectId;

  const GetReleases({
    required this.projectId,
  });

  @override
  List<Object> get props => [projectId];
}
