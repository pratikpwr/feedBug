class ServerException implements Exception {
  final String ex;

  const ServerException(this.ex);
}

class NoDataException implements Exception {
  final String ex;

  NoDataException(this.ex);
}

class ParsingException implements Exception {
  final String ex;

  ParsingException(this.ex);
}

class InternalException implements Exception {
  final String ex;

  InternalException(this.ex);
}
