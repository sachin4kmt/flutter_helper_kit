import 'package:flutter_helper_kit/flutter_helper_kit.dart';

extension DateTimeFormatExtension on DateTime {
  /// Formats the current date-time object into a custom string pattern.
  ///
  /// This method replaces specific placeholders in the given pattern with the corresponding
  /// date-time components, such as year, month, day, hour, minute, second, and more.
  ///
  /// ### **Supported Pattern Placeholders:**
  /// - `yyyy` → Full year (e.g., `2025`)
  /// - `yy` → Two-digit year (e.g., `25`)
  /// - `MMMM` → Full month name (e.g., `February`)
  /// - `MMM` → Abbreviated month name (e.g., `Feb`)
  /// - `MM` → Two-digit month (e.g., `02`)
  /// - `M` → Single-digit month (e.g., `2`)
  /// - `dd` → Two-digit day (e.g., `05`)
  /// - `d` → Single-digit day (e.g., `5`)
  /// - `EEEE` → Full weekday name (e.g., `Tuesday`)
  /// - `EEE` → Abbreviated weekday name (e.g., `Tue`)
  /// - `HH` → 24-hour format (e.g., `17`)
  /// - `H` → 24-hour format without leading zero (e.g., `5`)
  /// - `hh` → 12-hour format (e.g., `05`)
  /// - `h` → 12-hour format without leading zero (e.g., `5`)
  /// - `mm` → Two-digit minutes (e.g., `09`)
  /// - `m` → Single-digit minutes (e.g., `9`)
  /// - `ss` → Two-digit seconds (e.g., `07`)
  /// - `s` → Single-digit seconds (e.g., `7`)
  /// - `SSS` → Milliseconds (e.g., `007`)
  /// - `a` → AM/PM (e.g., `PM`)
  /// - `Z` → Time zone offset (e.g., `+0530`)
  /// - `z` → Time zone name (e.g., `IST`)
  /// - `Q` → Quarter of the year (e.g., `1`, `2`, `3`, `4`)
  /// - `DD` → Day of the year, three-digit (e.g., `036`)
  /// - `D` → Day of the year (e.g., `36`)
  /// - `ww` → ISO week number, two-digit (e.g., `06`)
  /// - `w` → ISO week number (e.g., `6`)
  /// - `u` → ISO weekday number (`1` = Monday, `7` = Sunday)
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final date = DateTime(2025, 2, 5, 17, 54);
  /// print(date.format(pattern: 'd MMMM, yyyy at h:mm a Q'));
  /// // Output: "5 February, 2025 at 5:54 PM 1"
  /// ```
  String format({String pattern = 'dd-MM-yyyy'}) {
    final isPM = hour >= 12;
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;

    String formatted = pattern;

    final patternMap = {
      'yyyy': year.toString(),
      'yy': year.toString().substring(2),
      'MMMM': monthName(),
      'MMM': monthName(isHalfName: true),
      'MM': month.addZeroPrefix().validate(),
      'M': month.toString(),
      'dd': day.addZeroPrefix().validate(),
      'd': day.toString(),
      'EEEE': weekdayName(),
      'EEE': weekdayName(isHalfName: true),
      'HH': hour.addZeroPrefix().validate(),
      'H': hour.toString(),
      'hh': hour12.addZeroPrefix().validate(),
      'h': hour12.toString(),
      'mm': minute.addZeroPrefix().validate(),
      'm': minute.toString(),
      'ss': second.addZeroPrefix().validate(),
      's': second.toString(),
      'SSS': millisecond.toString().padLeft(3, '0'),
      'a': isPM ? 'PM' : 'AM',
      'Z': timeZoneOffSet(),
      'z': timeZoneName,
      'Q': ((month - 1) ~/ 3 + 1).toString(),
      'DD': dayOfYear().toString().padLeft(3, '0'),
      'D': dayOfYear().toString(),
      'ww': weekOfYear().addZeroPrefix().validate(),
      'w': weekOfYear().toString(),
      'u': weekday.toString(),
    };

    // Replace using regex to avoid unwanted replacements
    patternMap.forEach((key, value) {
      formatted = formatted.replaceAllMapped(
          RegExp(r'\b' + key + r'\b'), (match) => value);
    });

    return formatted;
  }

  /// Formats the current date-time object into a time string based on a given pattern.
  ///
  /// This method is a convenience wrapper around `format()`, allowing you to format only
  /// the time portion of a `DateTime` object.
  ///
  /// ### **Supported Time Placeholders:**
  /// - `HH` → 24-hour format (e.g., `17`)
  /// - `H` → 24-hour format without leading zero (e.g., `5`)
  /// - `hh` → 12-hour format (e.g., `05`)
  /// - `h` → 12-hour format without leading zero (e.g., `5`)
  /// - `mm` → Two-digit minutes (e.g., `09`)
  /// - `m` → Single-digit minutes (e.g., `9`)
  /// - `ss` → Two-digit seconds (e.g., `07`)
  /// - `s` → Single-digit seconds (e.g., `7`)
  /// - `SSS` → Milliseconds (e.g., `007`)
  /// - `a` → AM/PM (e.g., `PM`)
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final date = DateTime(2025, 2, 5, 17, 54, 30);
  /// print(date.formatTime()); // Default: "17:54:30"
  /// print(date.formatTime(pattern: 'hh:mm a')); // Output: "05:54 PM"
  /// ```
  String formatTime({String pattern = 'HH:mm:ss'}) {
    return format(pattern: pattern);
  }

  /// Calculates the day of the year for the current `DateTime` object.
  ///
  /// This method returns an integer representing the day of the year, where:
  /// - January 1st returns `1`
  /// - December 31st returns `365` (or `366` in a leap year)
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final date = DateTime(2025, 2, 5);
  /// print(date.dayOfYear()); // Output: 36 (since February 5th is the 36th day in 2025)
  /// ```
  ///
  /// ### **Leap Year Example:**
  /// ```dart
  /// final leapYearDate = DateTime(2024, 12, 31);
  /// print(leapYearDate.dayOfYear()); // Output: 366 (2024 is a leap year)
  /// ```
  ///
  /// ### **Use Cases:**
  /// - Determining the day of the year for seasonal calculations.
  /// - Useful for generating Julian dates or for analytics based on yearly progress.
  ///
  /// ### **Performance:**
  /// - Time complexity: **O(1)**
  /// - Space complexity: **O(1)**
  int dayOfYear() {
    final startOfYear = DateTime(year, 1, 1);
    return difference(startOfYear).inDays + 1;
  }

  /// Calculates the week number of the year for the current `DateTime` instance.
  ///
  /// The first week of the year starts from January 1st, and each subsequent week
  /// begins on a new Monday.
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final date = DateTime(2025, 2, 5);
  /// print(date.weekOfYear()); // Output: 6 (Feb 5th falls in the 6th week of 2025)
  /// ```
  ///
  /// **Returns:**
  /// - An integer representing the week number of the year.
  ///
  /// **Note:**
  /// - This method assumes weeks start from January 1st and does not strictly follow
  ///   ISO 8601 week numbering (which considers the first Thursday of the year).
  int weekOfYear() {
    final startOfYear = DateTime(year, 1, 1);
    final daysSinceStart = difference(startOfYear).inDays;
    return (daysSinceStart / 7).ceil();
  }

  /// Calculates the ISO 8601 week number of the year for the current `DateTime` instance.
  ///
  /// The ISO 8601 standard defines weeks as starting on Monday, with Week 1 being the
  /// week containing the first Thursday of the year.
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final date = DateTime(2025, 2, 5);
  /// print(date.isoWeekOfYear()); // Output: 6 (Feb 5th falls in the 6th ISO week of 2025)
  /// ```
  ///
  /// **Returns:**
  /// - An integer representing the ISO 8601 week number of the year.
  ///
  /// **How It Works:**
  /// 1. Adjusts the current date to the nearest Thursday (since ISO weeks are based on Thursdays).
  /// 2. Determines the start of the year.
  /// 3. Calculates the difference in days and divides by 7 to find the week number.
  ///
  /// **Note:**
  /// - ISO weeks start on Monday.
  /// - Week 1 is the week containing the first Thursday of the year.
  int isoWeekOfYear() {
    // Adjust to the nearest Thursday (ISO weeks are based on Thursdays)
    final thursdayOfCurrentWeek = this.subtract(Duration(days: weekday - 4));

    // Get the first day of the year
    final startOfYear = DateTime(thursdayOfCurrentWeek.year, 1, 1);

    // Compute days since the start of the year and divide by 7
    final daysSinceStart = thursdayOfCurrentWeek.difference(startOfYear).inDays;

    return (daysSinceStart / 7).floor() + 1;
  }

  /// Returns the formatted timezone offset as a string in `±HH:mm` format.
  ///
  /// The method retrieves the current timezone offset from UTC and formats it
  /// properly with leading zeros for hours and minutes.
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final date = DateTime.now();
  /// print(date.timeZoneOffsetFormatted()); // Example Output: "+05:30"
  /// ```
  ///
  /// **Returns:**
  /// - A string representing the timezone offset in `±HH:mm` format.
  ///
  /// **How It Works:**
  /// - Retrieves the timezone offset from the `DateTime` object.
  /// - Extracts hours and minutes, ensuring they have leading zeros.
  /// - Handles negative offsets correctly by prefixing `-` when needed.
  ///
  /// **Note:**
  /// - This method assumes `addZeroPrefix()` is an extension on `int` that ensures
  ///   numbers are at least two digits (e.g., `5` → `"05"`).
  String timeZoneOffSet() {
    final offset = this.timeZoneOffset;
    final hours = offset.inHours.addZeroPrefix();
    final minutes = (offset.inMinutes % 60).addZeroPrefix();
    return "${offset.isNegative ? '-' : '+'}$hours:$minutes";
  }
}
