import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    required this.username,
    required this.email,
  });

  const UserEntity.empty()
      : this(
          id: 1,
          username: '_empty.username',
          email: '_empty.email',
        );

  final int? id;
  final String username;

  final String email;

  @override
  List<Object?> get props => [id];
}
