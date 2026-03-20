import 'package:auto_route/auto_route.dart';
import 'package:booking_app/core/di/injection.dart';
import 'package:booking_app/core/router/app_router.dart';
import 'package:booking_app/core/theme/app_theme.dart';
import 'package:booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:booking_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:booking_app/features/auth/ui/widgets/auth_text_field.dart';
import 'package:booking_app/features/auth/ui/widgets/role_selector_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Personal
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  // Seller
  final _shopNameCtrl = TextEditingController();
  final _shopAddressCtrl = TextEditingController();
  String? _shopCategory;

  UserRole _role = UserRole.customer;
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  static const _categories = [
    ('vietnamese', 'Ẩm thực Việt'),
    ('fastfood', 'Đồ ăn nhanh'),
    ('cafe', 'Cà phê & Trà sữa'),
    ('bbq', 'Nướng & BBQ'),
    ('seafood', 'Hải sản'),
    ('pizza', 'Pizza & Pasta'),
    ('other', 'Khác'),
  ];

  @override
  void dispose() {
    for (final c in [
      _nameCtrl,
      _phoneCtrl,
      _emailCtrl,
      _passCtrl,
      _confirmCtrl,
      _dobCtrl,
      _addressCtrl,
      _shopNameCtrl,
      _shopAddressCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _onStateChanged,
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Tạo tài khoản'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildStepBar(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Chọn vai trò của bạn'),
                  const SizedBox(height: 10),
                  _buildRoleSelector(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Thông tin cá nhân'),
                  const SizedBox(height: 10),
                  _buildPersonalFields(),
                  if (_role == UserRole.seller) ...[
                    const SizedBox(height: 24),
                    _buildSectionLabel('Thông tin cửa hàng'),
                    const SizedBox(height: 10),
                    _buildSellerFields(),
                  ],
                  const SizedBox(height: 20),
                  _buildTerms(),
                  const SizedBox(height: 20),
                  _buildSubmitBtn(context, state),
                  const SizedBox(height: 16),
                  _buildLoginLink(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Role selector ────────────────────────────────────────────────────────

  Widget _buildRoleSelector() {
    return Row(
      children: [
        Expanded(
          child: RoleSelectorCard(
            icon: '🛒',
            title: 'Khách hàng',
            description: 'Đặt món & theo dõi đơn hàng',
            isSelected: _role == UserRole.customer,
            color: AppColors.userColor,
            onTap: () => setState(() => _role = UserRole.customer),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RoleSelectorCard(
            icon: '🏪',
            title: 'Người bán',
            description: 'Mở cửa hàng & quản lý đơn',
            isSelected: _role == UserRole.seller,
            color: AppColors.sellerColor,
            onTap: () => setState(() => _role = UserRole.seller),
          ),
        ),
      ],
    );
  }

  // ── Personal fields ──────────────────────────────────────────────────────

  Widget _buildPersonalFields() {
    return Column(
      children: [
        AuthTextField(
          label: 'Họ và tên',
          hint: 'Nguyễn Văn A',
          controller: _nameCtrl,
          prefixIcon: Icons.person_outline_rounded,
          validator: (v) => (v == null || v.trim().length < 2) ? 'Tên tối thiểu 2 ký tự' : null,
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Số điện thoại',
          hint: '0901 234 567',
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.phone_outlined,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Vui lòng nhập số điện thoại';
            if (!RegExp(r'^0[0-9]{9}$').hasMatch(v.replaceAll(' ', ''))) {
              return 'Số điện thoại không hợp lệ';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Email',
          hint: 'example@email.com',
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.alternate_email_rounded,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Vui lòng nhập email';
            if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(v)) {
              return 'Email không hợp lệ';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Mật khẩu',
          hint: 'Tối thiểu 8 ký tự',
          controller: _passCtrl,
          obscureText: _obscurePass,
          prefixIcon: Icons.lock_outline_rounded,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onPressed: () => setState(() => _obscurePass = !_obscurePass),
          ),
          validator: (v) => (v == null || v.length < 8) ? 'Mật khẩu tối thiểu 8 ký tự' : null,
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Xác nhận mật khẩu',
          hint: 'Nhập lại mật khẩu',
          controller: _confirmCtrl,
          obscureText: _obscureConfirm,
          prefixIcon: Icons.lock_outline_rounded,
          textInputAction: TextInputAction.done,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
          validator: (v) => v != _passCtrl.text ? 'Mật khẩu không khớp' : null,
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Ngày sinh',
          hint: 'DD/MM/YYYY',
          controller: _dobCtrl,
          prefixIcon: Icons.calendar_today_outlined,
          readOnly: true,
          onTap: _pickDate,
          validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng chọn ngày sinh' : null,
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Địa chỉ giao hàng mặc định',
          hint: '123 Nguyễn Huệ, Q1, TP.HCM',
          controller: _addressCtrl,
          prefixIcon: Icons.location_on_outlined,
          maxLines: 2,
          validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập địa chỉ' : null,
        ),
      ],
    );
  }

  // ── Seller fields ────────────────────────────────────────────────────────

  Widget _buildSellerFields() {
    return Column(
      children: [
        AuthTextField(
          label: 'Tên cửa hàng',
          hint: 'Bún Bò Bà Ba',
          controller: _shopNameCtrl,
          prefixIcon: Icons.storefront_outlined,
          validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập tên cửa hàng' : null,
        ),
        const SizedBox(height: 14),
        AuthTextField(
          label: 'Địa chỉ cửa hàng',
          hint: '45 Lê Lợi, Q1, TP.HCM',
          controller: _shopAddressCtrl,
          prefixIcon: Icons.pin_drop_outlined,
          validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập địa chỉ cửa hàng' : null,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          value: _shopCategory,
          decoration: InputDecoration(
            labelText: 'Loại nhà hàng',
            prefixIcon: const Icon(
              Icons.restaurant_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
          items: _categories.map((e) => DropdownMenuItem(value: e.$1, child: Text(e.$2))).toList(),
          onChanged: (v) => setState(() => _shopCategory = v),
          validator: (v) => v == null ? 'Vui lòng chọn loại nhà hàng' : null,
        ),
        const SizedBox(height: 12),
        _buildSellerNote(),
      ],
    );
  }

  Widget _buildSellerNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 16, color: Color(0xFFF57F17)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Đơn đăng ký người bán sẽ được xét duyệt trong 1–3 ngày làm việc.',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFFF57F17).withOpacity(0.9),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Terms & submit ───────────────────────────────────────────────────────

  Widget _buildTerms() {
    return GestureDetector(
      onTap: () => setState(() => _agreeTerms = !_agreeTerms),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: _agreeTerms,
              onChanged: (v) => setState(() => _agreeTerms = v ?? false),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                children: [
                  TextSpan(text: 'Tôi đồng ý với '),
                  TextSpan(
                    text: 'Điều khoản dịch vụ',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: ' và '),
                  TextSpan(
                    text: 'Chính sách bảo mật',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: ' của QuickBite'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitBtn(BuildContext context, AuthState state) {
    return ElevatedButton(
      onPressed: (state is AuthLoading || !_agreeTerms) ? null : () => _submit(context),
      child: state is AuthLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Text('Tạo tài khoản'),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Đã có tài khoản? ', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          GestureDetector(
            onTap: () => context.router.push(const LoginRoute()),
            child: const Text(
              'Đăng nhập',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  Widget _buildStepBar() {
    return Row(
      children: List.generate(
        3,
        (i) => Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
            decoration: BoxDecoration(
              color: i < 2 ? AppColors.primary : AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.8,
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
      helpText: 'Chọn ngày sinh',
      builder: (ctx, child) => Theme(
        data: Theme.of(
          ctx,
        ).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.primary)),
        child: child!,
      ),
    );
    if (date != null) {
      _dobCtrl.text =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (_role == UserRole.customer) {
      context.read<AuthBloc>().add(
        AuthRegisterCustomerRequested(
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text,
          displayName: _nameCtrl.text.trim(),
          phoneNumber: _phoneCtrl.text.trim(),
          dateOfBirth: _dobCtrl.text,
          address: _addressCtrl.text.trim(),
        ),
      );
    } else {
      context.read<AuthBloc>().add(
        AuthRegisterSellerRequested(
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text,
          displayName: _nameCtrl.text.trim(),
          phoneNumber: _phoneCtrl.text.trim(),
          dateOfBirth: _dobCtrl.text,
          address: _addressCtrl.text.trim(),
          shopName: _shopNameCtrl.text.trim(),
          shopAddress: _shopAddressCtrl.text.trim(),
          shopCategory: _shopCategory ?? 'other',
        ),
      );
    }
  }

  void _onStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }

    // Customer đăng ký thành công → vào home
    if (state is AuthAuthenticated) {
      context.router.replaceAll([const HomeCustomerRoute()]);
    }

    // Seller đăng ký thành công → hiện dialog chờ duyệt → về login
    if (state is AuthSellerPendingApproval) {
      _showSellerPendingDialog(context);
    }
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
            const Text('🎉', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            const Text(
              'Đăng ký thành công!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Hồ sơ cửa hàng của bạn đang được xét duyệt.\nThời gian xử lý: 1–3 ngày làm việc.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.router.replaceAll([const LoginRoute()]);
              },
              child: const Text('Về trang đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
