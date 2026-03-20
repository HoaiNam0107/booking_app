import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/ui/widget/profile_page.dart';
import 'admin_create_shipper_page.dart';
import 'admin_seller_approval_page.dart';

@RoutePage()
class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          setState(() => _tab = 0);
          context.router.replaceAll([const LoginRoute()]);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          return Scaffold(
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: _tab,
              children: [
                const AdminDashboardPage(),
                const AdminSellerApprovalPage(),
                const AdminCreateShipperPage(),
                _AdminProfileTab(user: user),
              ],
            ),
            bottomNavigationBar: _buildBottomNav(),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider, width: 0.5))),
      child: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.adminColor,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 11, unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: AppColors.background, elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded, size: 22), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.store_rounded, size: 22), label: 'Duyệt shop'),
          BottomNavigationBarItem(icon: Icon(Icons.delivery_dining_rounded, size: 22), label: 'Shipper'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 22), label: 'Tôi'),
        ],
      ),
    );
  }
}

class _AdminProfileTab extends StatelessWidget {
  final UserEntity? user;
  const _AdminProfileTab({required this.user});

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return ProfilePage(user: user!, accentColor: AppColors.adminColor);
    }
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: AppColors.adminColor)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ADMIN DASHBOARD
// ─────────────────────────────────────────────────────────────────────────────
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildStatGrid()),
          SliverToBoxAdapter(child: _buildSectionTitle('Hoạt động gần đây')),
          SliverToBoxAdapter(child: _buildActivityList()),
          SliverToBoxAdapter(child: _buildSectionTitle('Thống kê hệ thống')),
          SliverToBoxAdapter(child: _buildSystemStats()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final name = state is AuthAuthenticated ? state.user.displayName ?? 'Admin' : 'Admin';
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.adminColor, AppColors.adminColor.withOpacity(0.8)],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Center(child: Icon(Icons.admin_panel_settings_rounded, color: Colors.white, size: 22)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Xin chào, $name', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('Quản trị hệ thống', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8))),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    const Text('Online', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
                  ]),
                ),
              ]),
              const SizedBox(height: 20),
              Row(children: [
                _miniStat('3', 'Chờ duyệt'),
                const SizedBox(width: 12),
                _miniStat('124', 'Người dùng'),
                const SizedBox(width: 12),
                _miniStat('18', 'Shipper'),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget _miniStat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
        ]),
      ),
    );
  }

  Widget _buildStatGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: GridView.count(
        crossAxisCount: 2, shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.8,
        children: const [
          _AdminStatCard(icon: Icons.store_rounded, value: '42', label: 'Nhà hàng', color: AppColors.sellerColor),
          _AdminStatCard(icon: Icons.delivery_dining_rounded, value: '18', label: 'Shipper', color: AppColors.shipperColor),
          _AdminStatCard(icon: Icons.people_rounded, value: '1.2K', label: 'Khách hàng', color: AppColors.userColor),
          _AdminStatCard(icon: Icons.receipt_long_rounded, value: '384', label: 'Đơn hôm nay', color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String t) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
    child: Text(t, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
  );

  Widget _buildActivityList() {
    final items = [
      _ActivityData(Icons.store_rounded, 'Nhà hàng Phở Thìn đăng ký', 'Chờ duyệt', AppColors.warning, '5 phút trước'),
      _ActivityData(Icons.delivery_dining_rounded, 'Shipper Minh Tú đăng nhập', 'Hoạt động', AppColors.success, '12 phút trước'),
      _ActivityData(Icons.people_rounded, 'Người dùng mới đăng ký', 'Khách hàng', AppColors.info, '30 phút trước'),
      _ActivityData(Icons.store_rounded, 'Burger Nhà Làm được duyệt', 'Đã duyệt', AppColors.success, '1 giờ trước'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
        child: Column(
          children: List.generate(items.length, (i) => Column(children: [
            _activityTile(items[i]),
            if (i < items.length - 1) const Divider(height: 1, indent: 52, color: AppColors.divider),
          ])),
        ),
      ),
    );
  }

  Widget _activityTile(_ActivityData d) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: d.color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(d.icon, size: 16, color: d.color),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(d.time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: d.color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
          child: Text(d.status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: d.color)),
        ),
      ]),
    );
  }

  Widget _buildSystemStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
        child: Column(children: [
          _systemRow('Tổng doanh thu hôm nay', '24.500.000đ', AppColors.primary),
          const Divider(height: 20, color: AppColors.divider),
          _systemRow('Đơn hàng thành công', '342 / 384', AppColors.success),
          const Divider(height: 20, color: AppColors.divider),
          _systemRow('Đơn hàng bị huỷ', '42', AppColors.error),
          const Divider(height: 20, color: AppColors.divider),
          _systemRow('Đánh giá trung bình', '4.7 ⭐', AppColors.warning),
        ]),
      ),
    );
  }

  Widget _systemRow(String label, String value, Color color) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
    ]);
  }
}

class _ActivityData {
  final IconData icon;
  final String title, status, time;
  final Color color;
  const _ActivityData(this.icon, this.title, this.status, this.color, this.time);
}

class _AdminStatCard extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color color;
  const _AdminStatCard({required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 18, color: color)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ]),
      ]),
    );
  }
}
