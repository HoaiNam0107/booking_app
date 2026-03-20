import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ProfilePage — KHÔNG đặt BlocListener ở đây
/// Listener logout được đặt ở HomeXxxPage (parent) để đảm bảo
/// context luôn valid dù IndexedStack ẩn/hiện widget
class ProfilePage extends StatelessWidget {
  final UserEntity user;
  final Color accentColor;

  const ProfilePage({
    super.key,
    required this.user,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildInfoCard()),
          SliverToBoxAdapter(child: _buildMenuSection(context)),
          if (user.role == UserRole.seller)
            SliverToBoxAdapter(child: _buildShopCard()),
          SliverToBoxAdapter(child: _buildLogoutBtn(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 84, height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.25),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Center(
              child: Text(
                _initials,
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            user.displayName ?? 'Người dùng',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              user.role.label,
              style: const TextStyle(
                  fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ── Info card ─────────────────────────────────────────────────────────────

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            _infoRow(Icons.alternate_email_rounded, 'Email', user.email),
            _divider(),
            _infoRow(Icons.phone_outlined, 'Số điện thoại', user.phoneNumber ?? '—'),
            _divider(),
            _infoRow(Icons.calendar_today_outlined, 'Ngày sinh', user.dateOfBirth ?? '—'),
            _divider(),
            _infoRow(Icons.location_on_outlined, 'Địa chỉ', user.address ?? '—'),
            _divider(),
            _infoRow(
              Icons.verified_outlined,
              'Trạng thái email',
              user.isEmailVerified ? 'Đã xác thực' : 'Chưa xác thực',
              valueColor: user.isEmailVerified ? AppColors.success : AppColors.warning,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 2),
                Text(value,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: valueColor ?? AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, indent: 46, color: AppColors.divider);

  // ── Menu section ──────────────────────────────────────────────────────────

  Widget _buildMenuSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            _menuRow(Icons.edit_outlined, 'Chỉnh sửa thông tin', accentColor, () {}),
            _divider(),
            _menuRow(Icons.lock_outline_rounded, 'Đổi mật khẩu', accentColor, () {}),
            _divider(),
            _menuRow(Icons.notifications_outlined, 'Thông báo', accentColor, () {}),
            _divider(),
            _menuRow(Icons.help_outline_rounded, 'Trợ giúp & hỗ trợ', accentColor, () {}),
            _divider(),
            _menuRow(Icons.info_outline_rounded, 'Về ứng dụng', accentColor, () {}),
          ],
        ),
      ),
    );
  }

  Widget _menuRow(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary)),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  // ── Shop card (seller only) ───────────────────────────────────────────────

  Widget _buildShopCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.sellerColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.sellerColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                    color: AppColors.sellerColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.storefront_rounded,
                    size: 16, color: AppColors.sellerColor),
              ),
              const SizedBox(width: 10),
              const Text('Thông tin cửa hàng',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
            ]),
            const SizedBox(height: 12),
            _shopRow('Tên cửa hàng', user.shopName ?? '—'),
            const SizedBox(height: 6),
            _shopRow('Địa chỉ', user.shopAddress ?? '—'),
            const SizedBox(height: 6),
            _shopRow('Loại hình', user.shopCategory ?? '—'),
            const SizedBox(height: 6),
            Row(children: [
              Text('Trạng thái: ',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: user.isActive ? AppColors.statusDone : AppColors.statusPreparing,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  user.isActive ? 'Đang hoạt động' : 'Chờ duyệt',
                  style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w500,
                    color: user.isActive
                        ? AppColors.statusDoneText
                        : AppColors.statusPreparingText,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _shopRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary)),
        ),
      ],
    );
  }

  // ── Logout button ─────────────────────────────────────────────────────────

  Widget _buildLogoutBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: InkWell(
        onTap: () => _showLogoutDialog(context),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.error.withOpacity(0.2)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 18, color: AppColors.error),
              SizedBox(width: 8),
              Text('Đăng xuất',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.error)),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: const Icon(Icons.logout_rounded,
                  color: AppColors.error, size: 24),
            ),
            const SizedBox(height: 16),
            const Text('Đăng xuất?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'Bạn có chắc muốn đăng xuất khỏi tài khoản không?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 44)),
                    child: const Text('Huỷ'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      // ✅ Dùng context của ProfilePage (không phải dialogContext)
                      // để read AuthBloc từ global tree
                      context.read<AuthBloc>().add(const AuthLogoutRequested());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      minimumSize: const Size(0, 44),
                    ),
                    child: const Text('Đăng xuất'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String get _initials {
    final name = user.displayName ?? user.email;
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }
}