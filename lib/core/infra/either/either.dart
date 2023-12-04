import 'package:equatable/equatable.dart';

sealed class Either<E extends Exception, S> extends Equatable {
  const Either();

  bool get hasValue;
  bool get hasError;

  S? get valueOrNull;
  E? get errorOrNull;

  void fold({
    required final void Function(E error) onError,
    required final void Function(S success) onSuccess,
  });
}

final class Success<E extends Exception, S> extends Either<E, S> {
  const Success(this.value);
  final S value;

  @override
  E? get errorOrNull => null;

  @override
  S? get valueOrNull => value;

  @override
  bool get hasError => false;

  @override
  bool get hasValue => true;

  @override
  void fold({
    required final Function(E error) onError,
    required final Function(S success) onSuccess,
  }) =>
      onSuccess(value);

  @override
  List<Object?> get props => [value];
}

final class Failure<E extends Exception, S> extends Either<E, S> {
  const Failure(this.exception);
  final E exception;

  @override
  bool get hasError => true;

  @override
  bool get hasValue => false;

  @override
  E? get errorOrNull => exception;

  @override
  S? get valueOrNull => null;

  @override
  void fold({
    required final Function(E error) onError,
    required final Function(S success) onSuccess,
  }) =>
      onError(exception);

  @override
  List<Object?> get props => [exception];
}
