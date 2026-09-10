import 'package:flutter/material.dart';
import 'package:asan/theme.dart';
import 'package:asan/widgets/outlined_button.dart';
import 'package:asan/widgets/primary_button.dart';

double filterSheetInitialSize(BuildContext context) {
  const contentHeight = 700.0;
  final availableHeight = MediaQuery.sizeOf(context).height;
  final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
  return ((contentHeight + bottomInset) / availableHeight)
      .clamp(0.5, 0.9)
      .toDouble();
}

class AsanFilterSelection {
  final String sortBy;
  final bool sortAscending;
  final String purchaseStatus;
  final Set<String> foodGroups;

  const AsanFilterSelection({
    required this.sortBy,
    required this.sortAscending,
    required this.purchaseStatus,
    required this.foodGroups,
  });
}

class AsanFilterList extends StatefulWidget {
  final ScrollController? scrollController;

  const AsanFilterList({super.key, this.scrollController});

  @override
  State<AsanFilterList> createState() => _AsanFilterListState();
}

class _AsanFilterListState extends State<AsanFilterList> {
  String _sortBy = 'Food group';
  bool _sortAscending = true;
  String _purchaseStatus = 'Unpurchased';
  final Set<String> _foodGroups = {'Cans & Jars', 'Grains & Cereals', 'Meat'};

  static const _groups = [
    'Beverages',
    'Bread & Bakery',
    'Cans & Jars',
    'Condiments & Sauces',
    'Dairy',
    'Deli',
    'Fruit',
    'Grains & Cereals',
    'Herbs & Spices',
    'Meat',
  ];

  void _reset() {
    setState(() {
      _sortBy = 'Food group';
      _sortAscending = true;
      _purchaseStatus = 'Unpurchased';
      _foodGroups.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AsanColorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: AsanColorScheme.inactive,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: widget.scrollController,
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Column(
                  children: [
                    _SheetHeader(
                      title: 'Select Filters',
                      onClose: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: AsanSpacing.md),
                    _FilterSection(
                      title: 'Sort By',
                      options: const ['Food group', 'Item name', 'Date added'],
                      selected: _sortBy,
                      ascending: _sortAscending,
                      onDirectionChanged: () =>
                          setState(() => _sortAscending = !_sortAscending),
                      onSelected: (value) => setState(() => _sortBy = value),
                    ),
                    const Divider(height: 17, color: AsanColorScheme.inactive),
                    _FilterSection(
                      title: 'Purchase Status',
                      options: const ['Unpurchased', 'Purchased'],
                      selected: _purchaseStatus,
                      isCheckbox: true,
                      onSelected: (value) =>
                          setState(() => _purchaseStatus = value),
                    ),
                    const Divider(height: 17, color: AsanColorScheme.inactive),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Food Group',
                        style: AsanTextTheme.labelSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 16 / 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: AsanSpacing.sm),
                    Wrap(
                      spacing: AsanSpacing.sm,
                      runSpacing: AsanSpacing.sm,
                      children: _groups.map((group) {
                        final selected = _foodGroups.contains(group);
                        return InkWell(
                          onTap: () => setState(() {
                            selected
                                ? _foodGroups.remove(group)
                                : _foodGroups.add(group);
                          }),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AsanColorScheme.secondary
                                  : AsanColorScheme.container,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  group,
                                  style: AsanTextTheme.bodyMedium.copyWith(
                                    color: selected
                                        ? AsanColorScheme.surface
                                        : AsanColorScheme.inactive,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (selected) ...[
                                  const SizedBox(width: AsanSpacing.xs),
                                  const Icon(
                                    Icons.close_rounded,
                                    size: 22,
                                    color: AsanColorScheme.surface,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      height: 38,
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: AsanSpacing.sm),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Apply',
                      height: 38,
                      onPressed: () => Navigator.pop(
                        context,
                        AsanFilterSelection(
                          sortBy: _sortBy,
                          sortAscending: _sortAscending,
                          purchaseStatus: _purchaseStatus,
                          foodGroups: Set.unmodifiable(_foodGroups),
                        ),
                      ),
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const _SheetHeader({required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 22),
          Text(
            title,
            style: AsanTextTheme.bodyMedium.copyWith(
              height: 22 / 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 22, height: 22),
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded, size: 22),
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  final bool ascending;
  final VoidCallback? onDirectionChanged;
  final bool isCheckbox;

  const _FilterSection({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.ascending = true,
    this.onDirectionChanged,
    this.isCheckbox = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AsanTextTheme.labelSmall.copyWith(
            height: 16 / 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AsanSpacing.sm),
        ...options.map(
          (option) => InkWell(
            onTap: () => onSelected(option),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: option == selected
                          ? AsanColorScheme.secondary
                          : Colors.transparent,
                      shape: isCheckbox ? BoxShape.rectangle : BoxShape.circle,
                      borderRadius: isCheckbox
                          ? BorderRadius.circular(4)
                          : null,
                      border: option == selected
                          ? null
                          : Border.all(color: AsanColorScheme.inactive),
                    ),
                    child: option == selected
                        ? const Icon(
                            Icons.check_rounded,
                            size: 15,
                            color: AsanColorScheme.surface,
                          )
                        : null,
                  ),
                  const SizedBox(width: AsanSpacing.md),
                  Expanded(
                    child: Text(
                      option,
                      style: AsanTextTheme.bodyMedium.copyWith(
                        height: 22 / 16,
                        color: option == selected
                            ? AsanColorScheme.secondary
                            : AsanColorScheme.inactive,
                        fontWeight: option == selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (option == selected && onDirectionChanged != null)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 22,
                        height: 22,
                      ),
                      onPressed: onDirectionChanged,
                      icon: Icon(
                        ascending
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 22,
                        color: AsanColorScheme.secondary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
