import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/bloc/base_state.dart';
import '../../domain/entities/service_entity.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default(BaseState<List<ServiceEntity>>.initial()) BaseState<List<ServiceEntity>> status,
  }) = _HomeState;
}
