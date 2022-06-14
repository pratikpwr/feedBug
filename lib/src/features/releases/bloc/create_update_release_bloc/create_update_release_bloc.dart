import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure_types.dart';
import '../../models/release_model.dart';
import '../../repository/releases_repository.dart';

part 'create_update_release_event.dart';

part 'create_update_release_state.dart';

class CreateUpdateReleaseBloc
    extends Bloc<CreateUpdateReleaseEvent, CreateUpdateReleaseState> {
  CreateUpdateReleaseBloc({
    required this.repository,
  }) : super(CreateUpdateReleaseInitial()) {
    on<SubmitRelease>(_submitReleaseEvent);
    on<UpdateRelease>(_updateReleaseEvent);
  }

  final ReleaseRepository repository;

  _submitReleaseEvent(
      SubmitRelease event, Emitter<CreateUpdateReleaseState> emit) async {
    emit(CreateUpdateReleaseLoading());

    final result = await repository.submitRelease(event.release);

    result.fold(
      (failure) =>
          emit(CreateUpdateReleaseFailure(FailureType.fromFailure(failure))),
      (release) => emit(CreateUpdateReleaseSuccess()),
    );
  }

  _updateReleaseEvent(
      UpdateRelease event, Emitter<CreateUpdateReleaseState> emit) async {
    emit(CreateUpdateReleaseLoading());

    final result = await repository.updateRelease(event.release);

    result.fold(
      (failure) =>
          emit(CreateUpdateReleaseFailure(FailureType.fromFailure(failure))),
      (release) => emit(CreateUpdateReleaseSuccess()),
    );
  }
}
