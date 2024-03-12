import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  const Exception({this.statusCode, this.message});
  final int? statusCode;
  final String? message;
  @override
  List<Object?> get props => [statusCode, message];
}

class CachedException extends Exception {}

class ServerException extends Exception {
  const ServerException({
    super.statusCode,
    super.message,
  });
}
