part of 'get_projects_bloc.dart';

abstract class GetProjectsEvent extends Equatable {
  const GetProjectsEvent();
}

class GetProjects extends GetProjectsEvent {
  @override
  List<Object> get props => [];
}
