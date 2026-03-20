import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/admin/ui/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCreateShipperPage extends StatefulWidget {
  const AdminCreateShipperPage({super.key});

  @override
  State<AdminCreateShipperPage> createState() => _AdminCreateShipperPageState();
}

class _AdminCreateShipperPageState extends State<AdminCreateShipperPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _vehicleCtrl = TextEditingController();
  final _licenseCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    // Load danh sách shipper từ Firestore
    context.read<AdminBloc>().add(const AdminWatchShippersStarted());
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    for (final c in [
      _nameCtrl,
      _phoneCtrl,
      _emailCtrl,
      _passCtrl,
      _dobCtrl,
      _vehicleCtrl,
      _licenseCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        // Tạo thành công → clear form + chuyển sang tab danh sách
        if (state.createShipperSuccess) {
          _clearForm();
          _tabCtrl.animateTo(1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Tạo tài khoản shipper thành công!'),
              backgroundColor: AppColors.adminColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
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
                children: [_buildCreateForm(), _buildShipperList()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() => const Padding(
    padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Quản lý Shipper',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      ),
    ),
  );

  Widget _buildTabBar() => TabBar(
    controller: _tabCtrl,
    labelColor: AppColors.adminColor,
    unselectedLabelColor: AppColors.textSecondary,
    indicatorColor: AppColors.adminColor,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    tabs: const [
      Tab(text: 'Tạo tài khoản'),
      Tab(text: 'Danh sách'),
    ],
  );

  // ── Create form ───────────────────────────────────────────────────────────

  Widget _buildCreateForm() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) => SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Thông tin cá nhân'),
              const SizedBox(height: 10),
              _field(
                'Họ và tên',
                'Nguyễn Văn A',
                _nameCtrl,
                Icons.person_outline_rounded,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 12),
              _field(
                'Số điện thoại',
                '0901 234 567',
                _phoneCtrl,
                Icons.phone_outlined,
                type: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập SĐT' : null,
              ),
              const SizedBox(height: 12),
              _field(
                'Email',
                'shipper@gmail.com',
                _emailCtrl,
                Icons.alternate_email_rounded,
                type: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                  if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(v)) return 'Email không hợp lệ';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _field(
                'Mật khẩu',
                'Tối thiểu 8 ký tự',
                _passCtrl,
                Icons.lock_outline_rounded,
                obscure: _obscure,
                suffix: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
                validator: (v) => (v == null || v.length < 8) ? 'Tối thiểu 8 ký tự' : null,
              ),
              const SizedBox(height: 12),
              _field(
                'Ngày sinh',
                'DD/MM/YYYY',
                _dobCtrl,
                Icons.calendar_today_outlined,
                readOnly: true,
                onTap: _pickDob,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng chọn ngày sinh' : null,
              ),
              const SizedBox(height: 20),
              _sectionLabel('Phương tiện'),
              const SizedBox(height: 10),
              _vehicleDropdown(),
              const SizedBox(height: 12),
              _field(
                'Biển số xe',
                '51G-123.45',
                _licenseCtrl,
                Icons.confirmation_number_outlined,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập biển số' : null,
              ),
              const SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: state.createShipperLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminColor,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: state.createShipperLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text(
                        'Tạo tài khoản Shipper',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 16),

              // Note
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.info.withOpacity(0.2)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded, size: 16, color: AppColors.info),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tài khoản shipper sẽ được tạo ngay lập tức và có thể đăng nhập bằng email/mật khẩu đã cung cấp.',
                        style: TextStyle(fontSize: 12, color: AppColors.info, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Shipper list từ Firestore ─────────────────────────────────────────────

  Widget _buildShipperList() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state.shippersLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.adminColor));
        }

        if (state.shippers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delivery_dining_outlined, size: 52, color: AppColors.textHint),
                const SizedBox(height: 12),
                Text(
                  'Chưa có shipper nào',
                  style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.shippers.length,
          itemBuilder: (_, i) => _shipperCard(state.shippers[i]),
        );
      },
    );
  }

  Widget _shipperCard(Map<String, dynamic> s) {
    final isActive = s['isActive'] as bool? ?? false;
    final name = s['displayName'] as String? ?? '';
    final phone = s['phoneNumber'] as String? ?? '';
    final vehicle = s['vehicleType'] as String? ?? '';
    final license = s['licensePlate'] as String? ?? '';
    final trips = s['totalTrips'] as int? ?? 0;
    final rating = (s['rating'] as num?)?.toDouble() ?? 5.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.shipperColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.delivery_dining_rounded,
              size: 22,
              color: AppColors.shipperColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$phone · $vehicle · $license',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      '$trips chuyến',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.shipperColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '⭐ ${rating.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 12, color: AppColors.warning),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isActive ? AppColors.statusDone : AppColors.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              isActive ? 'Active' : 'Offline',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.statusDoneText : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _sectionLabel(String text) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      letterSpacing: 0.8,
    ),
  );

  Widget _vehicleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Loại xe',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 7),
        DropdownButtonFormField<String>(
          value: _vehicleCtrl.text.isEmpty ? null : _vehicleCtrl.text,
          decoration: InputDecoration(
            hintText: 'Chọn loại xe',
            prefixIcon: const Icon(
              Icons.two_wheeler_rounded,
              size: 18,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.adminColor, width: 1.5),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Xe máy', child: Text('Xe máy')),
            DropdownMenuItem(value: 'Xe đạp điện', child: Text('Xe đạp điện')),
            DropdownMenuItem(value: 'Xe tải nhỏ', child: Text('Xe tải nhỏ')),
          ],
          onChanged: (v) => _vehicleCtrl.text = v ?? '',
          validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng chọn loại xe' : null,
        ),
      ],
    );
  }

  Widget _field(
    String label,
    String hint,
    TextEditingController ctrl,
    IconData icon, {
    TextInputType type = TextInputType.text,
    bool obscure = false,
    bool readOnly = false,
    Widget? suffix,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: ctrl,
          keyboardType: type,
          obscureText: obscure,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppColors.textSecondary),
            suffixIcon: suffix,
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.adminColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDob() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1970),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      builder: (ctx, child) => Theme(
        data: Theme.of(
          ctx,
        ).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.adminColor)),
        child: child!,
      ),
    );
    if (d != null && mounted) {
      _dobCtrl.text =
          '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AdminBloc>().add(
      AdminCreateShipper(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        displayName: _nameCtrl.text.trim(),
        phoneNumber: _phoneCtrl.text.trim(),
        dateOfBirth: _dobCtrl.text,
        vehicleType: _vehicleCtrl.text,
        licensePlate: _licenseCtrl.text.trim(),
      ),
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    for (final c in [
      _nameCtrl,
      _phoneCtrl,
      _emailCtrl,
      _passCtrl,
      _dobCtrl,
      _vehicleCtrl,
      _licenseCtrl,
    ]) {
      c.clear();
    }
  }
}
