import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:asan/theme.dart';
import 'package:asan/widgets/notification_badge.dart';
import 'package:asan/widgets/standard_icon_button.dart';

class AsanNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final int groceriesBadgeCount;

  const AsanNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.groceriesBadgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: AsanColorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AsanColorScheme.shadow,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavigationItem(
              label: 'Recipes',
              icon: Symbols.menu_book_rounded,
              isSelected: selectedIndex == 0,
              onPressed: () => onDestinationSelected(0),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              label: 'Meals',
              icon: Symbols.calendar_today_rounded,
              isSelected: selectedIndex == 1,
              onPressed: () => onDestinationSelected(1),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              label: 'Pantry',
              icon: Symbols.inventory_2_rounded,
              isSelected: selectedIndex == 2,
              onPressed: () => onDestinationSelected(2),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              label: 'Groceries',
              icon: Symbols.shopping_cart_rounded,
              isSelected: selectedIndex == 3,
              badgeCount: groceriesBadgeCount,
              onPressed: () => onDestinationSelected(3),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onPressed;

  const _NavigationItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AsanColorScheme.primary
        : AsanColorScheme.inactive;

    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              StandardIconButton(
                icon: icon,
                isActive: isSelected,
              ),
              if (badgeCount > 0)
                Positioned(
                  right: -7,
                  top: -4,
                  child: NotificationBadge(
                    count: badgeCount,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AsanTextTheme.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}