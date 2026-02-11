import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/auth_user_entity.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../../../../core/bloc/base_state.dart';
import '../../domain/entities/service_entity.dart';

class CustomerHomeView extends StatelessWidget {
  final AuthUserEntity user;

  const CustomerHomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dịch vụ')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.status.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (msg) => Center(child: Text(msg)),
            success: (services) => _ServiceList(services: services),
          );
        },
      ),
    );
  }
}

class _ServiceList extends StatelessWidget {
  final List<ServiceEntity> services;

  const _ServiceList({required this.services});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const Center(child: Text('Chưa có dịch vụ nào'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final s = services[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            title: Text(s.title),
            subtitle: Text(s.description),
            trailing: Text('${s.price} ₫'),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Chức năng thuê sẽ làm sau')));
            },
          ),
        );
      },
    );
  }
}
