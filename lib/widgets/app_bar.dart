import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class AsanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final double actionRightPadding;

  const AsanAppBar(
    {
      super.key,
      required this.screenTitle,
        this.icon,
      this.onIconPressed,
      this.actionRightPadding = AsanSpacing.md,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AsanSpacing.md,
      ).copyWith(
        left: AsanSpacing.lg,
        right: actionRightPadding,
      ),
      child: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          screenTitle,
          style: AsanTextTheme.headlineSmall,
        ),
          actions: icon == null
              ? null
              : [
                  IconButton(
                    constraints: const BoxConstraints(
                      minWidth: kMinInteractiveDimension,
                      minHeight: kMinInteractiveDimension,
                    ),
                    icon: Icon(
                      icon,
                      size: 32,
                      color: AsanColorScheme.secondary,
                    ),
                    onPressed: onIconPressed,
                  ),
                ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
    kToolbarHeight + (AsanSpacing.md * 2),
  );
}