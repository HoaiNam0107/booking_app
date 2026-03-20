import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/home/ui/widget/profile_page.dart';
import 'package:booking_app/features/home/ui/widget/customer_explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/custom_home_feed.dart';

@RoutePage()
class HomeCustomerPage extends StatefulWidget {
  const HomeCustomerPage({super.key});

  @override
  State<HomeCustomerPage> createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> {
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
                const CustomerHomeFeed(),
                const CustomerExplorePage(),
                const CustomerOrdersPage(),
                const CustomerMessagesPage(),
                _ProfileTabWrapper(user: user),
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
        selectedItemColor: AppColors.userColor,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: AppColors.background,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 22), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_rounded, size: 22), label: 'Khám phá'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded, size: 22), label: 'Đơn hàng'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded, size: 22), label: 'Tin nhắn'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 22), label: 'Tôi'),
        ],
      ),
    );
  }
}

class _ProfileTabWrapper extends StatelessWidget {
  final dynamic user;

  const _ProfileTabWrapper({required this.user});

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return ProfilePage(user: user, accentColor: AppColors.userColor);
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.userColor),
      ),
    );
  }
}