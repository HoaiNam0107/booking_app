import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/service_entity.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
sealed class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
    required String id,
    required String ownerId,
    required String title,
    required String description,
    required double price,
    required bool isAvailable,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);
}

extension ServiceModelMapper on ServiceModel {
  ServiceEntity toEntity() => ServiceEntity(
    id: id,
    ownerId: ownerId,
    title: title,
    description: description,
    price: price,
    isAvailable: isAvailable,
  );
}
