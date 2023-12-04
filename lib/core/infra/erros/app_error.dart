import 'package:equatable/equatable.dart';

class AppError extends Equatable implements Exception {
  const AppError({
    required this.stackTrace,
    required this.message,
  });

  factory AppError.empty() {
    return AppError(
      stackTrace: StackTrace.current,
      message: null,
    );
  }

  final String? message;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [message, stackTrace];

  @override
  String toString() {
    return 'Exception: $message';
  }
}
