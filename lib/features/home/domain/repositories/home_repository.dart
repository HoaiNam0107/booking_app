// lib/features/home/domain/repositories/home_repository.dart
import '../entities/service_entity.dart';

abstract class HomeRepository {
  Future<List<ServiceEntity>> getServices();
  Future<void> createService(ServiceEntity service);
}
