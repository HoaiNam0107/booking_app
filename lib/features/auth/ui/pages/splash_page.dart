import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final AnimationController _contentCtrl;
  late final Animation<double> _logoScale;
  late final Animation<double> _contentFade;

  bool _showCta = false;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _contentCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _logoScale =
        CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut)
            .drive(Tween(begin: 0.0, end: 1.0));

    _contentFade =
        CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOut)
            .drive(Tween(begin: 0.0, end: 1.0));

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _logoCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    _contentCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _showCta = true);

    // Trigger check session sau khi animation xong
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    context.read<AuthBloc>().add(const AuthCheckStatusRequested());
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ KHÔNG bọc BlocProvider ở đây
    // AuthBloc đã được provide global từ MultiBlocProvider trong main.dart
    // Chỉ cần BlocListener để lắng nghe state thay đổi
    return BlocListener<AuthBloc, AuthState>(
      listener: _onAuthStateChanged,
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildDecorativeCircles(),
            SafeArea(
              child: Column(
                children: [
                  Expanded(child: _buildLogoSection()),
                  _buildCtaPanel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Listener ─────────────────────────────────────────────────────────────

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      _navigateByRole(context, state.user.role);
    }
    // AuthUnauthenticated → không làm gì, user tự bấm Login/Register
  }

  void _navigateByRole(BuildContext context, UserRole role) {
    switch (role) {
      case UserRole.seller:
        context.router.replaceAll([const HomeSellerRoute()]);
      case UserRole.shipper:
        context.router.replaceAll([const HomeShipperRoute()]);
      case UserRole.admin:
        context.router.replaceAll([const HomeAdminRoute()]);
      case UserRole.customer:
      default:
        context.router.replaceAll([const HomeCustomerRoute()]);
    }
  }

  // ── UI builders ───────────────────────────────────────────────────────────

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF5722), Color(0xFFFF8C42), Color(0xFFFFD166)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        Positioned(
          top: -80, right: -80,
          child: _circle(220, 0.07),
        ),
        Positioned(
          top: 100, right: 24,
          child: _circle(80, 0.10),
        ),
        Positioned(
          bottom: 200, left: -40,
          child: _circle(140, 0.06),
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        ScaleTransition(
          scale: _logoScale,
          child: Container(
            width: 90, height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Center(
              child: Text('🍜', style: TextStyle(fontSize: 42)),
            ),
          ),
        ),
        const SizedBox(height: 26),

        // Title + subtitle
        FadeTransition(
          opacity: _contentFade,
          child: Column(
            children: [
              const Text(
                'QuickBite',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Đặt đồ ăn nhanh chóng\nGiao hàng tận nơi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.88),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),

        // Dots
        FadeTransition(
          opacity: _contentFade,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(true),
              const SizedBox(width: 6),
              _dot(false),
              const SizedBox(width: 6),
              _dot(false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCtaPanel() {
    return AnimatedSlide(
      offset: _showCta ? Offset.zero : const Offset(0, 0.3),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _showCta ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 350),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => context.router.push(const LoginRoute()),
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.router.push(const RegisterRoute()),
                child: const Text('Tạo tài khoản'),
              ),
              const SizedBox(height: 18),
              Text(
                'Bằng cách tiếp tục, bạn đồng ý với\nĐiều khoản dịch vụ của QuickBite',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _circle(double size, double opacity) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(opacity),
    ),
  );

  Widget _dot(bool active) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: active ? 22 : 6,
    height: 6,
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.white.withOpacity(0.4),
      borderRadius: BorderRadius.circular(3),
    ),
  );
}