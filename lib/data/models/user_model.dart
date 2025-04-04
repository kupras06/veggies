import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import '../entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({super.id, required super.email, super.name});

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(id: entity.id, email: entity.email, name: entity.name);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  static UserModel fromFirebaseUser(User user) {
    return UserModel(id: user.uid, email: user.email!, name: user.displayName);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
