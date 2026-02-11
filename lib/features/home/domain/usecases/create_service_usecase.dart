import 'package:injectable/injectable.dart';

import '../entities/service_entity.dart';
import '../repositories/home_repository.dart';

@injectable
class CreateServiceUseCase {
  final HomeRepository repository;
  CreateServiceUseCase(this.repository);

  Future<void> call(ServiceEntity service) {
    return repository.createService(service);
  }
}
