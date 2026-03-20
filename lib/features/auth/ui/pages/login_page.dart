import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/auth/ui/widgets/auth_text_field.dart';
import 'package:booking_app/features/auth/ui/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _onStateChanged,
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 32),
                  AuthTextField(
                    label: 'Email hoặc số điện thoại',
                    hint: 'example@email.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.alternate_email_rounded,
                    validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập email' : null,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    label: 'Mật khẩu',
                    hint: '••••••••',
                    controller: _passCtrl,
                    obscureText: _obscure,
                    prefixIcon: Icons.lock_outline_rounded,
                    textInputAction: TextInputAction.done,
                    suffixIcon: _visibilityBtn(),
                    validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập mật khẩu' : null,
                  ),
                  const SizedBox(height: 6),
                  _buildForgotBtn(),
                  const SizedBox(height: 12),
                  _buildLoginBtn(context, state),
                  const SizedBox(height: 24),
                  _buildDivider(),
                  const SizedBox(height: 20),
                  const SocialLoginRow(),
                  const SizedBox(height: 28),
                  _buildSignUpLink(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Builders ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Text('🍜', style: TextStyle(fontSize: 28))),
          ),
          const SizedBox(height: 20),
          const Text(
            'Chào mừng trở lại!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Đăng nhập để tiếp tục',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _visibilityBtn() => IconButton(
    icon: Icon(
      _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      color: AppColors.textSecondary,
      size: 20,
    ),
    onPressed: () => setState(() => _obscure = !_obscure),
  );

  Widget _buildForgotBtn() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {}, // TODO: forgot password
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: const Text('Quên mật khẩu?'),
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context, AuthState state) {
    return ElevatedButton(
      onPressed: state is AuthLoading ? null : () => _submit(context),
      child: state is AuthLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Text('Đăng nhập'),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('hoặc', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chưa có tài khoản? ',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          GestureDetector(
            onTap: () => context.router.push(const RegisterRoute()),
            child: const Text(
              'Đăng ký ngay',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logic ─────────────────────────────────────────────────────────────────

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(email: _emailCtrl.text.trim(), password: _passCtrl.text),
      );
    }
  }

  void _onStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailureState) {
      _showError(context, state.message);
    }

    if (state is AuthAuthenticated) {
      _routeByRole(context, state.user.role);
    }

    // ── Seller chờ duyệt ────────────────────────────────────────────────────
    if (state is AuthSellerPendingApproval) {
      _showSellerPendingDialog(context);
    }

    // ── Seller bị từ chối ───────────────────────────────────────────────────
    if (state is AuthSellerRejected) {
      _showSellerRejectedDialog(context, state.message);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSellerPendingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.access_time_rounded,
                  color: AppColors.warning, size: 32),
            ),
            const SizedBox(height: 16),
            const Text('Đang chờ xét duyệt',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'Hồ sơ cửa hàng của bạn đang được xem xét.\nThời gian xử lý: 1–3 ngày làm việc.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warning,
                minimumSize: const Size(double.infinity, 44),
              ),
              child: const Text('Đã hiểu'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSellerRejectedDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.store_outlined,
                  color: AppColors.error, size: 32),
            ),
            const SizedBox(height: 16),
            const Text('Đăng ký bị từ chối',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                minimumSize: const Size(double.infinity, 44),
              ),
              child: const Text('Liên hệ hỗ trợ'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Đóng'),
            ),
          ],
        ),
      ),
    );
  }

  void _routeByRole(BuildContext context, UserRole role) {
    switch (role) {
      case UserRole.seller:
        context.router.replaceAll([const HomeSellerRoute()]);
      case UserRole.shipper:
        context.router.replaceAll([const HomeShipperRoute()]);
      case UserRole.admin:
        context.router.replaceAll([const HomeAdminRoute()]);
      case UserRole.customer:
        context.router.replaceAll([const HomeCustomerRoute()]);
    }
  }
}
