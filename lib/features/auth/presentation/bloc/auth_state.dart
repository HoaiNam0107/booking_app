import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/bloc/base_state.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(BaseState<AuthUserEntity?>.initial()) BaseState<AuthUserEntity?> status,
  }) = _AuthState;
}
