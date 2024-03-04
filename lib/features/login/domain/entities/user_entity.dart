import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    this.token,
  });

  const UserEntity.empty()
      : this(
          id: 1,
          name: '_empty.username',
          email: '_empty.email',
        );

  final int? id;
  final String name;

  final String email;
  final String? token;

  @override
  List<Object?> get props => [id];
}
