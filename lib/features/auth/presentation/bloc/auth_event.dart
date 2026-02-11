import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

abstract class AuthEvent {
  const AuthEvent();
}

@freezed
sealed class AuthLogin extends AuthEvent with _$AuthLogin {
  const AuthLogin._();
  const factory AuthLogin({required String email, required String password}) = _AuthLogin;
}

@freezed
sealed class AuthSignUp extends AuthEvent with _$AuthSignUp {
  const AuthSignUp._();
  const factory AuthSignUp({
    required String email,
    required String password,
    required String name,
  }) = _AuthSignUp;
}

@freezed
sealed class AuthCheckCurrentUser extends AuthEvent with _$AuthCheckCurrentUser {
  const AuthCheckCurrentUser._();
  const factory AuthCheckCurrentUser() = _AuthCheckCurrentUser;
}

@freezed
sealed class AuthLogout extends AuthEvent with _$AuthLogout {
  const AuthLogout._();
  const factory AuthLogout() = _AuthLogout;
}
