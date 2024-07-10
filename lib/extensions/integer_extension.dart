
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/string_extension.dart';
import 'package:flutter_helper_kit/widgets/space/space.dart';

/// int Extensions
extension IntNullableExtensions on int? {
  /// Checks if the given String [s] is null or empty
  bool get isEmptyOrNull => this == null;

  /// Leaves given height of space
  Widget get height => SizedBox(height: validate().toDouble());

  /// Leaves given width of space
  Widget get width => SizedBox(width: validate().toDouble());

  /// This extension provides a method to convert a nullable int value to a Widget that
  /// takes a fixed amount of space in the direction of its parent.
  Widget get space => Space(validate().toDouble());

  /// A widget that takes, at most, an amount of space in a [Row], [Column],or [Flex] widget.
  /// The `maxSpace` property converts the integer value to a [MaxSpace] widget,
  /// which is useful for creating flexible layouts where certain elements
  /// need to occupy a specific amount of space.
  Widget get maxSpace => MaxSpace(validate().toDouble());

  /// This extension provides a way to handle nullable integers and use them to create
  /// a space widget. It validates the nullable integer, converting it to a non-nullable
  /// double, and uses it to create a space widget that expands in the cross axis direction.
  Widget get spaceExpand => Space.expand(validate().toDouble());

  /// Returns microseconds duration
  /// 5.microseconds
  Duration get microseconds => Duration(microseconds: validate());

  /// Returns milliseconds duration
  /// ```dart
  /// 5.milliseconds
  /// ```
  Duration get milliseconds => Duration(milliseconds: validate());

  /// Returns seconds duration
  /// ```dart
  /// 5.seconds
  /// ```
  Duration get seconds => Duration(seconds: validate());

  /// Returns minutes duration
  /// ```dart
  /// 5.minutes
  /// ```
  Duration get minutes => Duration(minutes: validate());

  /// Returns hours duration
  /// ```dart
  /// 5.hours
  /// ```
  Duration get hours => Duration(hours: validate());

  /// Returns days duration
  /// ```dart
  /// 5.days
  /// ```
  Duration get days => Duration(days: validate());

  /// Returns month duration
  /// ```dart
  /// 5.weeks
  /// ```
  Duration get weeks => Duration(days: validate() * 7);

  /// Returns month duration
  /// ```dart
  /// 5.months
  /// ```
  Duration get month => Duration(days: (validate() * 30));

  /// Returns years duration
  /// ```dart
  /// 5.years
  /// ```
  Duration get years => Duration(days: (validate() * 365));

  /// Returns Size
  Size get size => Size(validate().toDouble(), validate().toDouble());

  /// Returns Radius
  /// ```dart
  /// 5.circularRadius
  /// ```
  BorderRadius get circularBorderRadius =>
      BorderRadius.circular(validate().toDouble());

  /// Returns true if the value is `1`
  /// otherwise false is returned.
  bool toBool([int value = 1]) => this == value ? true : false;

  /// Validate given int is not null and returns given value if null.
  int validate({int value = 0}) => this ?? value;

  /// Validate given int is not null and returns given value if null.
  String? get addZeroPrefix {
    if (isEmptyOrNull) {
      return null;
    }
    if ((this ?? 0) < 10) {
      return '0$this';
    } else {
      return toString();
    }
  }

  /// get last charts of give value
  /// 'I  like dart language'.lastChars(13) // dart language
  int lastDigits(int n) {
    if (isEmptyOrNull) return 0;
    int charCount = n;
    if (toString().trim().length < n) {
      charCount = toString().trim().length;
    }
    return (toString().trim().substring(toString().trim().length - charCount))
            .toInt ??
        0;
  }
}

extension IntExtensions on int {
  /// returns month name from the given int value between [1-12]
  String toMonthName({bool isHalfName = false}) {
    assert(this >= 1 && this <= 12);
    String status = 'Invalid month of year';
    if (!(this >= 1 && this <= 12)) {
      throw Exception(status);
    }
    return switch(this){
      (DateTime.january)=>isHalfName ? 'Jan' : 'January',
      (DateTime.february)=>isHalfName ? 'Feb' : 'February',
      (DateTime.march)=>isHalfName ? 'Mar' : 'March',
      (DateTime.april)=>isHalfName ? 'Apr' : 'April',
      (DateTime.may)=>isHalfName ? 'May' : 'May',
      (DateTime.june)=>isHalfName ? 'Jun' : 'June',
      (DateTime.july)=>isHalfName ? 'Jul' : 'July',
      (DateTime.august)=>isHalfName ? 'Aug' : 'August',
      (DateTime.september)=>isHalfName ? 'Sept' : 'September',
      (DateTime.october)=>isHalfName ? 'Oct' : 'October',
      (DateTime.november)=>isHalfName ? 'Nov' : 'November',
      (DateTime.december)=>isHalfName ? 'Dec' : 'December',
      (_)=>"",
    };
  }

  /// returns WeekDay from the given int value [1-7]
  String toWeekDay({bool isHalfName = false}) {
    assert(this >= 1 && this <= 7);
    return switch (this) {
      (DateTime.monday) => isHalfName ? "Mon" : "Monday",
      (DateTime.tuesday) => isHalfName ? "Tue" : "Tuesday",
      (DateTime.wednesday) => isHalfName ? "Wed" : "Wednesday",
      (DateTime.thursday) => isHalfName ? "Thu" : "Thursday",
      (DateTime.friday) => isHalfName ? "Fri" : "Friday",
      (DateTime.saturday) => isHalfName ? "Sat" : "Saturday",
      (DateTime.sunday) => isHalfName ? "Sun" : "Sunday",
      (_) => "",
    };
  }
}
