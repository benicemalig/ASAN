import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:asan/theme.dart';

class StandardIconButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final double size;

  const StandardIconButton({
    super.key,
    required this.icon,
    this.isActive = false,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      fill: isActive ? 1 : 0,
      color: isActive
        ? AsanColorScheme.primary
        : AsanColorScheme.inactive,
    );
  }
}