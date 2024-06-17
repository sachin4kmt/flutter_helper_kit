
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/integer_extension.dart';
import 'package:flutter_helper_kit/extensions/string_extension.dart';
import 'package:flutter_helper_kit/utils/ago_time.dart';


extension DateTimeExtension on DateTime? {
  /// Returns `true` if the given date is `null`.
  bool get isNull => this == null;

  /// Returns `true` if the given date is not `null`.
  bool get isNotNull => !isNull;

  /// Returns `true` if the given date is today.
  ///
  /// Returns `false` if the date is `null`.
  bool get isToday {
    if (isNull) {
      return false;
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return DateTime(this!.year, this!.month, this!.day) == today;
  }

  /// Returns `true` if the given date is yesterday.
  ///
  /// Example:
  /// ```dart
  /// DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  /// print(yesterday.isYesterday); // Output: true
  /// ```
  bool get isYesterday {
    if (isNull) {
      return false;
    }
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return DateTime(this!.year, this!.month, this!.day) == yesterday;
  }


  /// Returns `true` if the given date is tomorrow.
  ///
  /// Example:
  /// ```dart
  /// DateTime tomorrow = DateTime.now().add(Duration(days: 1));
  /// print(tomorrow.isTomorrow); // Output: true
  /// ```
  bool get isTomorrow {
    if (isNull) {
      return false;
    }
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return DateTime(this!.year, this!.month, this!.day) == tomorrow;
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

    return this!.weekday.toWeekDay(isHalfName: isHalfName);
  }

  /// Returns Month name of give this [DateTime]
  /// Example: final date = DateTime.now();    //output: 2023-05-24 13:14:23.593304
  /// print(date.monthName()??"");            //output: May
  String? monthName({bool isHalfName = false}) {
    if (isNull) return null;
    return this!.month.toMonthName(isHalfName: isHalfName);
  }

  /// Returns the time in AM/PM format for this [DateTime].
  ///
  /// Example:
  /// ```dart
  /// DateTime dateTime = DateTime.now();
  /// String? timeAmPm = dateTime.toTimeAmPm;
  /// print('Time (AM/PM): $timeAmPm');
  /// ```
  String? get toTimeAmPm {
    if (isNull) return null;

    TimeOfDay noonTime = TimeOfDay.fromDateTime(this!);
    final hour = (noonTime.hour > 12 ? noonTime.hour - 12 : noonTime.hour)
        .toString()
        .padLeft(2, '0');
    final minute = noonTime.minute.toString().padLeft(2, '0');
    if (noonTime.period == DayPeriod.am) {
      return "$hour:$minute Am";
    } else {
      return "$hour:$minute Pm";
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
  int get currentTimeStamp =>
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
  String? get timeAgo {
    if (isNull) return null;
    return timeAgoCalculated(this!);
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
    if (isNull) return null;
    DateTime currentTime = this!;
    if (!(this!.isUtc)) {
      currentTime = this!.toUtc();
    }
    // Define the time difference between UTC and IST
    const int istOffsetMinutes = 330; // UTC+5:30
    // Calculate the time difference in milliseconds
    int timeDifferenceMilliseconds = istOffsetMinutes * 60 * 1000;
    // Apply the time difference to the server time
    DateTime istDateTime = currentTime.add(Duration(milliseconds: timeDifferenceMilliseconds));
    final iSTDate= istDateTime.toIso8601String().replaceAll('Z', '').toDateTime;
    return iSTDate;
  }

  /// Converts the time difference to a number of seconds.
  ///
  /// Returns the number of seconds between the current DateTime instance and [differenceDateTime].
  /// If [differenceDateTime] is not provided, the current system DateTime is used.
  int countSeconds(DateTime? differenceDateTime) {
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
    int count = (difference / 1000).truncate();
    // return count > 1 ? count.toString() + ' seconds' : 'Just now';
    return count;
  }

  /// Converts the time difference to a number of minutes.
  ///
  /// Returns the number of minutes between the current DateTime instance and [differenceDateTime].
  /// If [differenceDateTime] is not provided, the current system DateTime is used.
  int countMinutes(DateTime? differenceDateTime) {
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
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
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
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
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
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
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
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
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
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
    int difference =  (differenceDateTime??DateTime.now()).millisecondsSinceEpoch- (this??DateTime.now()).millisecondsSinceEpoch;
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
  DateTime? get asUtc => isNull?null:DateTime.utc(this!.year,this!.month,this!.day,this!.hour,this!.minute,this!.second,);

}
