part of 'base_use_case.dart';

abstract class Result<T> {}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value);
}

class Failed<E extends Exception> extends Result<E> {
  final E error;

  Failed(this.error);
}
