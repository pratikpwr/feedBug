import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/release_model.dart';
import '../../repository/releases_repository.dart';

part 'get_releases_event.dart';

part 'get_releases_state.dart';

class GetReleasesBloc extends Bloc<GetReleasesEvent, GetReleasesState> {
  final ReleaseRepository repository;

  GetReleasesBloc({
    required this.repository,
  }) : super(GetReleasesInitial()) {
    on<GetReleases>(_onGetReleasesEvent);
  }

  void _onGetReleasesEvent(
    GetReleases event,
    Emitter<GetReleasesState> emit,
  ) async {
    emit(GetReleasesLoading());

    final result = await repository.getReleases(event.projectId);

    result.fold(
      (failure) => emit(GetReleasesFailure(FailureType.fromFailure(failure))),
      (releases) => emit(GetReleasesSuccess(releases)),
    );
  }
}
