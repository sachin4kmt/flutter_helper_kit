import 'package:flutter/foundation.dart';

/// Lightweight reactive wrapper for [DateTime] without external state libraries.
class RxDateTime extends ValueNotifier<DateTime> {
  RxDateTime(super.value);

  factory RxDateTime.now() => RxDateTime(DateTime.now());

  DateTime get dateTime => value;
  set dateTime(DateTime v) => value = v;

  bool isBefore(DateTime other) => value.isBefore(other);
  bool isAfter(DateTime other) => value.isAfter(other);
  bool isAtSameMomentAs(DateTime other) => value.isAtSameMomentAs(other);

  int differenceInDays(DateTime other) => value.difference(other).inDays;
  int differenceInHours(DateTime other) => value.difference(other).inHours;
  int differenceInMinutes(DateTime other) => value.difference(other).inMinutes;

  String format([String pattern = 'yyyy-MM-dd HH:mm:ss']) =>
      _formatDateTime(value, pattern);

  String timeAgo() => _timeAgo(value);

  bool get isToday {
    final now = DateTime.now();
    return value.year == now.year &&
        value.month == now.month &&
        value.day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return value.year == yesterday.year &&
        value.month == yesterday.month &&
        value.day == yesterday.day;
  }

  DateTime get startOfDay => DateTime(value.year, value.month, value.day);
  DateTime get endOfDay =>
      DateTime(value.year, value.month, value.day, 23, 59, 59, 999);

  DateTime get startOfWeek {
    final monday = value.subtract(Duration(days: value.weekday - 1));
    return DateTime(monday.year, monday.month, monday.day);
  }

  DateTime get endOfWeek {
    final sunday = value.add(Duration(days: 7 - value.weekday));
    return DateTime(sunday.year, sunday.month, sunday.day, 23, 59, 59, 999);
  }

  DateTime get startOfMonth => DateTime(value.year, value.month, 1);
  DateTime get endOfMonth =>
      DateTime(value.year, value.month + 1, 1).subtract(const Duration(milliseconds: 1));

  RxDateTime addDuration(Duration duration) {
    value = value.add(duration);
    return this;
  }

  RxDateTime subtractDuration(Duration duration) {
    value = value.subtract(duration);
    return this;
  }

  RxDateTime setTime({
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
  }) {
    value = DateTime(value.year, value.month, value.day, hour, minute, second, millisecond);
    return this;
  }

  RxDateTime toUtcTime() {
    value = value.toUtc();
    return this;
  }

  RxDateTime toLocalTime() {
    value = value.toLocal();
    return this;
  }
}

/// Nullable reactive [DateTime].
class RxnDateTime extends ValueNotifier<DateTime?> {
  RxnDateTime([DateTime? initial]) : super(initial);

  factory RxnDateTime.nowOrNull() => RxnDateTime(DateTime.now());

  bool? isBefore(DateTime other) => value?.isBefore(other);
  bool? isAfter(DateTime other) => value?.isAfter(other);
  bool? isAtSameMomentAs(DateTime other) => value?.isAtSameMomentAs(other);

  int? differenceInDays(DateTime other) => value?.difference(other).inDays;
  int? differenceInHours(DateTime other) => value?.difference(other).inHours;
  int? differenceInMinutes(DateTime other) => value?.difference(other).inMinutes;

  String? format([String pattern = 'yyyy-MM-dd HH:mm:ss']) =>
      value == null ? null : _formatDateTime(value!, pattern);

  String? timeAgo() => value == null ? null : _timeAgo(value!);

  bool get isNullOrToday {
    final now = DateTime.now();
    return value == null ||
        (value!.year == now.year &&
            value!.month == now.month &&
            value!.day == now.day);
  }

  RxnDateTime addDuration(Duration duration) {
    if (value != null) value = value!.add(duration);
    return this;
  }

  RxnDateTime subtractDuration(Duration duration) {
    if (value != null) value = value!.subtract(duration);
    return this;
  }

  RxnDateTime setTime({
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
  }) {
    if (value != null) {
      value = DateTime(value!.year, value!.month, value!.day, hour, minute, second, millisecond);
    }
    return this;
  }

  RxnDateTime toUtcTime() {
    if (value != null) value = value!.toUtc();
    return this;
  }

  RxnDateTime toLocalTime() {
    if (value != null) value = value!.toLocal();
    return this;
  }
}

String _timeAgo(DateTime value) {
  final diff = DateTime.now().difference(value);
  if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return _formatDateTime(value, 'MMM d, yyyy');
}

String _formatDateTime(DateTime date, String pattern) {
  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  final pad2 = (int n) => n.toString().padLeft(2, '0');

  return pattern
      .replaceAll('yyyy', date.year.toString())
      .replaceAll('yy', (date.year % 100).toString().padLeft(2, '0'))
      .replaceAll('MMM', months[date.month - 1])
      .replaceAll('MM', pad2(date.month))
      .replaceAll('dd', pad2(date.day))
      .replaceAll('HH', pad2(date.hour))
      .replaceAll('mm', pad2(date.minute))
      .replaceAll('ss', pad2(date.second));
}
