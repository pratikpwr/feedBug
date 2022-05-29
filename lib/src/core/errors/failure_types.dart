import 'failures.dart';

enum FailureType {
  server,
  notFound,
  noData,
  noInternet,
  internal,
  unknown;

  static FailureType fromFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureType.server;
      case NoDataFailure:
        return FailureType.noData;
      case NoInternetFailure:
        return FailureType.noInternet;
      case InternalFailure:
        return FailureType.internal;
      default:
        return FailureType.unknown;
    }
  }
}
