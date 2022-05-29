import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  const Failure([properties]);

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  final String? message;

  const ServerFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

class InternalFailure extends Failure {
  final String? message;

  const InternalFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

class NoDataFailure extends Failure {
  final String? message;

  const NoDataFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

class NoInternetFailure extends Failure {
  final String? message;

  const NoInternetFailure([this.message]);

  @override
  List<Object?> get props => [message];
}
