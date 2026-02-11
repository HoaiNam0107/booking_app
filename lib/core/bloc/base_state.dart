// lib/core/bloc/base_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

@freezed
class BaseState<T> with _$BaseState<T> {
  const factory BaseState.initial() = _Initial;
  const factory BaseState.loading() = _Loading;
  const factory BaseState.success(T data) = _Success<T>;
  const factory BaseState.failure(String message) = _Failure;
}
