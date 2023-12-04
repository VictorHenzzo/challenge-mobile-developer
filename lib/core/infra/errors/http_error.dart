import 'package:equatable/equatable.dart';

class HttpError extends Equatable implements Exception {
  const HttpError({
    required this.code,
    this.message,
  });

  final String? message;
  final int code;

  @override
  List<Object?> get props => [message, code];
}

class BadRequest extends HttpError {
  const BadRequest({
    super.message,
  }) : super(code: 400);
}

class NotFound extends HttpError {
  const NotFound({
    super.message,
  }) : super(code: 404);
}

class ServerError extends HttpError {
  const ServerError({
    super.message,
  }) : super(code: 500);
}
