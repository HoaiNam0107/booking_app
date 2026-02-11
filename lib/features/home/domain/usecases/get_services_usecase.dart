import 'package:injectable/injectable.dart';

import '../entities/service_entity.dart';
import '../repositories/home_repository.dart';

@injectable
class GetServicesUseCase {
  final HomeRepository repository;
  GetServicesUseCase(this.repository);

  Future<List<ServiceEntity>> call() {
    return repository.getServices();
  }
}
