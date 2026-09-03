import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/color/color_extension.dart';
import 'package:flutter_helper_kit/extensions/map/map_extension.dart';
import 'package:flutter_helper_kit/extensions/string/string_extension.dart';

/// Avatar container shape.
enum AvatarShape {
  circle,
  rounded,
  square,
}

/// How initials are derived from [TextAvatar.text].
enum InitialsMode {
  /// First letter of each word: `John Doe` → `JD`
  words,

  /// First two characters: `Flutter` → `FL`
  firstTwo,

  /// First character only: `Flutter` → `F`
  firstOne,

  /// Uses [TextAvatar.initialsBuilder].
  custom,
}

/// Resolved background + text colors from a single seed color.
@immutable
class TextAvatarColors {
  const TextAvatarColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;

  factory TextAvatarColors.fromSeed(
    Color seed, {
    double backgroundOpacity = 0.2,
    double textOpacity = 1.0,
  }) {
    return TextAvatarColors(
      background: seed.withColorOpacity(backgroundOpacity),
      foreground: seed.withColorOpacity(textOpacity),
    );
  }
}

/// Default letter → seed color palette.
const Map<String, Color> textAvatarColorData = {
  'a': Color.fromRGBO(226, 95, 81, 1),
  'b': Color.fromRGBO(242, 96, 145, 1),
  'c': Color.fromRGBO(187, 101, 202, 1),
  'd': Color.fromRGBO(149, 114, 207, 1),
  'e': Color.fromRGBO(120, 132, 205, 1),
  'f': Color.fromRGBO(91, 149, 249, 1),
  'g': Color.fromRGBO(72, 194, 249, 1),
  'h': Color.fromRGBO(69, 208, 226, 1),
  'i': Color.fromRGBO(38, 166, 154, 1),
  'j': Color.fromRGBO(82, 188, 137, 1),
  'k': Color.fromRGBO(155, 206, 95, 1),
  'l': Color.fromRGBO(212, 227, 74, 1),
  'm': Color.fromRGBO(254, 218, 16, 1),
  'n': Color.fromRGBO(247, 192, 0, 1),
  'o': Color.fromRGBO(255, 168, 0, 1),
  'p': Color.fromRGBO(255, 138, 96, 1),
  'q': Color.fromRGBO(194, 194, 194, 1),
  'r': Color.fromRGBO(143, 164, 175, 1),
  's': Color.fromRGBO(162, 136, 126, 1),
  't': Color.fromRGBO(163, 163, 163, 1),
  'u': Color.fromRGBO(175, 181, 226, 1),
  'v': Color.fromRGBO(179, 155, 221, 1),
  'w': Color.fromRGBO(194, 194, 194, 1),
  'x': Color.fromRGBO(124, 222, 235, 1),
  'y': Color.fromRGBO(188, 170, 164, 1),
  'z': Color.fromRGBO(173, 214, 125, 1),
};

/// Stable fallback when no palette match exists.
Color textAvatarHashColor(String input) {
  if (input.isEmptyOrNull) return Colors.grey;
  final hue = input.hashCode.abs() % 360;
  return HSLColor.fromAHSL(1, hue.toDouble(), 0.55, 0.48).toColor();
}

String _firstAlphabet(String value) {
  for (var i = 0; i < value.length; i++) {
    if (value[i].isAlphabetOnly()) return value[i];
  }
  return '';
}

String resolveTextAvatarInitials(
  String text, {
  InitialsMode mode = InitialsMode.words,
  int maxInitials = 2,
  String Function(String name)? initialsBuilder,
}) {
  final trimmed = text.validate().trim();
  if (trimmed.isEmptyOrNull) return '';

  switch (mode) {
    case InitialsMode.custom:
      return initialsBuilder?.call(trimmed) ?? '';
    case InitialsMode.firstOne:
      return _firstAlphabet(trimmed);
    case InitialsMode.firstTwo:
      final buffer = StringBuffer();
      for (var i = 0; i < trimmed.length && buffer.length < 2; i++) {
        if (trimmed[i].isAlphabetOnly()) buffer.write(trimmed[i]);
      }
      return buffer.toString();
    case InitialsMode.words:
      final parts = trimmed.split(RegExp(r'\s+'));
      final buffer = StringBuffer();
      for (final part in parts) {
        if (buffer.length >= maxInitials) break;
        final letter = _firstAlphabet(part);
        if (letter.isNotEmpty) buffer.write(letter);
      }
      return buffer.toString();
  }
}

Color resolveTextAvatarSeedColor(
  String text,
  String initials, {
  Color? baseColor,
  Map<String, Color>? includeColor,
  Map<String, Color> palette = textAvatarColorData,
}) {
  if (baseColor != null) return baseColor;

  final paletteMap = includeColor.updateAndJoin(palette);
  final keySource = initials.isNotEmpty ? initials : text.trim();
  if (keySource.isEmptyOrNull) return Colors.grey;

  final key = _firstAlphabet(keySource).toLowerCase();
  if (key.isEmpty) return textAvatarHashColor(text);

  return paletteMap[key] ?? textAvatarHashColor(text);
}

/// A text avatar with auto initials and tinted colors.
///
/// Background uses [backgroundOpacity] of the seed color (default `0.2`).
/// Text uses [textOpacity] of the same seed color (default `1.0`).
class TextAvatar extends StatelessWidget {
  const TextAvatar({
    super.key,
    required this.text,
    this.size = 48,
    this.shape = AvatarShape.circle,
    this.borderRadius,
    this.maxInitials = 2,
    this.initialsMode = InitialsMode.words,
    this.initialsBuilder,
    this.baseColor,
    this.includeColor,
    this.backgroundOpacity = 0.2,
    this.textOpacity = 1.0,
    this.upperCase = true,
    this.autoFontSize = true,
    this.style,
    @Deprecated('Use baseColor with backgroundOpacity instead')
    this.backgroundColor,
    @Deprecated('Use shape and borderRadius instead') this.radius,
  });

  final String text;
  final double size;
  final AvatarShape shape;
  final double? borderRadius;
  final int maxInitials;
  final InitialsMode initialsMode;
  final String Function(String name)? initialsBuilder;
  final Color? baseColor;
  final Map<String, Color>? includeColor;
  final double backgroundOpacity;
  final double textOpacity;
  final bool upperCase;
  final bool autoFontSize;
  final TextStyle? style;

  @Deprecated('Use baseColor with backgroundOpacity instead')
  final Color? backgroundColor;

  @Deprecated('Use shape and borderRadius instead')
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final initialsRaw = resolveTextAvatarInitials(
      text,
      mode: initialsMode,
      maxInitials: maxInitials,
      initialsBuilder: initialsBuilder,
    );

    final displayText =
        upperCase ? initialsRaw.toUpperCase() : initialsRaw.toLowerCase();

    final seed = backgroundColor ??
        resolveTextAvatarSeedColor(
          text,
          initialsRaw,
          baseColor: baseColor,
          includeColor: includeColor,
        );

    final colors = TextAvatarColors.fromSeed(
      seed,
      backgroundOpacity: backgroundOpacity,
      textOpacity: textOpacity,
    );

    final fontSize = autoFontSize ? size * 0.38 : (style?.fontSize ?? 16);

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: _decoration(colors.background),
        child: Center(
          child: Text(
            displayText,
            maxLines: 1,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: (style ?? const TextStyle()).copyWith(
              color: colors.foreground,
              fontSize: fontSize,
              fontWeight: style?.fontWeight ?? FontWeight.w600,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration(Color bg) {
    if (shape == AvatarShape.circle) {
      return BoxDecoration(color: bg, shape: BoxShape.circle);
    }

    if (shape == AvatarShape.square) {
      return BoxDecoration(color: bg);
    }

    return BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(
        radius ?? borderRadius ?? size * 0.22,
      ),
    );
  }
}
