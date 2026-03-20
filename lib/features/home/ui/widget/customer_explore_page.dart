import 'package:booking_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// EXPLORE PAGE (Khám phá)
// ─────────────────────────────────────────────────────────────────────────────
class CustomerExplorePage extends StatefulWidget {
  const CustomerExplorePage({super.key});

  @override
  State<CustomerExplorePage> createState() => _CustomerExplorePageState();
}

class _CustomerExplorePageState extends State<CustomerExplorePage> {
  int _selectedCat = 0;

  final _categories = [
    ('🍜', 'Tất cả'),
    ('🍱', 'Cơm'),
    ('🍔', 'Burger'),
    ('🥤', 'Trà sữa'),
    ('🍕', 'Pizza'),
    ('🍣', 'Sushi'),
    ('🍖', 'Nướng'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryFilter(),
            Expanded(child: _buildRestaurantGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        'Khám phá',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 10),
            Text('Tìm kiếm nhà hàng...', style: TextStyle(fontSize: 14, color: AppColors.textHint)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (_, i) {
          final selected = _selectedCat == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedCat = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
              ),
              child: Row(
                children: [
                  Text(_categories[i].$1, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 5),
                  Text(
                    _categories[i].$2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRestaurantGrid() {
    final items = [
      ('🍜', 'Bún Bò Huế Bà Ba', '4.8', '25p', '-20%'),
      ('🍔', 'The Burger Lab', '4.6', '35p', null),
      ('🍱', 'Cơm Nhà Bà Tư', '4.9', '20p', null),
      ('🥤', 'Gong Cha', '4.7', '15p', '-10%'),
      ('🍕', 'Pizza 4P\'s', '4.8', '40p', null),
      ('🍣', 'Sushi Tei', '4.5', '30p', '-15%'),
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) =>
          _restaurantGridItem(items[i].$1, items[i].$2, items[i].$3, items[i].$4, items[i].$5),
    );
  }

  Widget _restaurantGridItem(String emoji, String name, String rating, String time, String? badge) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFFFFD166), Color(0xFFFF8C42)]),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 36))),
              ),
              if (badge != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 3),
                    Text(
                      rating,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: 8),
                    const Text('🕐', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 3),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ORDERS PAGE (Đơn hàng)
// ─────────────────────────────────────────────────────────────────────────────
class CustomerOrdersPage extends StatefulWidget {
  const CustomerOrdersPage({super.key});

  @override
  State<CustomerOrdersPage> createState() => _CustomerOrdersPageState();
}

class _CustomerOrdersPageState extends State<CustomerOrdersPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

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
                  _buildOrderList(_activeOrders),
                  _buildOrderList(_completedOrders),
                  _buildOrderList(_cancelledOrders),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Đơn hàng của tôi',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabCtrl,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 13),
      tabs: const [
        Tab(text: 'Đang xử lý'),
        Tab(text: 'Hoàn thành'),
        Tab(text: 'Đã huỷ'),
      ],
    );
  }

  Widget _buildOrderList(List<_OrderData> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📋', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              'Chưa có đơn hàng',
              style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (_, i) => _orderCard(orders[i]),
    );
  }

  Widget _orderCard(_OrderData o) {
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
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(o.emoji, style: const TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      o.shopName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      o.items,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    o.total,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  _statusChip(o.status),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(o.date, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              const Spacer(),
              if (o.status == 'done')
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(80, 30),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: const TextStyle(fontSize: 12),
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('Đặt lại'),
                ),
              if (o.status == 'active')
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 30),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text('Theo dõi'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final (label, bg, fg) = switch (status) {
      'active' => ('Đang giao', AppColors.statusNew, AppColors.statusNewText),
      'done' => ('Hoàn thành', AppColors.statusDone, AppColors.statusDoneText),
      _ => ('Đã huỷ', const Color(0xFFFDE8E8), AppColors.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }

  final _activeOrders = [
    _OrderData(
      '🍜',
      'Bún Bò Bà Ba',
      '2x Bún bò · 1x Chả giò',
      '85.000đ',
      'active',
      '20/03/2026 - 12:30',
    ),
  ];

  final _completedOrders = [
    _OrderData(
      '🍔',
      'The Burger Lab',
      '1x Burger Phô Mai',
      '65.000đ',
      'done',
      '19/03/2026 - 18:45',
    ),
    _OrderData(
      '🍱',
      'Cơm Nhà Bà Tư',
      '1x Cơm sườn · 1x Canh',
      '45.000đ',
      'done',
      '18/03/2026 - 12:00',
    ),
  ];

  final _cancelledOrders = <_OrderData>[];
}

class _OrderData {
  final String emoji, shopName, items, total, status, date;
  const _OrderData(this.emoji, this.shopName, this.items, this.total, this.status, this.date);
}

// ─────────────────────────────────────────────────────────────────────────────
// MESSAGES PAGE (Tin nhắn)
// ─────────────────────────────────────────────────────────────────────────────
class CustomerMessagesPage extends StatelessWidget {
  const CustomerMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      ('🍜', 'Bún Bò Bà Ba', 'Đơn hàng của bạn đang được chuẩn bị...', '12:30', true),
      ('🚴', 'Shipper Minh', 'Tôi đang trên đường đến...', '12:35', false),
      ('🍔', 'The Burger Lab', 'Cảm ơn bạn đã đặt hàng!', 'Hôm qua', false),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                'Tin nhắn',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: chats.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (_, i) =>
                    _chatTile(chats[i].$1, chats[i].$2, chats[i].$3, chats[i].$4, chats[i].$5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatTile(String emoji, String name, String lastMsg, String time, bool hasUnread) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
              ),
              if (hasUnread)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: hasUnread ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  lastMsg,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: hasUnread ? AppColors.textPrimary : AppColors.textSecondary,
                    fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
