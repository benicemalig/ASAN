import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class AsanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final double actionRightPadding;
  final PreferredSizeWidget? bottom;

  const AsanAppBar(
    {
      super.key,
      required this.screenTitle,
        this.icon,
      this.onIconPressed,
      this.actionRightPadding = AsanSpacing.lg,
      this.bottom,
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
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AsanColorScheme.shadow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        title: Text(
          screenTitle,
          style: AsanTextTheme.headlineSmall,
        ),
        bottom: bottom,
          actions: icon == null
              ? null
              : [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 34,
                      height: 34,
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
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight +
        (AsanSpacing.md * 2) +
        (bottom?.preferredSize.height ?? 0),
  );
}