import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/service_entity.dart';

part 'home_event.freezed.dart';

abstract class HomeEvent {
  const HomeEvent();
}

@freezed
sealed class HomeLoadServices extends HomeEvent with _$HomeLoadServices {
  const HomeLoadServices._();

  const factory HomeLoadServices() = _HomeLoadServices;
}

@freezed
sealed class HomeCreateService extends HomeEvent with _$HomeCreateService {
  const HomeCreateService._();

  const factory HomeCreateService({required ServiceEntity service}) = _HomeCreateService;
}
