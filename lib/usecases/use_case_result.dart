part of 'base_use_case.dart';

abstract class Result<T> {
  Result._();
}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value) : super._();
}

class UseCaseError implements Exception {
  final NetworkExceptions networkExceptions;
  final Exception actualException;

  UseCaseError(this.networkExceptions, this.actualException);
}

class Failed<T> extends Result<T> {
  final UseCaseError error;

  Failed(this.error) : super._();
}
