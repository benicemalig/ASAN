import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class AsanListTile extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String unit;
  final String category;
  final String purchasedDate;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;

  const AsanListTile({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.purchasedDate,
    this.isChecked = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: isChecked,
              onChanged: onChanged,
              side: const BorderSide(
                color: AsanColorScheme.secondary,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: AsanSpacing.md),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        itemName,
                        style: AsanTextTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 22 / 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AsanSpacing.md),
                    Text(
                      '$quantity $unit',
                      style: AsanTextTheme.bodyMedium.copyWith(height: 22 / 16),
                    ),
                  ],
                ),
                const SizedBox(height: AsanSpacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        category,
                        style: AsanTextTheme.labelSmall.copyWith(
                          height: 16 / 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AsanSpacing.md),
                    Text(
                      purchasedDate,
                      style: AsanTextTheme.labelSmall.copyWith(height: 16 / 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
