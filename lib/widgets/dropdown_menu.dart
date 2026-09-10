import 'package:flutter/material.dart';
import 'package:asan/theme.dart';
import 'package:asan/widgets/search_bar.dart';

double dropdownSheetInitialSize(
  BuildContext context, {
  required int itemCount,
  required bool showSearch,
}) {
  const minimumSize = 0.5;
  const maximumSize = 0.9;
  const itemHeight = 38.0;
  const itemGap = 8.0;
  const fixedHeight = 106.0;
  final contentHeight =
      fixedHeight +
      (showSearch ? 70 : 0) +
      itemCount * itemHeight +
      (itemCount > 0 ? (itemCount - 1) * itemGap : 0);
  final availableHeight = MediaQuery.sizeOf(context).height;
  final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

  return ((contentHeight + bottomInset) / availableHeight)
      .clamp(minimumSize, maximumSize)
      .toDouble();
}

class AsanDropdownMenu extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? value;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final bool hasError;

  const AsanDropdownMenu({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.hintText,
    this.onChanged,
    this.hasError = false,
  });

  @override
  State<AsanDropdownMenu> createState() => _AsanDropdownMenuState();
}

class _AsanDropdownMenuState extends State<AsanDropdownMenu> {
  bool _isOpen = false;

  Future<void> _openList() async {
    setState(() => _isOpen = true);
    final selectedValue = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AsanColorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: dropdownSheetInitialSize(
          context,
          itemCount: widget.items.length,
          showSearch: true,
        ),
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => AsanDropdownList(
          title: widget.label == 'Food Group'
              ? 'Select Food Group'
              : widget.label,
          items: widget.items,
          selectedValue: widget.value,
          scrollController: scrollController,
        ),
      ),
    );
    if (!mounted) return;
    setState(() => _isOpen = false);
    if (selectedValue != null) widget.onChanged?.call(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    final hasBorder = _isOpen || widget.hasError;
    final textColor = widget.value == null
        ? AsanColorScheme.inactive
        : AsanColorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: AsanTextTheme.labelSmall.copyWith(
            height: 16 / 12,
            color: AsanColorScheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: hasBorder
                ? AsanColorScheme.surface
                : AsanColorScheme.container,
            borderRadius: BorderRadius.circular(8),
            border: hasBorder
                ? Border.all(
                    color: widget.hasError
                        ? AsanColorScheme.error
                        : AsanColorScheme.primary,
                  )
                : null,
          ),
          child: InkWell(
            onTap: _openList,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.value ?? widget.hintText ?? '',
                      style: AsanTextTheme.bodyMedium.copyWith(
                        height: 22 / 16,
                        color: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 28,
                    color: AsanColorScheme.inactive,
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

class AsanDropdownList extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final String searchHint;
  final bool showSearch;
  final ScrollController? scrollController;

  const AsanDropdownList({
    super.key,
    required this.title,
    required this.items,
    this.selectedValue,
    this.searchHint = 'search food group...',
    this.showSearch = true,
    this.scrollController,
  });

  @override
  State<AsanDropdownList> createState() => _AsanDropdownListState();
}

class _AsanDropdownListState extends State<AsanDropdownList> {
  String _searchQuery = '';
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final selectedIndex = widget.items.indexOf(widget.selectedValue ?? '');
    _scrollController = ScrollController(
      initialScrollOffset: selectedIndex < 0
          ? 0
          : selectedIndex * (38 + AsanSpacing.sm),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.toLowerCase();
    final filteredItems = widget.items
        .where((item) => item.toLowerCase().contains(query))
        .toList();

    return SafeArea(
      top: false,
      child: SizedBox(
        height: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 22, height: 22),
                          Text(
                            widget.title,
                            style: AsanTextTheme.bodyMedium.copyWith(
                              height: 22 / 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close_rounded, size: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AsanSpacing.md),
                    if (widget.showSearch) ...[
                      AsanSearchBar(
                        hintText: widget.searchHint,
                        onChanged: (value) =>
                            setState(() => _searchQuery = value),
                      ),
                      const SizedBox(height: AsanSpacing.md),
                    ],
                    Expanded(
                      child: ListView.separated(
                        controller:
                            widget.scrollController ?? _scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: filteredItems.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AsanSpacing.sm),
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          final isSelected = item == widget.selectedValue;
                          return _DropdownListItem(
                            label: item,
                            isSelected: isSelected,
                            onPressed: () => Navigator.pop(context, item),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownListItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _DropdownListItem({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AsanColorScheme.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 38,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Icon(
                    isSelected ? Icons.check_rounded : null,
                    size: 18,
                    color: AsanColorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AsanTextTheme.bodyMedium.copyWith(
                    height: 22 / 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
