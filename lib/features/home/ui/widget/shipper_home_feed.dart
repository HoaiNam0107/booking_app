import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/home/ui/widget/widget_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget feed trang chủ của shipper
/// Tách ra từ _ShipperHomeFeed trong home_page.dart
class ShipperHomeFeed extends StatelessWidget {
  final bool isOnline;
  final VoidCallback onToggleOnline;

  const ShipperHomeFeed({
    super.key,
    required this.isOnline,
    required this.onToggleOnline,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header(context)),
          SliverToBoxAdapter(child: _statGrid()),
          SliverToBoxAdapter(child: _currentDelivery()),
          SliverToBoxAdapter(child: _earningChart()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final name = state is AuthAuthenticated ? state.user.displayName ?? 'Shipper' : 'Shipper';
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.circle, size: 8, color: isOnline ? AppColors.success : AppColors.textSecondary),
                const SizedBox(width: 5),
                Text(isOnline ? 'Đang trực tuyến' : 'Ngoại tuyến',
                    style: TextStyle(fontSize: 12, color: isOnline ? AppColors.success : AppColors.textSecondary, fontWeight: FontWeight.w500)),
              ]),
              const SizedBox(height: 2),
              Text(name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ])),
            GestureDetector(
              onTap: onToggleOnline,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 52, height: 28,
                decoration: BoxDecoration(color: isOnline ? AppColors.success : AppColors.divider, borderRadius: BorderRadius.circular(14)),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: isOnline ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(padding: const EdgeInsets.all(3),
                      child: Container(width: 22, height: 22, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget _statGrid() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    child: GridView.count(
      crossAxisCount: 2, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.2,
      children:  [
        StatCard(value: '12', label: 'Chuyến hôm nay', color: AppColors.shipperColor),
        StatCard(value: '480k', label: 'Thu nhập', color: AppColors.primary),
        StatCard(value: '4.9 ⭐', label: 'Đánh giá', color: AppColors.warning),
        StatCard(value: '48 km', label: 'Đã đi', color: AppColors.success),
      ],
    ),
  );

  Widget _currentDelivery() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Đơn hàng hiện tại', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: 10),
      Container(
        height: 120,
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFE3F2FD)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
        child: Stack(children: [
          const Center(child: Text('🗺️', style: TextStyle(fontSize: 44))),
          Positioned(bottom: 10, left: 0, right: 0, child: Center(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
            child: const Text('Đang điều hướng...', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ))),
        ]),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
        child: Column(children: [
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: Text('Bún Bò Bà Ba → 45 Lê Lợi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 6),
          const Row(children: [
            Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textSecondary),
            SizedBox(width: 4),
            Text('Nguyễn Văn A · 0901 234 567', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.phone_rounded, size: 14), label: const Text('Gọi'), style: OutlinedButton.styleFrom(minimumSize: const Size(0, 38), foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary)))),
            const SizedBox(width: 10),
            Expanded(flex: 2, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.check_rounded, size: 14), label: const Text('Đã lấy hàng'), style: ElevatedButton.styleFrom(minimumSize: const Size(0, 38), textStyle: const TextStyle(fontSize: 13)))),
          ]),
        ]),
      ),
    ]),
  );

  Widget _earningChart() {
    final data = [40.0, 65.0, 45.0, 80.0, 55.0, 90.0, 70.0];
    final days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Thu nhập tuần này', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          const Text('3.200.000đ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.shipperColor)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (i) {
              final h = data[i] / 100 * 80;
              return Expanded(child: Column(children: [
                Container(height: h, margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(color: i == 5 ? AppColors.shipperColor : AppColors.shipperColor.withOpacity(0.2), borderRadius: BorderRadius.circular(6))),
                const SizedBox(height: 4),
                Text(days[i], style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              ]));
            }),
          ),
        ]),
      ),
    );
  }
}