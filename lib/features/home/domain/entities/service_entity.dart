// lib/features/home/domain/entities/service_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_entity.freezed.dart';

@freezed
sealed class ServiceEntity with _$ServiceEntity {
  const factory ServiceEntity({
    required String id,
    required String ownerId,
    required String title,
    required String description,
    required double price,
    required bool isAvailable,
  }) = _ServiceEntity;
}
