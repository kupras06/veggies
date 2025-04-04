abstract class Failure {
  Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server error']);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message = 'Network error']);
}

class CacheFailure extends Failure {
  CacheFailure([super.message = 'Cache error']);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure([super.message = 'Invalid input']);
}// TODO Implement this library.