part of 'create_update_release_bloc.dart';

abstract class CreateUpdateReleaseState extends Equatable {
  const CreateUpdateReleaseState();
}

class CreateUpdateReleaseInitial extends CreateUpdateReleaseState {
  @override
  List<Object> get props => [];
}

class CreateUpdateReleaseLoading extends CreateUpdateReleaseState {
  @override
  List<Object> get props => [];
}

class CreateUpdateReleaseSuccess extends CreateUpdateReleaseState {
  @override
  List<Object> get props => [];
}

class CreateUpdateReleaseFailure extends CreateUpdateReleaseState {
  final FailureType type;

  const CreateUpdateReleaseFailure(this.type);

  @override
  List<Object> get props => [type];
}
