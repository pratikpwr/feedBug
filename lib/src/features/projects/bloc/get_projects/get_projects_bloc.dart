import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/project_model.dart';
import '../../repository/project_repository.dart';

part 'get_projects_event.dart';
part 'get_projects_state.dart';

class GetProjectsBloc extends Bloc<GetProjectsEvent, GetProjectsState> {
  final ProjectRepository repository;

  GetProjectsBloc({
    required this.repository,
  }) : super(GetProjectsInitial()) {
    on<GetProjects>(_onGetProjectsEvent);
  }

  void _onGetProjectsEvent(
    GetProjects event,
    Emitter<GetProjectsState> emit,
  ) async {
    emit(GetProjectsLoading());

    final result = await repository.getProjects();

    result.fold(
      (failure) => emit(GetProjectsFailure(FailureType.fromFailure(failure))),
      (projects) => emit(GetProjectsSuccess(projects)),
    );
  }
}
