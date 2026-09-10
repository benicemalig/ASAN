import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class OutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;

  const OutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.height = 42,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AsanColorScheme.secondary),
      ),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                label,
                style: AsanTextTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 22 / 16,
                  color: AsanColorScheme.secondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
