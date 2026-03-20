import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/home/ui/widget/widget_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget dashboard trang chủ của người bán
/// Tách ra từ _SellerDashboard trong home_page.dart
class SellerDashboardFeed extends StatelessWidget {
  const SellerDashboardFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _header(context)),
          SliverToBoxAdapter(child: _statGrid()),
          SliverToBoxAdapter(child: _sectionTitle('Đơn hàng đang xử lý')),
          SliverToBoxAdapter(child: _orderItem('🍜', 'Nguyễn Văn A', '2x Bún bò · 1x Chả giò', '85.000đ', HomeOrderStatus.newOrder)),
          SliverToBoxAdapter(child: _orderItem('🍱', 'Trần Thị B', '1x Cơm sườn · 1x Nước', '55.000đ', HomeOrderStatus.preparing)),
          SliverToBoxAdapter(child: _orderItem('🍔', 'Lê Minh C', '3x Burger · 2x Khoai tây', '175.000đ', HomeOrderStatus.done)),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.storefront_rounded, color: AppColors.sellerColor, size: 14),
                const SizedBox(width: 4),
                Text('Cửa hàng', style: TextStyle(fontSize: 12, color: AppColors.sellerColor, fontWeight: FontWeight.w500)),
              ]),
              const SizedBox(height: 2),
              Text(user?.shopName ?? user?.displayName ?? 'Cửa hàng', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: AppColors.statusDone, borderRadius: BorderRadius.circular(20)),
              child: const Row(children: [
                Icon(Icons.circle, size: 8, color: AppColors.sellerColor),
                SizedBox(width: 5),
                Text('Đang mở', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.sellerColor)),
              ]),
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
        StatCard(value: '24', label: 'Đơn hôm nay', color: AppColors.sellerColor),
        StatCard(value: '1.4tr', label: 'Doanh thu', color: AppColors.primary),
        StatCard(value: '4.8 ⭐', label: 'Đánh giá', color: AppColors.warning),
        StatCard(value: '3', label: 'Đang chờ', color: AppColors.info),
      ],
    ),
  );

  Widget _sectionTitle(String t) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
    child: Text(t, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
  );

  Widget _orderItem(String emoji, String name, String items, String price, HomeOrderStatus status) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
      child: Row(children: [
        Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)), child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20)))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 3),
          Text(items, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
          const SizedBox(height: 4),
          StatusBadge(status: status),
        ]),
      ]),
    ),
  );
}