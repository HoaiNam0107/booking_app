import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enum/user_role.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
sealed class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String uid,
    required String email,
    required String name,
    required UserRole role,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => _$AuthUserModelFromJson(json);
}

extension AuthUserModelMapper on AuthUserModel {
  AuthUserEntity toEntity() => AuthUserEntity(uid: uid, email: email, name: name, role: role);
}
