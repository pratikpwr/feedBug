part of 'create_update_release_bloc.dart';

abstract class CreateUpdateReleaseEvent extends Equatable {
  const CreateUpdateReleaseEvent();
}

class SubmitRelease extends CreateUpdateReleaseEvent {
  final Release release;

  const SubmitRelease({required this.release});

  @override
  List<Object> get props => [release];
}

class UpdateRelease extends CreateUpdateReleaseEvent {
  final Release release;

  const UpdateRelease({required this.release});

  @override
  List<Object> get props => [release];
}
