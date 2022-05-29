import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/project_model.dart';
import '../../repository/project_repository.dart';

part 'get_projects_event.dart';

part 'get_projects_state.dart';

class GetProjectsBloc extends Bloc<GetProjectsEvent, GetProjectsState> {
  GetProjectsBloc({
    required this.repository,
  }) : super(GetProjectsInitial());

  final ProjectRepository repository;

  @override
  Stream<GetProjectsState> mapEventToState(
    GetProjectsEvent event,
  ) async* {
    if (event is GetProjects) {
      _mapGetProjectsToState(event);
    }
  }

  _mapGetProjectsToState(GetProjects event) async* {
    emit(GetProjectsLoading());

    final result = await repository.getProjects();

    result.fold(
      (failure) => emit(GetProjectsFailure(FailureType.fromFailure(failure))),
      (projects) => emit(GetProjectsSuccess(projects)),
    );
  }
}
