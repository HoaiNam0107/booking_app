import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/admin/domain/entities/seller_request_entity.dart';
import 'package:booking_app/features/admin/ui/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSellerApprovalPage extends StatefulWidget {
  const AdminSellerApprovalPage({super.key});

  @override
  State<AdminSellerApprovalPage> createState() => _AdminSellerApprovalPageState();
}

class _AdminSellerApprovalPageState extends State<AdminSellerApprovalPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    // Trigger watch Firestore realtime
    context.read<AdminBloc>().add(const AdminWatchSellersStarted());
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listenWhen: (prev, curr) =>
          curr.successMessage != null && curr.successMessage != prev.successMessage ||
          curr.errorMessage != null && curr.errorMessage != prev.errorMessage,
      listener: (context, state) {
        // ── Thành công ────────────────────────────────────────────────────────
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(state.successMessage!)),
                  ],
                ),
                backgroundColor: AppColors.sellerColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
        }

        // ── Lỗi ──────────────────────────────────────────────────────────────
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(state.errorMessage!)),
                  ],
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: const [
                  _SellerTabList(status: SellerStatus.pending),
                  _SellerTabList(status: SellerStatus.approved),
                  _SellerTabList(status: SellerStatus.rejected),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Duyệt nhà hàng',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${state.pendingSellers.length} đang chờ duyệt',
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            if (state.pendingSellers.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.pending_rounded, size: 14, color: AppColors.warning),
                    const SizedBox(width: 5),
                    Text(
                      '${state.pendingSellers.length} chờ',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) => TabBar(
        controller: _tabCtrl,
        labelColor: AppColors.adminColor,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.adminColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        tabs: [
          Tab(text: 'Chờ (${state.pendingSellers.length})'),
          Tab(text: 'Duyệt (${state.approvedSellers.length})'),
          Tab(text: 'Từ chối (${state.rejectedSellers.length})'),
        ],
      ),
    );
  }
}

// ── Tab list theo status ──────────────────────────────────────────────────────

class _SellerTabList extends StatelessWidget {
  final SellerStatus status;
  const _SellerTabList({required this.status});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        final list = switch (status) {
          SellerStatus.pending => state.pendingSellers,
          SellerStatus.approved => state.approvedSellers,
          SellerStatus.rejected => state.rejectedSellers,
        };

        if (state.sellersLoading && list.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.adminColor));
        }

        if (list.isEmpty) {
          return _emptyState(status);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (_, i) => _SellerCard(seller: list[i]),
        );
      },
    );
  }

  Widget _emptyState(SellerStatus s) {
    final (msg, icon) = switch (s) {
      SellerStatus.pending => ('Không có nhà hàng chờ duyệt', Icons.store_outlined),
      SellerStatus.approved => ('Chưa có nhà hàng được duyệt', Icons.check_circle_outline),
      SellerStatus.rejected => ('Chưa có nhà hàng bị từ chối', Icons.cancel_outlined),
    };
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: AppColors.textHint),
          const SizedBox(height: 12),
          Text(msg, style: const TextStyle(fontSize: 15, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          Text(
            'Dữ liệu sẽ cập nhật tự động',
            style: TextStyle(fontSize: 12, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }
}

// ── Seller Card ───────────────────────────────────────────────────────────────

class _SellerCard extends StatelessWidget {
  final SellerRequestEntity seller;
  const _SellerCard({required this.seller});

  @override
  Widget build(BuildContext context) {
    final borderColor = switch (seller.status) {
      SellerStatus.pending => AppColors.warning.withOpacity(0.4),
      SellerStatus.approved => AppColors.sellerColor.withOpacity(0.3),
      SellerStatus.rejected => AppColors.error.withOpacity(0.3),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Shop header ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.sellerColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.store_rounded, size: 22, color: AppColors.sellerColor),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.shopName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        seller.shopCategory,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                _StatusChip(status: seller.status),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.divider),

          // ── Info grid ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _infoItem(
                        Icons.person_outline_rounded,
                        'Chủ shop',
                        seller.displayName,
                      ),
                    ),
                    Expanded(child: _infoItem(Icons.phone_outlined, 'SĐT', seller.phoneNumber)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _infoItem(Icons.alternate_email_rounded, 'Email', seller.email),
                    ),
                    if (seller.dateOfBirth != null)
                      Expanded(
                        child: _infoItem(Icons.cake_outlined, 'Ngày sinh', seller.dateOfBirth!),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                _infoItem(Icons.location_on_outlined, 'Địa chỉ cửa hàng', seller.shopAddress),
                if (seller.address != null) ...[
                  const SizedBox(height: 6),
                  _infoItem(Icons.home_outlined, 'Địa chỉ cá nhân', seller.address!),
                ],
                const SizedBox(height: 6),
                _infoItem(
                  Icons.access_time_rounded,
                  'Ngày đăng ký',
                  '${seller.createdAt.day.toString().padLeft(2, '0')}/'
                      '${seller.createdAt.month.toString().padLeft(2, '0')}/'
                      '${seller.createdAt.year}',
                ),

                // Lý do từ chối
                if (seller.rejectedReason != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.error.withOpacity(0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: AppColors.error),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Lý do từ chối: ${seller.rejectedReason}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.error,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Action buttons (chỉ pending) ──────────────────────────────────
          if (seller.status == SellerStatus.pending) ...[
            const Divider(height: 1, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showRejectDialog(context),
                      icon: const Icon(Icons.close_rounded, size: 14),
                      label: const Text('Từ chối'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () => context.read<AdminBloc>().add(AdminApproveSeller(seller.id)),
                      icon: const Icon(Icons.check_rounded, size: 14),
                      label: const Text('Phê duyệt'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        backgroundColor: AppColors.sellerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final reasonCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.store_outlined, color: AppColors.error, size: 24),
            ),
            const SizedBox(height: 14),
            Text(
              'Từ chối "${seller.shopName}"?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: reasonCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập lý do từ chối...',
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.error),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44)),
                    child: const Text('Huỷ'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final reason = reasonCtrl.text.trim();
                      if (reason.isEmpty) return;
                      context.read<AdminBloc>().add(
                        AdminRejectSeller(userId: seller.id, reason: reason),
                      );
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      minimumSize: const Size(0, 44),
                    ),
                    child: const Text('Xác nhận'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final SellerStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      SellerStatus.pending => (
        'Chờ duyệt',
        AppColors.statusPreparing,
        AppColors.statusPreparingText,
      ),
      SellerStatus.approved => ('Đã duyệt', AppColors.statusDone, AppColors.statusDoneText),
      SellerStatus.rejected => ('Từ chối', AppColors.error.withOpacity(0.1), AppColors.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(7)),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
