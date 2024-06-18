import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/number_extension.dart';
import 'package:flutter_helper_kit/utils/common_functions.dart';
import 'package:flutter_helper_kit/utils/password_validator.dart';


extension NullStringExtension on String? {

  /// Check null string, return given value if null
  String validate([String value = ""]) =>
      this?.trim().isEmptyOrNull ?? true ? value : this!;

  /// Checks if the given String [s] is not null or empty
  bool get isNotEmptyOrNull => !isEmptyOrNull;

  /// Checks if the given String [s] is null or empty
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  /// If Given String [s] is Null return blank String
  String get defaultBlank => isEmptyOrNull ? "" : this!;

  ///check value is integer or not and return true or false
  bool get isInt => isEmptyOrNull ? false : int.tryParse(this!) != null;

  ///convert value in Int
  int? get toInt => isNotEmptyOrNull ? int.tryParse(this!) : null;

  ///check value is Number or not and return true or false
  bool get isNumber => isEmptyOrNull ? false : num.tryParse(this!) != null;

  ///convert value in Number
  num? get toNumber => isNotEmptyOrNull ? num.tryParse(this!) : null;

  ///check this string value convertible in [DateTime] or not
  bool get isDateTime =>
      isNotEmptyOrNull ? DateTime.tryParse(this!) != null : false;

  ///Date format give as api utc time example 2023-04-28T05:34:53.684Z
  DateTime? get toDateTime =>
      isNotEmptyOrNull ? DateTime.tryParse(this!) : null;

  ///check this string value convertible in double or not
  bool get isDouble => isEmptyOrNull ? false : double.tryParse(this!) != null;

  ///convert value in  Double
  double? get toDouble => isNotEmptyOrNull ? double.tryParse(this!) : null;

  ///get characters length of [String]
  int get toLength => validate().length;

  /// Check phone validation
  bool get validatePhone =>
      isEmptyOrNull ? false : hasMatch(this, r'(^[0-9]{8,12}$)');

  /// Check phone validation with country code
  bool get validatePhoneWithCountryCode =>
      isEmptyOrNull ? false : hasMatch(this, r'(^(?:[+0]9)?[0-9]{10,12}$)');

  /// Checks whether the given string is a valid email address or not
  bool get isValidateEmail {
    if (isEmptyOrNull) return false;
    const emailRegex =
        '^([\\w\\d\\-\\+]+)(\\.+[\\w\\d\\-\\+%]+)*@([\\w\\-]+\\.){1,5}(([A-Za-z]){2,30}|xn--[A-Za-z0-9]{1,26})\$';
    var regExp = RegExp(emailRegex);
    return regExp.hasMatch(this!.toLowerCase().trim());
  }

  /// Checks whether the given string contains a single letter or not and return [True] if contains otherwise return [False]
  bool get isContainsAlphabetLetter {
    if (isEmptyOrNull) return false;
    RegExp isLetterRegExp = RegExp(r'[A-Za-z]', caseSensitive: false);
    return isLetterRegExp.hasMatch(this!);
  }


  /// Returns `true` if string contains only alphabet symbols
  bool get isAlphabetOnly =>
      !isEmptyOrNull ? RegExp(r'^[a-zA-Z]+$').hasMatch(this!) : false;

  /// Removes all whitespaces from string
  String get removeAllWhiteSpace =>
      !isEmptyOrNull ? this!.replaceAll(RegExp(r'\s+\b|\b\s'), '') : "";

  /// Returns the reversed string
  String get reversed =>
      !isEmptyOrNull ? String.fromCharCodes(this!.codeUnits.reversed) : "";

  ///Check characters is start with [String]
  ///Default All [String] convert in lower case
  bool startsWithCharacters(String characters,{bool matchCase = false}) {
    if (characters.isEmpty || isEmptyOrNull) {
      return false;
    }
    if(matchCase){
      return this!.startsWith(characters);

    }
    return this!.toLowerCase().startsWith(characters.toLowerCase());
  }

  /// Check URL validation
  bool get validateURL => hasMatch(this,
      r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)');

  /// Returns string with capitalized first letter
  /// Example: assert('test'.capitalizeFirstCharacter(), 'Test');
  String get capitalizeFirstCharacter =>
      !isEmptyOrNull ? '${this![0].toUpperCase()}${this!.substring(1)}' : "";

  /// 'I like dart language'.capitalizeEachWordFirstCharacter() // I Like Dart Language
  /// 'I  like dart   language'.capitalizeEachWordFirstCharacter() // I  Like Dart   Language
  String get capitalizeEachWordFirstCharacter {
    if (isEmptyOrNull) return '';
    final words = this!.split(' ');
    final formatted = words.map((e) => e.capitalizeFirstCharacter).toList();
    return formatted.join(' ');
  }

  /// get last charts of give value
  /// 'I  like dart language'.lastChars(13) // dart language
  String lastChars(int n) {
    if (isEmptyOrNull) return '';
    int charCount = n;
    if(this!.length<n){
      charCount =this!.length;
    }
    return this!.trim().substring(this!.length - charCount);
  }

  /// Check if string is json decodable or not
  bool get isJsonDecodable {
    if (isEmptyOrNull) return false;
    try {
      jsonDecode(this!) as Map<String, dynamic>;
      // jsonDecode(this!);
      // ignore: unused_catch_clause
    } on FormatException catch (e) {
      return false;
    }
    return true;
  }

  /// return words first letter of given string
  String toWordsFirstCharacters(
      {int? numberOfCharacters, String splitBy = "\\s+"}) {
    var initials = "";
    if (validate().isEmptyOrNull) {
      return '';
    }
    final nameParts = this!.trim().toUpperCase().split(RegExp(splitBy));
    var num = math.min(nameParts.length, numberOfCharacters??nameParts.length);
    for (var i = 0; i < num; i++) {
      initials += nameParts[i][0];
    }
    return initials;
  }

  /// Returns a string first Characters.
  String take(int numberOfCharacters) {
    if (isEmptyOrNull) return '';
    var num = math.min(this!.characters.length, numberOfCharacters);
    return this!.trim().characters.take(num).join();
  }

  /// Returns a string abbreviation.
  int get countWords {
    if (validate().isEmptyOrNull) return 0;
    return this!.split(RegExp("\\s+")).length;
  }

  /// default minimum value 6
  ///check password give true and false
  bool isPasswordValidator(
      {int minLength = 6,
      int uppercaseCharCount = 0,
      int lowercaseCharCount = 0,
      int numericCharCount = 0,
      int specialCharCount = 0}) {
    if (isEmptyOrNull) return false;
    if (this!.contains(" ")) return false;
    if (minLength != 0 &&
        !Validator.hasMinimumLength(this!, minLength == 0 ? 6 : minLength)) {
      return false;
    }
    if (uppercaseCharCount != 0 &&
        !Validator.hasMinimumUppercase(this!, uppercaseCharCount)) {
      return false;
    }
    if (lowercaseCharCount != 0 &&
        !Validator.hasMinimumLowercase(this!, lowercaseCharCount)) {
      return false;
    }
    if (numericCharCount != 0 &&
        !Validator.hasMinimumNumericCharacters(this!, numericCharCount)) {
      return false;
    }
    if (specialCharCount != 0 &&
        !Validator.hasMinimumSpecialCharacters(this!, specialCharCount)) {
      return false;
    }
    return true;
  }


  String get generateRandomString => null.generateLoremIpsumWords;
}

