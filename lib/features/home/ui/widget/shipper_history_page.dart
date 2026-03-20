import 'package:booking_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SHIPPER HISTORY PAGE (Lịch sử chuyến)
// ─────────────────────────────────────────────────────────────────────────────
class ShipperHistoryPage extends StatelessWidget {
  const ShipperHistoryPage({super.key});

  final _trips = const [
    _TripData('Bún Bò Bà Ba', '45 Lê Lợi, Q1', '35.000đ', '12:30', '3.2km', '18 phút', true),
    _TripData('The Burger Lab', '12 Nguyễn Trãi, Q5', '28.000đ', '11:00', '2.1km', '12 phút', true),
    _TripData('Pizza 4P\'s', '8 Thái Văn Lung, Q1', '42.000đ', '10:10', '4.5km', '25 phút', true),
    _TripData('Gong Cha', '3 Đinh Tiên Hoàng, Q1', '20.000đ', '09:30', '1.8km', '10 phút', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text('Lịch sử chuyến',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ),
            // Summary bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  _summaryChip('📦', '4 chuyến', AppColors.shipperColor),
                  const SizedBox(width: 10),
                  _summaryChip('💰', '125.000đ', AppColors.success),
                  const SizedBox(width: 10),
                  _summaryChip('📍', '11.6km', AppColors.info),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _trips.length,
                itemBuilder: (_, i) => _tripCard(_trips[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryChip(String emoji, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
        ],
      ),
    );
  }

  Widget _tripCard(_TripData t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: AppColors.shipperColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.delivery_dining_rounded, size: 20, color: AppColors.shipperColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.shopName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(t.address, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(t.earning, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.shipperColor)),
                Text(t.time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ]),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 10),
          Row(
            children: [
              _tripStat(Icons.straighten_rounded, t.distance),
              const SizedBox(width: 16),
              _tripStat(Icons.timer_outlined, t.duration),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: t.rated ? AppColors.statusDone : AppColors.surface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  t.rated ? '⭐ Đã đánh giá' : 'Chưa đánh giá',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: t.rated ? AppColors.statusDoneText : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tripStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _TripData {
  final String shopName, address, earning, time, distance, duration;
  final bool rated;
  const _TripData(this.shopName, this.address, this.earning, this.time, this.distance, this.duration, this.rated);
}

// ─────────────────────────────────────────────────────────────────────────────
// SHIPPER EARNINGS PAGE (Thu nhập)
// ─────────────────────────────────────────────────────────────────────────────
class ShipperEarningsPage extends StatefulWidget {
  const ShipperEarningsPage({super.key});

  @override
  State<ShipperEarningsPage> createState() => _ShipperEarningsPageState();
}

class _ShipperEarningsPageState extends State<ShipperEarningsPage> {
  int _selectedPeriod = 0; // 0 = Tuần, 1 = Tháng

  final _weekData = [40.0, 65.0, 45.0, 80.0, 55.0, 90.0, 70.0];
  final _monthData = [55.0, 70.0, 45.0, 80.0, 60.0, 75.0, 50.0, 85.0, 65.0, 70.0, 80.0, 45.0];
  final _days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  final _monthDays = ['1', '3', '5', '7', '9', '11', '13', '15', '17', '19', '21', '23'];

  @override
  Widget build(BuildContext context) {
    final isWeek = _selectedPeriod == 0;
    final data = isWeek ? _weekData : _monthData;
    final labels = isWeek ? _days : _monthDays;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Thu nhập',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 16),

            // Period selector
            Row(
              children: ['Tuần này', 'Tháng này'].asMap().entries.map((e) {
                final selected = _selectedPeriod == e.key;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPeriod = e.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.shipperColor : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: selected ? AppColors.shipperColor : AppColors.divider),
                    ),
                    child: Text(e.value,
                        style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        )),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Summary cards
            Row(
              children: [
                Expanded(child: _summaryCard('Tổng thu nhập', isWeek ? '3.200.000đ' : '12.800.000đ', AppColors.shipperColor)),
                const SizedBox(width: 10),
                Expanded(child: _summaryCard('Số chuyến', isWeek ? '12' : '48', AppColors.info)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _summaryCard('TB/chuyến', '26.700đ', AppColors.success)),
                const SizedBox(width: 10),
                Expanded(child: _summaryCard('Đánh giá', '4.9 ⭐', AppColors.warning)),
              ],
            ),
            const SizedBox(height: 20),

            // Chart
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isWeek ? 'Thu nhập 7 ngày' : 'Thu nhập 23 ngày',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(data.length, (i) {
                      final maxH = data.reduce((a, b) => a > b ? a : b);
                      final h = (data[i] / maxH) * 100;
                      final isMax = data[i] == maxH;
                      return Expanded(
                        child: Column(children: [
                          Container(
                            height: h,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: isMax ? AppColors.shipperColor : AppColors.shipperColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(labels[i], style: const TextStyle(fontSize: 9, color: AppColors.textSecondary)),
                        ]),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Breakdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Chi tiết', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  _earningRow('💰 Phí giao hàng', isWeek ? '2.800.000đ' : '11.200.000đ'),
                  const Divider(height: 20, color: AppColors.divider),
                  _earningRow('🎁 Thưởng hoàn thành', isWeek ? '300.000đ' : '1.200.000đ'),
                  const Divider(height: 20, color: AppColors.divider),
                  _earningRow('⭐ Thưởng đánh giá cao', isWeek ? '100.000đ' : '400.000đ'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
      ]),
    );
  }

  Widget _earningRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ],
    );
  }
}