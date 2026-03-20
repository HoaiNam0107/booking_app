import 'package:flutter/material.dart';
import 'package:booking_app/core/theme/app_theme.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SocialButton(label: 'Google', emoji: '🔵', onTap: () {}),
        const SizedBox(width: 10),
        _SocialButton(label: 'Facebook', emoji: '📘', onTap: () {}),
        const SizedBox(width: 10),
        _SocialButton(label: 'Apple', emoji: '🍎', onTap: () {}),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final String emoji;
  final VoidCallback onTap;

  const _SocialButton({required this.label, required this.emoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 3),
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
