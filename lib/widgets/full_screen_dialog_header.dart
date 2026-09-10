import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class FullScreenDialogHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final String screenTitle;
  final VoidCallback? onBackPressed;

  const FullScreenDialogHeader({
    super.key,
    required this.screenTitle,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AsanSpacing.md),
      child: SizedBox(
        width: double.infinity,
        height: 34,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: AsanSpacing.md,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 34,
                  height: 34,
                ),
                icon: const Icon(Icons.chevron_left_rounded, size: 34),
                onPressed:
                    onBackPressed ??
                    () {
                      Navigator.pop(context);
                    },
              ),
            ),
            Center(
              child: Text(
                screenTitle,
                style: AsanTextTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(34 + (AsanSpacing.md * 2));
}
