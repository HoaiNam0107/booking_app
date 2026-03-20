import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/home/ui/widget/profile_page.dart';
import 'package:booking_app/features/home/ui/widget/seller_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/seller_dash_board.dart';

@RoutePage()
class HomeSellerPage extends StatefulWidget {
  const HomeSellerPage({super.key});

  @override
  State<HomeSellerPage> createState() => _HomeSellerPageState();
}

class _HomeSellerPageState extends State<HomeSellerPage> {
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
                const SellerDashboardFeed(),
                const SellerOrdersPage(),
                const SellerMenuPage(),
                const SellerChatPage(),
                _SellerProfileTab(user: user),
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
        selectedItemColor: AppColors.sellerColor,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 11, unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: AppColors.background, elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded, size: 22), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded, size: 22), label: 'Đơn hàng'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu_rounded, size: 22), label: 'Thực đơn'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded, size: 22), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 22), label: 'Tôi'),
        ],
      ),
    );
  }
}

class _SellerProfileTab extends StatelessWidget {
  final UserEntity? user;
  const _SellerProfileTab({required this.user});

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return ProfilePage(user: user!, accentColor: AppColors.sellerColor);
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.sellerColor),
      ),
    );
  }
}