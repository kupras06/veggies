class UserEntity {
  UserEntity({this.id, required this.email, this.name});
  final String? id;
  final String email;
  final String? name;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            email == other.email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
