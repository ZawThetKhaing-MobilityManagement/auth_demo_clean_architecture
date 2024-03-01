import 'package:equatable/equatable.dart';

abstract class Faliure extends Equatable {
  const Faliure({required this.messages});

  final String messages;

  @override
  List<Object?> get props => [messages];
}

class ApiFaliure extends Faliure {
  const ApiFaliure({required super.messages});
}

class ServerFaliure extends Faliure {
  const ServerFaliure({required super.messages});
}

class CacheFaliure extends Faliure {
  const CacheFaliure({required super.messages});
}
