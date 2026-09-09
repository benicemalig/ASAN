import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class StandardIconButton extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final double size;

  const StandardIconButton({
    super.key,
    required this.icon,
    required this.activeIcon,
    this.isActive = false,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      isActive ? activeIcon : icon,
      size: size,
      color: isActive
          ? AsanColorScheme.primary
          : AsanColorScheme.inactive,
    );
  }
}