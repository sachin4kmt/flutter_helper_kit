import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

extension DateTimeNullExtension on DateTime? {
  /// Returns `true` if the given date is `null`.
  bool get isNull => this == null;
}

extension DateTimeExtension on DateTime {
  /// Returns `true` if the given date is not `null`.
  bool get isNotNull => !isNull;

  /// Returns `true` if the given date is today.
  ///
  /// Returns `false` if the date is `null`.
  bool isToday() {
    if (isNull) {
      return false;
    }
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day;
  }

  /// Returns `true` if the given date is yesterday.
  ///
  /// Example:
  /// ```dart
  /// DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  /// print(yesterday.isYesterday); // Output: true
  /// ```
  bool  isYesterday() {
    if (isNull) {
      return false;
    }
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day - 1;
  }

  /// Returns `true` if the given date is tomorrow.
  ///
  /// Example:
  /// ```dart
  /// DateTime tomorrow = DateTime.now().add(Duration(days: 1));
  /// print(tomorrow.isTomorrow); // Output: true
  /// ```
  bool  isTomorrow() {
    if (isNull) {
      return false;
    }
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day + 1;
  }

  /// Returns a [DateTime] with the date of the original, but time set to midnight.
  ///
  /// Example:
  /// ```dart
  /// DateTime fullDateTime = DateTime(2022, 1, 8, 15, 30);
  /// DateTime dateOnly = fullDateTime.dateOnly;
  /// print(dateOnly);  // 2022-01-08 00:00:00.000
  /// ```
  ///
  /// The `dateOnly` extension provides a convenient way to obtain a new `DateTime` instance
  /// with the same date as the original but with the time set to midnight (00:00:00).
  /// This is useful when you want to work specifically with the date component and ignore the time.
  DateTime  dateOnly() => DateTime(year, month, day);

  /// Adds a certain amount of days to this date and returns a new [DateTime] instance.
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime futureDate = currentDate.addDays(5);
  /// print(futureDate);  // 2022-01-13 00:00:00.000
  /// ```
  ///
  /// The `addDays` method creates a new [DateTime] instance by adding the specified
  /// number of days to the original date. The time components (hour, minute, second,
  /// millisecond, microsecond) remain unchanged.
  DateTime addDays(int amount) => DateTime(
        year,
        month,
        day + amount,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );

  /// Adds a certain amount of hours to this date and returns a new [DateTime] instance.
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8, 12, 0);
  /// DateTime futureDate = currentDate.addHours(3);
  /// print(futureDate);  // 2022-01-08 15:00:00.000
  /// ```
  ///
  /// The `addHours` method creates a new [DateTime] instance by adding the specified
  /// number of hours to the original date. The date components (year, month, day)
  /// remain unchanged.
  DateTime addHours(int amount) => DateTime(
        year,
        month,
        day,
        hour + amount,
        minute,
        second,
        millisecond,
        microsecond,
      );

  /// Returns a [DateTime] representing the day after this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime nextDay = currentDate.nextDay;
  /// print(nextDay);  // 2022-01-09 00:00:00.000
  /// ```
  ///
  /// The `nextDay` extension provides a convenient way to obtain a new [DateTime] instance
  /// representing the day immediately following the original date.
  DateTime  nextDay() => addDays(1);

  /// Returns a [DateTime] representing the day before this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime previousDay = currentDate.previousDay;
  /// print(previousDay);  // 2022-01-07 00:00:00.000
  /// ```
  ///
  /// The `previousDay` extension provides a convenient way to obtain a new [DateTime] instance
  /// representing the day immediately preceding the original date.
  DateTime  previousDay() => addDays(-1);

  /// Checks whether two [DateTime] instances are on the same day.
  ///
  /// Example:
  /// ```dart
  /// DateTime date1 = DateTime(2022, 1, 8, 12, 0);
  /// DateTime date2 = DateTime(2022, 1, 8, 18, 30);
  ///
  /// print(date1.isSameDay(date2));  // true
  /// ```
  ///
  /// The `isSameDay` method compares the year, month, and day components of two [DateTime] instances.
  /// It returns [true] if they are on the same day and [false] otherwise.
  bool isSameDay(DateTime b) =>
      year == b.year && month == b.month && day == b.day;

  /// Checks if this [DateTime] instance represents the first day of the month.
  ///
  /// Example:
  /// ```dart
  /// DateTime firstDay = DateTime(2022, 1, 1);
  /// DateTime otherDay = DateTime(2022, 1, 8);
  ///
  /// print(firstDay.isFirstDayOfMonth);  // Output: true
  /// print(otherDay.isFirstDayOfMonth);  // Output: false
  /// ```
  ///
  /// The `isFirstDayOfMonth` extension returns [true] if the date is the first day of the month,
  /// and [false] otherwise. It compares the year, month, and day components of the [DateTime]
  /// instance with the date of the first day of the same month.
  bool  isFirstDayOfMonth() => isSameDay(firstDayOfMonth());

  /// Checks if this [DateTime] instance represents the last day of the month.
  ///
  /// Example:
  /// ```dart
  /// DateTime lastDay = DateTime(2022, 1, 31);
  /// DateTime otherDay = DateTime(2022, 1, 8);
  ///
  /// print(lastDay.isLastDayOfMonth);  // Output: true
  /// print(otherDay.isLastDayOfMonth);  // Output: false
  /// ```
  ///
  /// The `isLastDayOfMonth` extension returns [true] if the date is the last day of the month,
  /// and [false] otherwise. It compares the year, month, and day components of the [DateTime]
  /// instance with the date of the last day of the same month.
  bool  isLastDayOfMonth() => isSameDay(lastDayOfMonth());

  /// Returns a [DateTime] instance representing the first day of the month of this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime firstDay = currentDate.firstDayOfMonth;
  /// print(firstDay);  // Output: 2022-01-01 00:00:00.000
  /// ```
  ///
  /// The `firstDayOfMonth` extension returns a new [DateTime] instance with the same year and month
  /// as the original date but with the day set to 1 and the time set to midnight (00:00:00).
  DateTime  firstDayOfMonth() => DateTime(year, month);

  /// Returns a [DateTime] instance representing the first day of the week of this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime firstDayOfWeek = currentDate.firstDayOfWeek;
  /// print(firstDayOfWeek);  // Output: 2022-01-03 12:00:00.000 (Assuming Monday is the first day of the week)
  /// ```
  ///
  /// The `firstDayOfWeek` getter returns a new [DateTime] instance with the same year, month,
  /// and hour as the original date but adjusted to the first day of the week. Daylight Saving
  /// Time is handled by setting the hour to 12:00 Noon rather than the default of Midnight (00:00:00).
  /// The week in this context is considered to start from Monday.
  DateTime  firstDayOfWeek() {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(year, month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    var decreaseNum = (day.weekday - 1) % 7;
    return subtract(Duration(days: decreaseNum));
  }

  /// Returns a [DateTime] instance representing the last day of the week of this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime lastDayOfWeek = currentDate.lastDayOfWeek;
  /// print(lastDayOfWeek);  // Output: 2022-01-09 12:00:00.000 (Assuming Sunday is the last day of the week)
  /// ```
  ///
  /// The `lastDayOfWeek` getter returns a new [DateTime] instance with the same year, month,
  /// and hour as the original date but adjusted to the last day of the week. Daylight Saving
  /// Time is handled by setting the hour to 12:00 Noon rather than the default of Midnight (00:00:00).
  /// The week in this context is considered to end on Sunday.
  DateTime lastDayOfWeek() {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(year, month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    var increaseNum = (7 - day.weekday) % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// Returns a [DateTime] instance representing the last day of the month of this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2022, 1, 8);
  /// DateTime lastDayOfMonth = currentDate.lastDayOfMonth;
  /// print(lastDayOfMonth);  // Output: 2022-01-31 00:00:00.000
  /// ```
  ///
  /// The `lastDayOfMonth` getter calculates and returns a new [DateTime] instance with the same
  /// year and month as the original date but adjusted to the last day of that month.
  DateTime lastDayOfMonth() {
    var beginningNextMonth =
        (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// Returns a [DateTime] instance representing the exact date of the previous month.
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2024, 1, 8);
  /// DateTime previousMonthDate = currentDate.previousMonth;
  /// print(previousMonthDate);  // Output: 2023-12-08 00:00:00
  /// ```
  ///
  /// The `previousMonth` extension calculates and returns a new [DateTime] instance
  /// with the same day and time as the original date but adjusted to the exact date of the previous month.
  DateTime previousMonth() {
    var year = this.year;
    var month = this.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  /// Returns a [DateTime] instance representing the exact date of the next coming month.
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2024, 1, 8);
  /// DateTime nextMonthDate = currentDate.nextMonth;
  /// print(nextMonthDate);  // Output: 2023-2-08 00:00:00
  /// ```
  ///
  /// The `nextMonth` extension calculates and returns a new [DateTime] instance
  /// with the same day and time as the original date but adjusted to the exact date of the next month.
  DateTime nextMonth() {
    var year = this.year;
    var month = this.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  /// Returns a [DateTime] instance representing the exact date of the previous week.
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2024, 1, 15);
  /// DateTime previousWeekDate = currentDate.previousWeek;
  /// print(previousWeekDate);  // Output: 2024-01-08 00:00:00
  /// ```
  ///
  /// The `previousWeek` extension calculates and returns a new [DateTime] instance
  /// by subtracting seven days from the original date, representing the exact date of the previous week.
  DateTime previousWeek() => subtract(const Duration(days: 7));

  /// Returns a [DateTime] instance representing the exact date of the coming week.
  ///
  /// Example:
  /// ```dart
  /// DateTime currentDate = DateTime(2024, 1, 8);
  /// DateTime nextWeekDate = currentDate.nextWeek;
  /// print(nextWeekDate);  // Output: 2024-01-15 00:00:00
  /// ```
  ///
  /// The `nextWeek` extension calculates and returns a new [DateTime] instance
  /// by adding seven days to the original date, representing the exact date of the coming week.
  DateTime nextWeek() => add(const Duration(days: 7));

  /// Checks if two [DateTime] instances fall within the same week.
  ///
  /// Example:
  /// ```dart
  /// DateTime date1 = DateTime(2024, 1, 8);
  /// DateTime date2 = DateTime(2024, 1, 12);
  ///
  /// bool result = date1.isSameWeek(date2);
  /// print(result);  // Output: true
  /// ```
  ///
  /// The `isSameWeek` method compares two [DateTime] instances, ignoring the time component,
  /// and determines if they fall within the same week.
  bool isSameWeek(DateTime b) {
    final a = DateTime.utc(year, month, day);
    b = DateTime.utc(b.year, b.month, b.day);

    final diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    final min = a.isBefore(b) ? a : b;
    final max = a.isBefore(b) ? b : a;
    final result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  /// Returns the name of the weekday for the given date.
  ///
  /// If [isHalfName] is `true`, returns the abbreviated name (e.g., "Mon" for Monday).
  ///
  /// Example:
  /// ```dart
  /// DateTime date = DateTime.now();
  /// print(date.weekdayName()); // Output: Monday
  /// ```
  String? weekdayName({bool isHalfName = false}) {
    if (isNull) return null;

    return weekday.toWeekDay(isHalfName: isHalfName);
  }

  /// Returns Month name of give this [DateTime]
  /// Example: final date = DateTime.now();    //output: 2023-05-24 13:14:23.593304
  /// print(date.monthName()??"");            //output: May
  String? monthName({bool isHalfName = false}) {
    if (isNull) return null;
    return month.toMonthName(isHalfName: isHalfName);
  }

  /// Returns the time in AM/PM format for this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// String? timeAmPm = dateTime.toTimeAmPm;
  /// print('Time (AM/PM): $timeAmPm');
  /// ```
  String? toTimeAmPm() {
    TimeOfDay noonTime = TimeOfDay.fromDateTime(this);
    final hour = (noonTime.hour > 12 ? noonTime.hour - 12 : noonTime.hour)
        .toString()
        .padLeft(2, '0');
    final minute = noonTime.minute.toString().padLeft(2, '0');
    if (noonTime.period == DayPeriod.am) {
      return '$hour:$minute Am';
    } else {
      return '$hour:$minute Pm';
    }
  }

  /// Returns the current timestamp in seconds.
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// int currentTimeStamp = dateTime.currentTimeStamp;
  /// print('Current Timestamp: $currentTimeStamp');
  /// ```
  int currentTimeStamp() =>
      (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();

  /// Returns the time difference from this [DateTime] to the current DateTime
  /// in Indian language.
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.tryParse("2023-05-24 13:19:55.565473");
  /// String? timeAgo = dateTime.timeAgo;
  /// print('Time Ago: $timeAgo');
  /// ```
  String? timeAgo() {
    return timeAgoCalculated(this);
  }

  /// Converts the DateTime object to the Indian time zone.
  ///
  /// Returns a new DateTime object representing the time in the Indian time zone,
  /// or `null` if the input DateTime is `null`.
  ///
  /// Example:
  /// ```dart
  /// DateTime utcDateTime = DateTime.now().toUtc();
  /// DateTime? indianDateTime = utcDateTime.toIndiaTimeZone();
  /// print('Indian DateTime: $indianDateTime');
  /// ```
  DateTime? toIndiaTimeZone() {
    DateTime currentTime = this;
    if (!(isUtc)) {
      currentTime = toUtc();
    }
    // Define the time difference between UTC and IST
    const int istOffsetMinutes = 330; // UTC+5:30
    // Calculate the time difference in milliseconds
    int timeDifferenceMilliseconds = istOffsetMinutes * 60 * 1000;
    // Apply the time difference to the server time
    DateTime istDateTime =
        currentTime.add(Duration(milliseconds: timeDifferenceMilliseconds));
    final iSTDate =
        istDateTime.toIso8601String().replaceAll('Z', '').toDateTime();
    return iSTDate;
  }

  /// Converts the time difference to a number of seconds.
  ///
  /// Returns the number of seconds between the current DateTime instance and [differenceDateTime].
  /// If [differenceDateTime] is not provided, the current system DateTime is used.
  int countSeconds(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 1000).truncate();
    // return count > 1 ? count.toString() + ' seconds' : 'Just now';
    return count;
  }

  /// Converts the time difference to a number of minutes.
  ///
  /// Returns the number of minutes between the current DateTime instance and [differenceDateTime].
  /// If [differenceDateTime] is not provided, the current system DateTime is used.
  int countMinutes(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 60000).truncate();
    // return count.toString() + (count > 1 ? ' minutes' : ' minute');
    return count;
  }

  /// Calculates the difference in hours between the current DateTime object and [differenceDateTime].
  ///
  /// If [differenceDateTime] is null, the current DateTime object is used.
  ///
  /// Returns the difference in hours as an integer value.
  ///
  /// Example:
  /// ```dart
  /// DateTime startDateTime = DateTime(2023, 1, 1);
  /// DateTime endDateTime = DateTime(2023, 1, 2);
  ///
  /// int differenceInHours = startDateTime.countHours(endDateTime);
  /// print('Difference in hours: $differenceInHours'); // Output: 24
  /// ```
  int countHours(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 3600000).truncate();
    // return count.toString() + (count > 1 ? ' hours' : ' hour');
    return count;
  }

  /// Calculates the number of days between two [DateTime] objects.
  ///
  /// The [differenceDateTime] parameter specifies the end date for the calculation.
  ///
  /// Returns the number of days as an integer value.
  int countDays(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 86400000).truncate();
    // return count.toString() + (count > 1 ? ' days' : ' day');
    return count;
  }

  /// Counts the number of weeks between the current [DateTime] and the [differenceDateTime].
  ///
  /// Returns an integer representing the number of weeks.
  /// This function truncates to the lowest week.
  ///
  /// Example:
  /// ```dart
  /// DateTime date1 = DateTime(2023, 1, 1);
  /// DateTime date2 = DateTime(2023, 10, 16);
  /// int weeksDifference = date1.countWeeks(date2);
  /// print('Weeks difference: $weeksDifference'); // Output: Weeks difference: 41
  /// ```
  int countWeeks(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 604800000).truncate();
/*    if (count > 3) {
      // return '1 month';
      return 1;
    }*/
    // return count.toString() + (count > 1 ? ' weeks' : ' week');
    return count;
  }

  /// Calculates the number of months between the current DateTime object and [differenceDateTime].
  ///
  /// This function rounds to the nearest month and returns the count as an integer.
  /// The result can be positive if [differenceDateTime] is after the current DateTime object,
  /// or negative if [differenceDateTime] is before the current DateTime object.
  ///
  /// Example:
  /// ```dart
  /// DateTime startDate = DateTime(1996, 1, 1);
  /// DateTime endDate = DateTime(2023, 10, 16);
  ///
  /// int monthsDifference = startDate.countMonths(endDate); // Output: 334
  /// ```
  int countMonths(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 2628003000).round();
    return count;
  }

  /// Calculates the number of years between this DateTime instance and another DateTime instance.
  ///
  /// Returns an integer representing the number of years difference.
  ///
  /// Example usage:
  /// ```dart
  /// DateTime startDate = DateTime(1996, 1, 1);
  /// DateTime endDate = DateTime(2023, 10, 16);
  ///
  /// int yearsDifference = startDate.countYears(endDate);
  /// print('Years Difference: $yearsDifference'); // Output: 27
  /// ```
  int countYears(DateTime? differenceDateTime) {
    int difference =
        (differenceDateTime ?? DateTime.now()).millisecondsSinceEpoch -
            millisecondsSinceEpoch;
    int count = (difference / 31536000000).truncate();
    // return count.toString() + (count > 1 ? ' years' : ' year');
    return count;
  }

  /// Converts the DateTime object to the UTC timezone.
  ///
  /// Returns a DateTime object in UTC timezone.
  ///
  /// If the DateTime object is null, returns null.
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// DateTime? utcDateTime = dateTime.asUtc;
  /// print('UTC DateTime: $utcDateTime');
  /// ```
  DateTime? asUtc() => isNull
      ? null
      : DateTime.utc(
          year,
          month,
          day,
          hour,
          minute,
          second,
        );
}
