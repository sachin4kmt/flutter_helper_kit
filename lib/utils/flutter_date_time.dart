import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';
import 'package:flutter_helper_kit/extensions/date/date_extension.dart';
import 'package:flutter_helper_kit/extensions/date/date_format.dart';

/// Visual style for the pickers.
///
/// * [android] — Material dialog pickers.
/// * [ios] — Cupertino wheel pickers in a bottom sheet.
/// * [platform] — resolves to [ios] on iOS, otherwise [android].
enum PickerStyle { android, ios, platform }

/// Cross-platform date / time pickers built on top of `flutter_helper_kit`.
///
/// Date formatting uses the kit's `DateTime.format` extension (no `intl`
/// dependency) and sizes use the kit's responsive units ([RSizedBox]).
///
/// Colors follow the current [Theme]; override [backgroundColor] /
/// [accentColor] per call when needed.
///
/// ```dart
/// final date = await FlutterDateTime.pickDate(context: context);
/// final label = FlutterDateTime.formatDate(date);
/// ```
class FlutterDateTime {
  FlutterDateTime._();

  static const String _datePattern = 'd MMM yyyy';

  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    PickerStyle style = PickerStyle.platform,
    String doneLabel = 'Done',
    String cancelLabel = 'Cancel',
    Locale? locale,
    Color? backgroundColor,
    Color? accentColor,
  }) async {
    // A date picker only cares about the calendar day, so drop the time from
    // every bound (`dateOnly()` returns a new value — it does not mutate). This
    // prevents a sub-second gap between two `DateTime.now()` values from making
    // `initialDate` fall just before `firstDate` and tripping the picker's
    // min/max assertions. The initial value is also clamped into range.
    final DateTime first = (firstDate ?? DateTime(1900)).dateOnly();
    final DateTime last = (lastDate ?? DateTime(2100)).dateOnly();
    DateTime initial = (initialDate ?? DateTime.now()).dateOnly();
    if (initial.isBefore(first)) initial = first;
    if (initial.isAfter(last)) initial = last;

    final PickerStyle pickerStyle = _resolveStyle(context, style);

    if (pickerStyle == PickerStyle.ios) {
      return _cupertinoPicker(
        context: context,
        initialDate: initial,
        mode: CupertinoDatePickerMode.date,
        doneLabel: doneLabel,
        cancelLabel: cancelLabel,
        minimumDate: first,
        maximumDate: last,
        backgroundColor: backgroundColor,
        accentColor: accentColor,
      );
    }

    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      locale: locale,
      builder: (BuildContext ctx, Widget? child) =>
          _applyAccent(ctx, child, accentColor),
    );
  }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
    PickerStyle style = PickerStyle.platform,
    bool use24hFormat = true,
    String doneLabel = 'Done',
    String cancelLabel = 'Cancel',
    Color? backgroundColor,
    Color? accentColor,
  }) async {
    initialTime ??= TimeOfDay.now();
    final PickerStyle pickerStyle = _resolveStyle(context, style);

    if (pickerStyle == PickerStyle.ios) {
      final DateTime? picked = await _cupertinoPicker(
        context: context,
        initialDate: DateTime(0, 1, 1, initialTime.hour, initialTime.minute),
        mode: CupertinoDatePickerMode.time,
        use24hFormat: use24hFormat,
        doneLabel: doneLabel,
        cancelLabel: cancelLabel,
        backgroundColor: backgroundColor,
        accentColor: accentColor,
      );
      return picked != null
          ? TimeOfDay(hour: picked.hour, minute: picked.minute)
          : null;
    }

    return showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext ctx, Widget? child) =>
          _applyAccent(ctx, child, accentColor),
    );
  }

  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
    PickerStyle style = PickerStyle.platform,
    bool use24hFormat = true,
    Color? backgroundColor,
    Color? accentColor,
  }) async {
    final PickerStyle pickerStyle = _resolveStyle(context, style);

    if (pickerStyle == PickerStyle.ios) {
      return _cupertinoPicker(
        context: context,
        initialDate: initialDateTime ?? DateTime.now(),
        mode: CupertinoDatePickerMode.dateAndTime,
        use24hFormat: use24hFormat,
        minimumDate: firstDate,
        maximumDate: lastDate,
        backgroundColor: backgroundColor,
        accentColor: accentColor,
      );
    }

    final DateTime? date = await pickDate(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
      style: pickerStyle,
      backgroundColor: backgroundColor,
      accentColor: accentColor,
    );
    if (date == null || !context.mounted) return null;

    final TimeOfDay? time = await pickTime(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime ?? DateTime.now()),
      style: pickerStyle,
      use24hFormat: use24hFormat,
      backgroundColor: backgroundColor,
      accentColor: accentColor,
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// Date picker preset for Date of Birth (max = today, default 18 yrs ago).
  static Future<DateTime?> pickDOB({
    required BuildContext context,
    PickerStyle style = PickerStyle.platform,
    String doneLabel = 'Done',
    String cancelLabel = 'Cancel',
    Locale? locale,
    Color? backgroundColor,
    Color? accentColor,
  }) {
    final DateTime now = DateTime.now();
    return pickDate(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(now.year - 120),
      lastDate: now,
      style: style,
      doneLabel: doneLabel,
      cancelLabel: cancelLabel,
      locale: locale,
      backgroundColor: backgroundColor,
      accentColor: accentColor,
    );
  }

  static Future<DateTimeRange?> pickDateRange({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    PickerStyle style = PickerStyle.platform,
    String doneLabel = 'Done',
    String cancelLabel = 'Cancel',
    Color? backgroundColor,
    Color? accentColor,
  }) async {
    final PickerStyle pickerStyle = _resolveStyle(context, style);
    final DateTime now = DateTime.now();
    firstDate ??= DateTime(1900);
    lastDate ??= DateTime(2100);

    if (pickerStyle == PickerStyle.ios) {
      final DateTime? start = await showModalBottomSheet<DateTime>(
        context: context,
        backgroundColor: backgroundColor,
        builder: (_) {
          DateTime temp = now;
          return _CupertinoSinglePicker(
            title: 'Select Start Date',
            initial: now,
            min: firstDate!,
            max: lastDate!,
            cancelLabel: cancelLabel,
            doneLabel: doneLabel,
            accentColor: accentColor,
            onChanged: (DateTime val) => temp = val,
            onDone: () => Navigator.pop(context, temp),
          );
        },
      );

      if (start == null || !context.mounted) return null;

      final DateTime? end = await showModalBottomSheet<DateTime>(
        context: context,
        backgroundColor: backgroundColor,
        builder: (_) {
          DateTime temp = start;
          return _CupertinoSinglePicker(
            title: 'Select End Date',
            initial: start,
            min: start,
            max: lastDate!,
            cancelLabel: cancelLabel,
            doneLabel: doneLabel,
            accentColor: accentColor,
            onChanged: (DateTime val) => temp = val,
            onDone: () => Navigator.pop(context, temp),
          );
        },
      );

      if (end == null) return null;
      return DateTimeRange(start: start, end: end);
    }

    return showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: DateTimeRange(
        start: now,
        end: now.add(const Duration(days: 7)),
      ),
      builder: (BuildContext ctx, Widget? child) =>
          _applyAccent(ctx, child, accentColor),
    );
  }

  /// Formats a [date] via the helper-kit extension (empty string when null).
  static String formatDate(DateTime? date, {String pattern = _datePattern}) =>
      date == null ? '' : date.format(pattern: pattern);

  /// Formats a [time] (24h by default) via the helper-kit extension.
  static String formatTime(TimeOfDay? time, {bool use24hFormat = true}) {
    if (time == null) return '';
    final DateTime now = DateTime.now();
    final DateTime dt =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return dt.format(pattern: use24hFormat ? 'HH:mm' : 'hh:mm a');
  }

  static Future<DateTime?> _cupertinoPicker({
    required BuildContext context,
    required DateTime initialDate,
    required CupertinoDatePickerMode mode,
    bool use24hFormat = true,
    String doneLabel = 'Done',
    String cancelLabel = 'Cancel',
    DateTime? minimumDate,
    DateTime? maximumDate,
    Color? backgroundColor,
    Color? accentColor,
  }) async {
    // Defensively clamp the initial value inside [minimumDate, maximumDate].
    // Two `DateTime.now()` calls can differ by microseconds, which is enough to
    // trip `CupertinoDatePicker`'s `!minimumDate.isAfter(initialDateTime)`
    // assertion for the time / dateAndTime modes.
    DateTime start = initialDate;
    if (minimumDate != null && start.isBefore(minimumDate)) start = minimumDate;
    if (maximumDate != null && start.isAfter(maximumDate)) start = maximumDate;
    DateTime tempPicked = start;

    return showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: backgroundColor,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          top: false,
          child: RSizedBox(
            height: 300,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Theme.of(sheetContext).brightness,
              ),
              child: Column(
                children: <Widget>[
                  _PickerActions(
                    doneLabel: doneLabel,
                    cancelLabel: cancelLabel,
                    accentColor: accentColor,
                    onCancel: () => Navigator.of(sheetContext).pop(),
                    onDone: () => Navigator.of(sheetContext).pop(tempPicked),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: mode,
                      initialDateTime: start,
                      minimumDate: minimumDate,
                      maximumDate: maximumDate,
                      use24hFormat: use24hFormat,
                      onDateTimeChanged: (DateTime val) => tempPicked = val,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _applyAccent(
    BuildContext context,
    Widget? child,
    Color? accentColor,
  ) {
    if (child == null) return const RSizedBox.shrink();
    if (accentColor == null) return child;
    final ThemeData theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primary: accentColor),
      ),
      child: child,
    );
  }

  static PickerStyle _resolveStyle(BuildContext context, PickerStyle style) {
    if (style == PickerStyle.platform) {
      return Theme.of(context).platform == TargetPlatform.iOS
          ? PickerStyle.ios
          : PickerStyle.android;
    }
    return style;
  }
}

/// Cancel / Done action bar for the Cupertino picker sheets.
class _PickerActions extends StatelessWidget {
  const _PickerActions({
    required this.doneLabel,
    required this.cancelLabel,
    required this.onCancel,
    required this.onDone,
    this.title,
    this.accentColor,
  });

  final String doneLabel;
  final String cancelLabel;
  final String? title;
  final Color? accentColor;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color doneColor = accentColor ?? theme.colorScheme.primary;
    final Color cancelColor =
        theme.textTheme.bodyMedium?.color ?? theme.colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CupertinoButton(
          onPressed: onCancel,
          child: Text(cancelLabel, style: TextStyle(color: cancelColor)),
        ),
        if (title != null)
          Text(
            title!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        CupertinoButton(
          onPressed: onDone,
          child: Text(doneLabel, style: TextStyle(color: doneColor)),
        ),
      ],
    );
  }
}

/// Reusable single-date Cupertino picker sheet.
class _CupertinoSinglePicker extends StatelessWidget {
  const _CupertinoSinglePicker({
    required this.title,
    required this.initial,
    required this.min,
    required this.max,
    required this.doneLabel,
    required this.cancelLabel,
    required this.onDone,
    required this.onChanged,
    this.accentColor,
  });

  final String title;
  final DateTime initial;
  final DateTime min;
  final DateTime max;
  final String doneLabel;
  final String cancelLabel;
  final Color? accentColor;
  final VoidCallback onDone;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: RSizedBox(
        height: 300,
        child: CupertinoTheme(
          data: CupertinoThemeData(brightness: Theme.of(context).brightness),
          child: Column(
            children: <Widget>[
              _PickerActions(
                title: title,
                doneLabel: doneLabel,
                cancelLabel: cancelLabel,
                accentColor: accentColor,
                onCancel: () => Navigator.pop(context),
                onDone: onDone,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initial,
                  minimumDate: min,
                  maximumDate: max,
                  onDateTimeChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
