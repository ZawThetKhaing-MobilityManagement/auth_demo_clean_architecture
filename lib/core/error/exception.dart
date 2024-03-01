import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  @override
  List<Object?> get props => [];
}

class CachedException extends Exception {}

class ServerException extends Exception {
  ServerException({required this.statusCode});

  final int statusCode;
}
