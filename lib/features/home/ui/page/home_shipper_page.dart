import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/home/ui/widget/profile_page.dart';
import 'package:booking_app/features/home/ui/widget/shipper_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/shipper_home_feed.dart';

@RoutePage()
class HomeShipperPage extends StatefulWidget {
  const HomeShipperPage({super.key});

  @override
  State<HomeShipperPage> createState() => _HomeShipperPageState();
}

class _HomeShipperPageState extends State<HomeShipperPage> {
  int _tab = 0;
  bool _isOnline = true;

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
                ShipperHomeFeed(
                  isOnline: _isOnline,
                  onToggleOnline: () => setState(() => _isOnline = !_isOnline),
                ),
                const ShipperHistoryPage(),
                const ShipperEarningsPage(),
                _ShipperProfileTab(user: user),
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
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.shipperColor,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: AppColors.background,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 22), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded, size: 22), label: 'Lịch sử'),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_rounded, size: 22),
            label: 'Thu nhập',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 22), label: 'Tôi'),
        ],
      ),
    );
  }
}

class _ShipperProfileTab extends StatelessWidget {
  final UserEntity? user;
  const _ShipperProfileTab({required this.user});

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return ProfilePage(user: user!, accentColor: AppColors.shipperColor);
    }
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: AppColors.shipperColor)),
    );
  }
}
