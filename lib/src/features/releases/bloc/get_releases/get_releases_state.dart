part of 'get_releases_bloc.dart';

abstract class GetReleasesState extends Equatable {
  const GetReleasesState();

  @override
  List<Object> get props => [];
}

class GetReleasesInitial extends GetReleasesState {}

class GetReleasesLoading extends GetReleasesState {}

class GetReleasesSuccess extends GetReleasesState {
  final List<Release> releases;

  const GetReleasesSuccess(this.releases);

  @override
  List<Object> get props => [releases];
}

class GetReleasesFailure extends GetReleasesState {
  final FailureType type;

  const GetReleasesFailure(this.type);

  @override
  List<Object> get props => [type];
}
