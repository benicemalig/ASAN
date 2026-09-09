import 'package:flutter/material.dart';

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
            color: Colors.black26,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavigationItem(
              label: 'Recipes',
              icon: Icons.import_contacts_outlined,
              activeIcon: Icons.import_contacts_rounded,
              isSelected: selectedIndex == 0,
              onPressed: () => onDestinationSelected(0),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              label: 'Meals',
              icon: Icons.calendar_today_outlined,
              activeIcon: Icons.calendar_today_rounded,
              isSelected: selectedIndex == 1,
              onPressed: () => onDestinationSelected(1),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              label: 'Pantry',
              icon: Icons.inventory_2_outlined,
              activeIcon: Icons.inventory_2_rounded,
              isSelected: selectedIndex == 2,
              onPressed: () => onDestinationSelected(2),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              label: 'Groceries',
              icon: Icons.shopping_cart_outlined,
              activeIcon: Icons.shopping_cart_rounded,
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
  final IconData activeIcon;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onPressed;

  const _NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.onPressed,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
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
                activeIcon: activeIcon,
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
              color: isSelected
                  ? AsanColorScheme.primary
                  : AsanColorScheme.inactive,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}