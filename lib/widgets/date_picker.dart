import 'package:flutter/material.dart';
import 'package:asan/theme.dart';
import 'package:asan/widgets/dropdown_menu.dart';

class AsanDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final VoidCallback? onCancel;

  const AsanDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.onCancel,
  });

  @override
  State<AsanDatePicker> createState() => _AsanDatePickerState();
}

class _AsanDatePickerState extends State<AsanDatePicker> {
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  late DateTime _selectedDate;
  late DateTime _visibleMonth;

  DateTime get _firstDate =>
      DateUtils.dateOnly(widget.firstDate ?? DateTime(1900));

  DateTime get _lastDate =>
      DateUtils.dateOnly(widget.lastDate ?? DateTime(2100, 12, 31));

  @override
  void initState() {
    super.initState();
    final initialDate = DateUtils.dateOnly(
      widget.initialDate ?? DateTime.now(),
    );
    _selectedDate = _clampDate(initialDate);
    _visibleMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(_firstDate)) return _firstDate;
    if (date.isAfter(_lastDate)) return _lastDate;
    return date;
  }

  void _changeMonth(int offset) {
    final nextMonth = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + offset,
    );
    final firstMonth = DateTime(_firstDate.year, _firstDate.month);
    final lastMonth = DateTime(_lastDate.year, _lastDate.month);

    if (nextMonth.isBefore(firstMonth) || nextMonth.isAfter(lastMonth)) return;
    setState(() => _visibleMonth = nextMonth);
  }

  void _selectDate(DateTime date) {
    if (date.isBefore(_firstDate) || date.isAfter(_lastDate)) return;
    setState(() => _selectedDate = date);
  }

  Future<void> _selectMonth() async {
    final monthName = await showModalBottomSheet<String>(
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
          itemCount: _months.length,
          showSearch: false,
        ),
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, _) => AsanDropdownList(
          title: 'Select Month',
          items: _months,
          selectedValue: _months[_visibleMonth.month - 1],
          showSearch: false,
        ),
      ),
    );

    if (monthName == null || !mounted) return;
    final month = _months.indexOf(monthName) + 1;
    setState(() => _visibleMonth = DateTime(_visibleMonth.year, month));
  }

  Future<void> _selectYear() async {
    final years = [
      for (var year = _firstDate.year; year <= _lastDate.year; year++) '$year',
    ];
    final yearValue = await showModalBottomSheet<String>(
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
          itemCount: years.length,
          showSearch: false,
        ),
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, _) => AsanDropdownList(
          title: 'Select Year',
          items: years,
          selectedValue: '${_visibleMonth.year}',
          showSearch: false,
        ),
      ),
    );

    if (yearValue == null || !mounted) return;
    setState(() {
      _visibleMonth = DateTime(int.parse(yearValue), _visibleMonth.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      height: 419,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AsanColorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 38,
            child: Row(
              children: [
                _NavigationButton(
                  icon: Icons.chevron_left_rounded,
                  onPressed: () => _changeMonth(-1),
                ),
                const Spacer(),
                _MonthSelector(
                  label: _months[_visibleMonth.month - 1].substring(0, 3),
                  onPressed: _selectMonth,
                ),
                const SizedBox(width: 8),
                _MonthSelector(
                  label: '${_visibleMonth.year}',
                  onPressed: _selectYear,
                ),
                const Spacer(),
                _NavigationButton(
                  icon: Icons.chevron_right,
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _CalendarGrid(
            month: _visibleMonth,
            selectedDate: _selectedDate,
            firstDate: _firstDate,
            lastDate: _lastDate,
            onDateSelected: _selectDate,
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionButton(label: 'Cancel', onPressed: widget.onCancel),
              const SizedBox(width: 16),
              _ActionButton(
                label: 'Select',
                color: AsanColorScheme.primary,
                onPressed: () => widget.onDateSelected?.call(_selectedDate),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NavigationButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: AsanColorScheme.secondary),
      ),
    );
  }
}

class _MonthSelector extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _MonthSelector({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AsanColorScheme.container,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 87,
          height: 38,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AsanTextTheme.bodyMedium.copyWith(height: 22 / 16),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 24,
                  color: AsanColorScheme.inactive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final DateTime month;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;

  const _CalendarGrid({
    required this.month,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstWeekday = DateTime(month.year, month.month, 1).weekday % 7;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    return SizedBox(
      width: 294,
      height: 269,
      child: Column(
        children: [
          SizedBox(
            height: 16,
            child: Row(
              children: _weekdays
                  .map(
                    (day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: AsanTextTheme.labelSmall.copyWith(
                            height: 16 / 12,
                            color: AsanColorScheme.inactive,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 42,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 40,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context, index) {
                final dayNumber = index - firstWeekday + 1;
                final isCurrentMonth =
                    dayNumber > 0 && dayNumber <= daysInMonth;
                if (!isCurrentMonth) return const SizedBox.shrink();

                final date = DateTime(month.year, month.month, dayNumber);
                final isEnabled =
                    !date.isBefore(firstDate) && !date.isAfter(lastDate);
                final isSelected = DateUtils.isSameDay(date, selectedDate);
                final isToday = DateUtils.isSameDay(date, DateTime.now());

                return _DayButton(
                  day: dayNumber,
                  isSelected: isSelected,
                  isToday: isToday,
                  isEnabled: isEnabled,
                  onPressed: () => onDateSelected(date),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DayButton extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool isToday;
  final bool isEnabled;
  final VoidCallback onPressed;

  const _DayButton({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isEnabled
        ? (isSelected
              ? AsanColorScheme.onPrimary
              : (isToday ? AsanColorScheme.primary : AsanColorScheme.secondary))
        : AsanColorScheme.inactive;

    return Material(
      color: isSelected ? AsanColorScheme.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: Text(
            '$day',
            style: AsanTextTheme.bodyMedium.copyWith(
              height: 22 / 16,
              fontWeight: isSelected || isToday
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    this.color = AsanColorScheme.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: AsanTextTheme.labelSmall.copyWith(
            height: 16 / 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
