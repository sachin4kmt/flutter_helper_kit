import 'dart:math' as math;

import 'package:flutter_helper_kit/flutter_helper_kit.dart';


/// Num Extensions
extension NumExt on num? {
  /// Returns `true` if this nullable iterable is either `null` or empty.
  bool get isNullOrEmpty => this == null;



  /// Validate given double is not null and returns given value if null.
  num validate({num value = 0}) => this ?? value;

  /// Validate given double is not null and returns given value if null.
  num get validateNum => this ?? 0;

  /// Determines if [this] is between [a] and [b] whereas the bounds
  /// are inclusive.
  bool between(int min, int max) => validate() >= min && validate() <= max;

  // Returns price with currency
  // String toCurrencyAmount() => "$defaultCurrencySymbol${this.validate()}";

  /// Check if the number is in the range [min] to [max].
  /// Returns `true` if the number is in the range, `false` otherwise.
  bool isInRange(num min, num max) => (this ?? 0) >= min && (this ?? 0) <= max;

  /// Get the lorem ipsum text of [this] words.
  String get generateLoremIpsumWords {
    if (isNullOrEmpty) return "";
    var words =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            .split(" ");
    var result = '';
    for (var i = 0; i < (this ?? words.length); i++) {
      result += '${words[i % words.length]} ';
    }
    return result.trim();
  }

  /// Get list of random numbers.
  List<num> randomList({int min = 0, int max = 100}) {
    if (isNullOrEmpty) return [];
    var result = <num>[];
    for (var i = 0; i < (this ?? 0); i++) {
      result.add(math.Random().nextInt(max - min) + min);
    }
    return result;
  }

  /// Num value convert into numeral String Like 1K, 10K, 1M, 10M
  /// [international] is default [true] for international value =>  1k,2k,1m,2m
  /// [international] [false] for indian value => 1k,2k,1 L,2 L, 1 Cr
  String toNumeral({bool international = true, int digitAfterDecimal = 0}) {
    final value = Numeral(validateNum, digitAfterDecimal: digitAfterDecimal);
    return international?value.international:value.indian;
  }
}


