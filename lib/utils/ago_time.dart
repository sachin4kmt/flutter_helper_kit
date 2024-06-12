part of flutter_helper_kit;

/// Formats provided [date] to a fuzzy time like 'a moment ago'
///
/// - If [locale] is passed will look for message for that locale, if you want
///   to add or override locales use [setLocaleMessages]. Defaults to 'en'
/// - If [clock] is passed this will be the point of reference for calculating
///   the elapsed time. Defaults to DateTime.now()
/// - If [allowFromNow] is passed, format will use the From prefix, ie. a date
///   5 minutes from now in 'en' locale will display as "5 minutes from now"

String
timeAgoCalculated(DateTime date,
    {DateTime? clock, bool allowFromNow = false,bool inHindi=false}) {
  if (kDebugMode) {
    print(date.toString());
  }

  final tempAllowFromNow = allowFromNow;
  LookupMessages messages=_EnMessages() ;
  if(inHindi){
     messages = HiMessages();
  }
  final tempClock = clock ?? DateTime.now();
  var elapsed = tempClock.millisecondsSinceEpoch - date.millisecondsSinceEpoch;

  String prefix, suffix;

  if (tempAllowFromNow && elapsed < 0) {
    elapsed = date.isBefore(tempClock) ? elapsed : elapsed.abs();
    prefix = messages.prefixFromNow();
    suffix = messages.suffixFromNow();
  } else {
    prefix = messages.prefixAgo();
    suffix = messages.suffixAgo();
  }

  final num seconds = elapsed / 1000;
  final num minutes = seconds / 60;
  final num hours = minutes / 60;
  final num days = hours / 24;
  final num months = days / 30;
  final num years = days / 365;

  String result;
  if (seconds < 45) {
    result = messages.lessThanOneMinute(seconds.round());
  } else if (seconds < 90) {
    result = messages.aboutAMinute(minutes.round());
  } else if (minutes < 45) {
    result = messages.minutes(minutes.round());
  } else if (minutes < 90) {
    result = messages.aboutAnHour(minutes.round());
  } else if (hours < 24) {
    result = messages.hours(hours.round());
  } else if (hours < 48) {
    result = messages.aDay(hours.round());
  } else if (days < 30) {
    result = messages.days(days.round());
  } else if (days < 60) {
    result = messages.aboutAMonth(days.round());
  } else if (days < 365) {
    result = messages.months(months.round());
  } else if (years < 2) {
    result = messages.aboutAYear(months.round());
  } else {
    result = messages.years(years.round());
  }

  return [prefix, result, suffix]
      .where((str) => str.isNotEmpty)
      .join(messages.wordSeparator());
}

class _EnMessages  implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => 'ago';

  @override
  String suffixFromNow() => 'from now';

  @override
  String lessThanOneMinute(int seconds) => 'a moment';

  @override
  String aboutAMinute(int minutes) => 'a minute';

  @override
  String minutes(int minutes) => '$minutes minutes';

  @override
  String aboutAnHour(int minutes) => 'about an hour';

  @override
  String hours(int hours) => '$hours hours';

  @override
  String aDay(int hours) => 'a day';

  @override
  String days(int days) => '$days days';

  @override
  String aboutAMonth(int days) => 'about a month';

  @override
  String months(int months) => '$months months';

  @override
  String aboutAYear(int year) => 'about a year';

  @override
  String years(int years) => '$years years';

  @override
  String wordSeparator() => ' ';
}

class HiMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => 'पूर्व';

  @override
  String suffixFromNow() => 'अब से';

  @override
  String lessThanOneMinute(int seconds) => 'एक क्षण पहले';

  @override
  String aboutAMinute(int minutes) => 'एक मिनट पहले';

  @override
  String minutes(int minutes) => '$minutes मिनट';

  @override
  String aboutAnHour(int minutes) => 'करीब एक घंटा';

  @override
  String hours(int hours) => '$hours घंटे';

  @override
  String aDay(int hours) => 'एक दिन पहले';

  @override
  String days(int days) => '$days दिन';

  @override
  String aboutAMonth(int days) => 'तक़रीबन एक महीना';

  @override
  String months(int months) => '$months महीने';

  @override
  String aboutAYear(int year) => 'एक साल पहले';

  @override
  String years(int years) => '$years वर्षों पहले';

  @override
  String wordSeparator() => ' ';
}

abstract class LookupMessages {
  /// Example: `prefixAgo()` 1 min `suffixAgo()`
  String prefixAgo();

  /// Example: `prefixFromNow()` 1 min `suffixFromNow()`
  String prefixFromNow();

  /// Example: `prefixAgo()` 1 min `suffixAgo()`
  String suffixAgo();

  /// Example: `prefixFromNow()` 1 min `suffixFromNow()`
  String suffixFromNow();

  /// Format when time is less than a minute
  String lessThanOneMinute(int seconds);

  /// Format when time is about a minute
  String aboutAMinute(int minutes);

  /// Format when time is in minutes
  String minutes(int minutes);

  /// Format when time is about an hour
  String aboutAnHour(int minutes);

  /// Format when time is in hours
  String hours(int hours);

  /// Format when time is a day
  String aDay(int hours);

  /// Format when time is in days
  String days(int days);

  /// Format when time is about a month
  String aboutAMonth(int days);

  /// Format when time is in months
  String months(int months);

  /// Format when time is about a year
  String aboutAYear(int year);

  /// Format when time is about a year
  String years(int years);

  /// word separator when words are concatenated
  String wordSeparator() => ' ';
}
