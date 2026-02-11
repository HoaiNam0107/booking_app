import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/domain/entities/auth_user_entity.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../../../core/bloc/base_state.dart';
import '../../domain/entities/service_entity.dart';

class ProviderHomeView extends StatelessWidget {
  final AuthUserEntity user;

  const ProviderHomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dịch vụ của tôi')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateServiceDialog(context, user),
        child: const Icon(Icons.add),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          state.status.whenOrNull(
            success: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tạo dịch vụ thành công')),
              );
            },
          );
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.status.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (msg) => Center(child: Text(msg)),
              success: (services) {
                final myServices =
                services.where((e) => e.ownerId == user.uid).toList();

                if (myServices.isEmpty) {
                  return const Center(child: Text('Bạn chưa tạo dịch vụ nào'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: myServices.length,
                  itemBuilder: (context, index) {
                    final s = myServices[index];
                    return Card(
                      shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        title: Text(s.title),
                        subtitle: Text(s.description),
                        trailing: Text('${s.price} ₫'),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void _showCreateServiceDialog(BuildContext context, user) {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Tạo dịch vụ'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Tên')),
          TextField(
              controller: descCtrl, decoration: const InputDecoration(labelText: 'Mô tả')),
          TextField(
            controller: priceCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Giá'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
        ElevatedButton(
          onPressed: () {
            final service = ServiceEntity(
              id: const Uuid().v4(),
              ownerId: user.uid,
              title: titleCtrl.text,
              description: descCtrl.text,
              price: double.parse(priceCtrl.text),
              isAvailable: true,
            );

            context.read<HomeBloc>().add(HomeCreateService(service: service));
            Navigator.pop(context);
          },
          child: const Text('Tạo'),
        ),
      ],
    ),
  );
}