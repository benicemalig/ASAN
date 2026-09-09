import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class NotificationBadge extends StatelessWidget {
  final int count;

  const NotificationBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    return Container(
      width: 13,
      height: 13,
      decoration: const BoxDecoration(
        color: AsanColorScheme.error,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: AsanTextTheme.labelSmall.copyWith(
          color: AsanColorScheme.onError,
          fontWeight: FontWeight.bold,
          fontSize: 9,
          height: 1,
        ),
      ),
    );
  }
}