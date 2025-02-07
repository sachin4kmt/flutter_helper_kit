import 'package:flutter/material.dart';

/// Color Extensions
extension Hex on Color {
  /// Converts the Flutter color to a hex string.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.red;
  /// String hexString = color.toHex();
  /// print('Hex Color: $hexString'); // Output: #FF0000
  /// ```
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? a.toInt().toRadixString(16).padLeft(2, '0') : ''}'
      '${r.toInt().toRadixString(16).padLeft(2, '0')}'
      '${g.toInt().toRadixString(16).padLeft(2, '0')}'
      '${b.toInt().toRadixString(16).padLeft(2, '0')}';

  /// Returns a color with the given opacity (which ranges from 0.0 to 1.0).
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// Color newColor = color.withColorOpacity(0.5);
  /// print(newColor); // Output: Color(0x800000ff)
  /// ```
  Color withColorOpacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    // ignore: unnecessary_this
    return this.withValues(
        alpha: value, red: r, blue: b, green: g, colorSpace: colorSpace);
  }

  /// Returns `true` if the color is dark, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// bool isDark = color.isDark;
  /// print('Is Dark: $isDark'); // Output: false
  /// ```
  bool isDark() => getBrightness() < 128.0;

  /// Returns `true` if the color is light, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// bool isLight = color.isLight;
  /// print('Is Light: $isLight'); // Output: true
  /// ```
  bool isLight() => !isDark();

  /// Returns the brightness of the color.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// double brightness = color.getBrightness;
  /// print('Brightness: $brightness'); // Output: 110.622
  /// ```
  double getBrightness() => (r * 299 + g * 587 + b * 114) / 1000;

  /// Returns the luminance of the color.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// double luminance = color.getLuminance;
  /// print('Luminance: $luminance'); // Output: 0.2126
  /// ```
  double getLuminance() => computeLuminance();

  /// Creates a MaterialColor from the color.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// MaterialColor materialColor = color.createMaterialColor();
  /// print('Material Color: $materialColor'); // Output: MaterialColor(primary value: 428051,
  ///                                           //   {50: Color(0xffe3f2fd), 100: Color(0xffbbdefb),
  ///                                           //   200: Color(0xff90caf9), 300: Color(0xff64b5f6),
  ///                                           //   400: Color(0xff42a5f5), 500: Color(0xff2196f3),
  ///                                           //   600: Color(0xff1e88e5), 700: Color(0xff1976d2),
  ///                                           //   800: Color(0xff1565c0), 900: Color(0xff0d47a1)});
  /// ```
  MaterialColor createMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int red = r.toInt(), green = g.toInt(), blue = b.toInt();

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        red + ((ds < 0 ? red : (255 - red)) * ds).round(),
        green + ((ds < 0 ? green : (255 - green)) * ds).round(),
        blue + ((ds < 0 ? blue : (255 - blue)) * ds).round(),
        1,
      );
    }
    return MaterialColor(red, swatch);
  }

  /// Lighten the color by [percentage] (0.0 to 1.0).
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// Color lightenedColor = color.lighten(0.2);
  /// print(lightenedColor); // Output: Color(0xff64b5f6)
  /// ```
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, 'Percentage must be between 0 and 1');

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  /// Darken the color by [percentage] (0.0 to 1.0).
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// Color darkenedColor = color.darken(0.2);
  /// print(darkenedColor); // Output: Color(0xff1976d2)
  /// ```
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, 'Percentage must be between 0 and 1');

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}

extension MaterialColorExtension on MaterialColor {
  /// Converts the Flutter color to a hex string.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.red;
  /// String hexString = color.toHex();
  /// print('Hex Color: $hexString'); // Output: #FF0000
  /// ```
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? a.toInt().toRadixString(16).padLeft(2, '0') : ''}'
      '${r.toInt().toRadixString(16).padLeft(2, '0')}'
      '${g.toInt().toRadixString(16).padLeft(2, '0')}'
      '${b.toInt().toRadixString(16).padLeft(2, '0')}';

  /// replaced with the given `opacity` (which ranges from 0.0 to 1.0).
  Color withColorOpacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    return withValues(
        alpha: value, red: r, blue: b, green: g, colorSpace: colorSpace);
  }

  /// Returns `true` if the color is dark, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// bool isDark = color.isDark;
  /// print('Is Dark: $isDark'); // Output: false
  /// ```
  bool isDark() => getBrightness() < 128.0;

  /// Returns `true` if the color is light, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// bool isLight = color.isLight;
  /// print('Is Light: $isLight'); // Output: true
  /// ```
  bool isLight() => !isDark();

  /// Returns the brightness of the color.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// double brightness = color.getBrightness;
  /// print('Brightness: $brightness'); // Output: 110.622
  /// ```
  double getBrightness() => (r * 299 + g * 587 + b * 114) / 1000;

  /// Returns the luminance of the color.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// double luminance = color.getLuminance;
  /// print('Luminance: $luminance'); // Output: 0.2126
  /// ```
  double getLuminance() => computeLuminance();

  /// Creates a MaterialColor from the color.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// MaterialColor materialColor = color.createMaterialColor();
  /// print('Material Color: $materialColor'); // Output: MaterialColor(primary value: 428051,
  ///                                           //   {50: Color(0xffe3f2fd), 100: Color(0xffbbdefb),
  ///                                           //   200: Color(0xff90caf9), 300: Color(0xff64b5f6),
  ///                                           //   400: Color(0xff42a5f5), 500: Color(0xff2196f3),
  ///                                           //   600: Color(0xff1e88e5), 700: Color(0xff1976d2),
  ///                                           //   800: Color(0xff1565c0), 900: Color(0xff0d47a1)});
  /// ```
  MaterialColor createMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int red = r.toInt(), green = g.toInt(), blue = b.toInt();

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        red + ((ds < 0 ? red : (255 - red)) * ds).round(),
        green + ((ds < 0 ? green : (255 - green)) * ds).round(),
        blue + ((ds < 0 ? blue : (255 - blue)) * ds).round(),
        1,
      );
    }
    return MaterialColor(red, swatch);
  }

  /// Lightens the color by the given [amount] (0.0 to 1.0).
  ///
  /// This method adjusts the lightness of the color by the specified amount,
  /// making it lighter. The [amount] should be between 0.0 (no change) and 1.0
  /// (maximum lightening). The lightness is clamped between 0.0 and 1.0 to
  /// ensure valid color values.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// Color lightenedColor = color.lighten(0.2);
  /// print(lightenedColor); // Output: Color(0xff64b5f6) (lighter shade of blue)
  /// ```
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, 'Percentage must be between 0 and 1');

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  /// Darkens the color by the given [amount] (0.0 to 1.0).
  ///
  /// This method adjusts the lightness of the color by the specified amount,
  /// making it darker. The [amount] should be between 0.0 (no change) and 1.0
  /// (maximum darkening). The lightness is clamped between 0.0 and 1.0 to
  /// ensure valid color values.
  ///
  /// Example:
  /// ```dart
  /// Color color = Colors.blue;
  /// Color darkenedColor = color.darken(0.2);
  /// print(darkenedColor); // Output: Color(0xff1976d2) (darker shade of blue)
  /// ```
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, 'Percentage must be between 0 and 1');

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
