import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class FilledIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isActive;

  const FilledIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive
          ? AsanColorScheme.primary
          : AsanColorScheme.container,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Center(
            child: Icon(
              icon,
              size: 22,
              color: AsanColorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}