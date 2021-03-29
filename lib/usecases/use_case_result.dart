part of 'base_use_case.dart';

abstract class Result<T> {}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value);
}

class ApiError implements Exception {
  final NetworkExceptions networkExceptions;
  final Exception actualException;

  ApiError(this.networkExceptions, this.actualException);
}

class Failed<T> extends Result<T> {
  final ApiError error;

  Failed(this.error);
}
