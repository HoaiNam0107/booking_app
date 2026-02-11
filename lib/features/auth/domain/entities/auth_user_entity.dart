import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enum/user_role.dart';

part 'auth_user_entity.freezed.dart';

@freezed
sealed class AuthUserEntity with _$AuthUserEntity {
  const factory AuthUserEntity({
    required String uid,
    required String email,
    required String name,
    required UserRole role,
  }) = _AuthUserEntity;
}




