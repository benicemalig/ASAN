import 'package:flutter/material.dart';
import 'package:asan/theme.dart';
import 'package:asan/widgets/date_picker.dart';

class AsanDateField extends StatefulWidget {
  final String label;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onChanged;
  final bool hasError;

  const AsanDateField({
    super.key,
    required this.label,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.hasError = false,
  });

  @override
  State<AsanDateField> createState() => _AsanDateFieldState();
}

class _AsanDateFieldState extends State<AsanDateField> {
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  DateTime? _selectedDate;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _openPicker() async {
    setState(() => _isActive = true);

    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: AsanDatePicker(
          initialDate: _selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          onDateSelected: (date) => Navigator.of(dialogContext).pop(date),
          onCancel: () => Navigator.of(dialogContext).pop(),
        ),
      ),
    );

    if (!mounted) return;
    setState(() {
      _isActive = false;
      if (selectedDate != null) {
        _selectedDate = selectedDate;
      }
    });
    if (selectedDate != null) {
      widget.onChanged?.call(selectedDate);
    }
  }

  String _formatDate(DateTime date) {
    return '${_months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final hasBorder = _isActive || widget.hasError;
    final hasValue = _selectedDate != null;
    final iconColor = widget.hasError
        ? AsanColorScheme.inactive
        : (_isActive ? AsanColorScheme.primary : AsanColorScheme.inactive);

    return SizedBox(
      width: double.infinity,
      height: 62,
      child: Column(
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
          Material(
            color: hasBorder
                ? AsanColorScheme.surface
                : AsanColorScheme.container,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: _openPicker,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 38,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: hasBorder
                      ? Border.all(
                          color: widget.hasError
                              ? AsanColorScheme.error
                              : AsanColorScheme.primary,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? widget.hintText ?? ''
                            : _formatDate(_selectedDate!),
                        style: AsanTextTheme.bodyMedium.copyWith(
                          height: 22 / 16,
                          color: hasValue
                              ? AsanColorScheme.onSurface
                              : AsanColorScheme.inactive,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Center(
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
