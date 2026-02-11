import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/service_model.dart';

abstract class HomeFirestoreDataSource {
  Future<List<ServiceModel>> getServices();
  Future<void> createService(ServiceModel service);
}

@LazySingleton(as: HomeFirestoreDataSource)
class HomeFirestoreDataSourceImpl implements HomeFirestoreDataSource {
  final FirebaseFirestore _firestore;

  HomeFirestoreDataSourceImpl(this._firestore);

  @override
  Future<List<ServiceModel>> getServices() async {
    final snapshot = await _firestore.collection('services').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ServiceModel(
        id: doc.id,
        ownerId: data['ownerId'],
        title: data['title'],
        description: data['description'],
        price: (data['price'] as num).toDouble(),
        isAvailable: data['isAvailable'],
      );
    }).toList();
  }

  @override
  Future<void> createService(ServiceModel service) async {
    await _firestore.collection('services').add({
      'ownerId': service.ownerId,
      'title': service.title,
      'description': service.description,
      'price': service.price,
      'isAvailable': service.isAvailable,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
