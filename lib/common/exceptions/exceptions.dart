class AuthException implements Exception {
  String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}


class ProjectException implements Exception {
  String message;

  ProjectException(this.message);

  @override
  String toString() {
    return message;
  }
}


class NetworkException implements Exception {
  String message;

  NetworkException(this.message);

  @override
  String toString() {
    return message;
  }
}
