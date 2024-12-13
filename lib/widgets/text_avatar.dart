import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/map_extension.dart';
import 'package:flutter_helper_kit/extensions/string_extension.dart';

/// A widget to display a text avatar with a background color.
///
/// The [TextAvatar] widget is used to display a circular avatar with a text inside it.
/// It automatically generates the background color based on the first letter of the provided text.
///

//ignore: must_be_immutable
class TextAvatar extends StatelessWidget {
  /// The radius of the circular avatar.
  double radius;

  /// The background color of the circular avatar.
  Color? backgroundColor;

  /// The size of the circular avatar.
  double size;

  /// The text to display inside the avatar.
  final String text;

  /// The text style of the text inside the avatar.
  final TextStyle? style;

  /// Whether to show the text in uppercase (default) or lowercase.
  final bool upperCase;

  /// A map of letters to custom background colors for the avatars.
  final Map<String, Color>? includeColor;

  /// Creates a [TextAvatar] widget with the given parameters.
  ///
  /// The [text] parameter is required and specifies the text to display inside the avatar.
  /// The [size] parameter specifies the size of the circular avatar.
  /// The [backgroundColor] parameter specifies the background color of the circular avatar.
  /// The [radius] parameter specifies the radius of the circular avatar.
  /// The [style] parameter specifies the text style of the text inside the avatar.
  /// The [upperCase] parameter specifies whether to show the text in uppercase (default) or lowercase.
  /// The [includeColor] parameter specifies a map of letters to custom background colors for the avatars.
  ///
  /// Example usage:
  /// ```dart
  /// TextAvatar(
  ///   text: 'John Doe',
  ///   size: 48.0,
  /// )
  /// ```
  TextAvatar({
    super.key,
    required this.text,
    this.backgroundColor,
    this.radius = 10,
    this.size = 48.0,
    this.style,
    this.includeColor,
    this.upperCase = true,
  });

  @override
  Widget build(BuildContext context) {
    backgroundColor ??= (colors[text.take(1).toLowerCase()] ?? Colors.grey);
    return Container(
      height: _size,
      width: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        _text(),
        style: style ?? const TextStyle(color: Colors.white, fontSize: 16),
        maxLines: 1,
      ),
    );
  }

  double get _size => (size < 32.0) ? 48.0 : size;

  String _text() =>
      upperCase ? getLetters().toUpperCase() : getLetters().toLowerCase();

  Map<String, Color> get colors => includeColor.updateAndJoin(colorData);

  String getLetters() {
    var initials = '';
    if (text.validate().isEmptyOrNull) {
      return '';
    }
    if (text.countWords() < 2) return text.take(2);
    final nameParts = text.trim().toUpperCase().split(RegExp('\\s+'));
    var num = math.min(nameParts.length, 2);
    for (var i = 0; i < num; i++) {
      if (nameParts[i].isAlphabetOnly() &&
          !nameParts[i].isContainsAlphabetLetter()) {
        initials += nameParts[i][0];
        break;
      }
      if (nameParts[i].isContainsAlphabetLetter()) {
        for (var k = 0; k < nameParts[i].length; k++) {
          if (nameParts[i][k].isAlphabetOnly()) {
            initials += nameParts[i][k];
            break;
          }
        }
      }
    }
    return initials;
  }
}

///Colors
var colorData = {
  'a': const Color.fromRGBO(226, 95, 81, 1),
  'b': const Color.fromRGBO(242, 96, 145, 1),
  'c': const Color.fromRGBO(187, 101, 202, 1),
  'd': const Color.fromRGBO(149, 114, 207, 1),
  'e': const Color.fromRGBO(120, 132, 205, 1),
  'f': const Color.fromRGBO(91, 149, 249, 1),
  'g': const Color.fromRGBO(72, 194, 249, 1),
  'h': const Color.fromRGBO(69, 208, 226, 1),
  'i': const Color.fromRGBO(38, 166, 154, 1),
  'j': const Color.fromRGBO(82, 188, 137, 1),
  'k': const Color.fromRGBO(155, 206, 95, 1),
  'l': const Color.fromRGBO(212, 227, 74, 1),
  'm': const Color.fromRGBO(254, 218, 16, 1),
  'n': const Color.fromRGBO(247, 192, 0, 1),
  'o': const Color.fromRGBO(255, 168, 0, 1),
  'p': const Color.fromRGBO(255, 138, 96, 1),
  'q': const Color.fromRGBO(194, 194, 194, 1),
  'r': const Color.fromRGBO(143, 164, 175, 1),
  's': const Color.fromRGBO(162, 136, 126, 1),
  't': const Color.fromRGBO(163, 163, 163, 1),
  'u': const Color.fromRGBO(175, 181, 226, 1),
  'v': const Color.fromRGBO(179, 155, 221, 1),
  'w': const Color.fromRGBO(194, 194, 194, 1),
  'x': const Color.fromRGBO(124, 222, 235, 1),
  'y': const Color.fromRGBO(188, 170, 164, 1),
  'z': const Color.fromRGBO(173, 214, 125, 1),
};
