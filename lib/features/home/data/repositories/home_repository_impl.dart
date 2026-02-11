import 'package:injectable/injectable.dart';

import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_firestore_data_source.dart';
import '../models/service_model.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeFirestoreDataSource firestore;

  HomeRepositoryImpl(this.firestore);

  @override
  Future<List<ServiceEntity>> getServices() async {
    final models = await firestore.getServices();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> createService(ServiceEntity service) {
    return firestore.createService(
      ServiceModel(
        id: service.id,
        ownerId: service.ownerId,
        title: service.title,
        description: service.description,
        price: service.price,
        isAvailable: service.isAvailable,
      ),
    );
  }
}
