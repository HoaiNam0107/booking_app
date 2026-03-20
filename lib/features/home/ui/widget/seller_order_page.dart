import 'package:booking_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SELLER ORDERS PAGE (Quản lý đơn hàng)
// ─────────────────────────────────────────────────────────────────────────────
class SellerOrdersPage extends StatefulWidget {
  const SellerOrdersPage({super.key});

  @override
  State<SellerOrdersPage> createState() => _SellerOrdersPageState();
}

class _SellerOrdersPageState extends State<SellerOrdersPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  final _orders = [
    _SellerOrder('🍜', '#DH001', 'Nguyễn Văn A', '2x Bún bò · 1x Chả giò', '85.000đ', 'new', '12:30'),
    _SellerOrder('🍱', '#DH002', 'Trần Thị B', '1x Cơm sườn · 1x Nước', '55.000đ', 'preparing', '12:25'),
    _SellerOrder('🍔', '#DH003', 'Lê Minh C', '3x Burger · 2x Khoai tây', '175.000đ', 'done', '12:10'),
    _SellerOrder('🥤', '#DH004', 'Phạm Thị D', '2x Trà sữa', '70.000đ', 'new', '12:05'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  _buildList(_orders.where((o) => o.status == 'new').toList()),
                  _buildList(_orders.where((o) => o.status == 'preparing').toList()),
                  _buildList(_orders.where((o) => o.status == 'done').toList()),
                  _buildList(_orders),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => const Padding(
    padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text('Quản lý đơn hàng',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
    ),
  );

  Widget _buildTabBar() => TabBar(
    controller: _tabCtrl,
    labelColor: AppColors.sellerColor,
    unselectedLabelColor: AppColors.textSecondary,
    indicatorColor: AppColors.sellerColor,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    unselectedLabelStyle: const TextStyle(fontSize: 12),
    tabs: const [
      Tab(text: 'Mới'),
      Tab(text: 'Đang làm'),
      Tab(text: 'Xong'),
      Tab(text: 'Tất cả'),
    ],
  );

  Widget _buildList(List<_SellerOrder> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('📋', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('Không có đơn hàng', style: TextStyle(fontSize: 15, color: AppColors.textSecondary)),
        ]),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (_, i) => _orderCard(orders[i]),
    );
  }

  Widget _orderCard(_SellerOrder o) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(o.emoji, style: const TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(o.orderId, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(width: 8),
                    Text(o.time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ]),
                  Text(o.customerName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(o.items, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(o.total, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                const SizedBox(height: 4),
                _statusChip(o.status),
              ]),
            ],
          ),
          if (o.status == 'new') ...[
            const SizedBox(height: 10),
            const Divider(height: 1, color: AppColors.divider),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: const Text('Từ chối', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    backgroundColor: AppColors.sellerColor,
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text('Xác nhận đơn'),
                ),
              ),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final (label, bg, fg) = switch (status) {
      'new' => ('Mới', AppColors.statusNew, AppColors.statusNewText),
      'preparing' => ('Đang làm', AppColors.statusPreparing, AppColors.statusPreparingText),
      _ => ('Xong', AppColors.statusDone, AppColors.statusDoneText),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg)),
    );
  }
}

class _SellerOrder {
  final String emoji, orderId, customerName, items, total, status, time;
  const _SellerOrder(this.emoji, this.orderId, this.customerName, this.items, this.total, this.status, this.time);
}

// ─────────────────────────────────────────────────────────────────────────────
// SELLER MENU PAGE (Thực đơn)
// ─────────────────────────────────────────────────────────────────────────────
class SellerMenuPage extends StatelessWidget {
  const SellerMenuPage({super.key});

  final _menuItems = const [
    ('🍜', 'Bún bò đặc biệt', '55.000đ', true),
    ('🍜', 'Bún bò thường', '45.000đ', true),
    ('🥟', 'Chả giò (4 cái)', '30.000đ', true),
    ('🥣', 'Bánh mì', '20.000đ', false),
    ('🥤', 'Nước chanh', '15.000đ', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Thực đơn',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text('Thêm món'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sellerColor,
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _menuItems.length,
                itemBuilder: (_, i) => _menuTile(_menuItems[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile((String, String, String, bool) item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(item.$1, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$2, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 3),
              Text(item.$3, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary)),
            ]),
          ),
          Switch(
            value: item.$4,
            onChanged: (_) {},
            activeColor: AppColors.sellerColor,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SELLER CHAT PAGE
// ─────────────────────────────────────────────────────────────────────────────
class SellerChatPage extends StatelessWidget {
  const SellerChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      ('👤', 'Nguyễn Văn A', 'Đơn của tôi khi nào xong ạ?', '12:31', true),
      ('🚴', 'Shipper Minh', 'Tôi đến lấy hàng sau 5p', '12:28', false),
      ('👤', 'Trần Thị B', 'Cảm ơn shop!', 'Hôm qua', false),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text('Tin nhắn',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: chats.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (_, i) => _chatTile(chats[i].$1, chats[i].$2, chats[i].$3, chats[i].$4, chats[i].$5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatTile(String emoji, String name, String msg, String time, bool unread) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(color: AppColors.sellerColor.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
              ),
              if (unread)
                Positioned(right: 0, top: 0,
                    child: Container(width: 12, height: 12,
                        decoration: const BoxDecoration(color: AppColors.sellerColor, shape: BoxShape.circle))),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(name, style: TextStyle(fontSize: 14, fontWeight: unread ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary)),
                Text(time, style: TextStyle(fontSize: 11, color: unread ? AppColors.sellerColor : AppColors.textSecondary)),
              ]),
              const SizedBox(height: 3),
              Text(msg, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: unread ? FontWeight.w500 : FontWeight.normal)),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SELLER SETTINGS PAGE
// ─────────────────────────────────────────────────────────────────────────────
class SellerSettingsPage extends StatelessWidget {
  const SellerSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Cài đặt cửa hàng',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 20),
            _section('Cửa hàng', [
              _settingTile(Icons.storefront_outlined, 'Thông tin cửa hàng', AppColors.sellerColor),
              _settingTile(Icons.access_time_rounded, 'Giờ hoạt động', AppColors.sellerColor),
              _settingTile(Icons.delivery_dining_rounded, 'Phí & khu vực giao hàng', AppColors.sellerColor),
            ]),
            const SizedBox(height: 16),
            _section('Thanh toán', [
              _settingTile(Icons.account_balance_outlined, 'Tài khoản ngân hàng', AppColors.info),
              _settingTile(Icons.receipt_outlined, 'Lịch sử thanh toán', AppColors.info),
            ]),
            const SizedBox(height: 16),
            _section('Thông báo', [
              _settingTile(Icons.notifications_outlined, 'Cài đặt thông báo', AppColors.warning),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.8)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
          child: Column(
            children: List.generate(items.length, (i) => Column(
              children: [
                items[i],
                if (i < items.length - 1) const Divider(height: 1, indent: 46, color: AppColors.divider),
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget _settingTile(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 15, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary))),
          const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}