part of 'get_projects_bloc.dart';

abstract class GetProjectsState extends Equatable {
  const GetProjectsState();

  @override
  List<Object> get props => [];
}

class GetProjectsInitial extends GetProjectsState {}

class GetProjectsLoading extends GetProjectsState {}

class GetProjectsSuccess extends GetProjectsState {
  final List<Project> projects;

  const GetProjectsSuccess(this.projects);

  @override
  List<Object> get props => [projects];
}

class GetProjectsFailure extends GetProjectsState {
  final FailureType type;

  const GetProjectsFailure(this.type);

  @override
  List<Object> get props => [type];
}
