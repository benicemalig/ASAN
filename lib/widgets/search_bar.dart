import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:asan/theme.dart';

class AsanSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final String initialQuery;

  const AsanSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.initialQuery = '',
  });

  @override
  State<AsanSearchBar> createState() => _AsanSearchBarState();
}

class _AsanSearchBarState extends State<AsanSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get _isActive => _focusNode.hasFocus || _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _controller.text = widget.initialQuery;

    _focusNode.addListener(_updateState);
    _controller.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isActive;

    return Container(
      height: 38,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? AsanColorScheme.surface : AsanColorScheme.container,
        borderRadius: BorderRadius.circular(8),
        border: isActive ? Border.all(color: AsanColorScheme.primary) : null,
      ),
      child: Row(
        children: [
          Icon(
            Symbols.search_rounded,
            size: 22,
            fill: 0,
            color: isActive
                ? AsanColorScheme.primary
                : AsanColorScheme.inactive,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              style: AsanTextTheme.bodyMedium.copyWith(
                color: AsanColorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AsanTextTheme.bodyMedium.copyWith(
                  color: AsanColorScheme.inactive,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),

          if (_controller.text.isNotEmpty) ...[
            const SizedBox(width: 8),

            SizedBox(
              width: 22,
              height: 22,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Symbols.close_rounded,
                  size: 22,
                  color: AsanColorScheme.primary,
                ),
                onPressed: _clearSearch,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
