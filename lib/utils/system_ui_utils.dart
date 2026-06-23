
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utility class to manage system UI (status bar, nav bar) appearance globally.
///
/// Works with both Android and iOS, and adapts icon colors automatically based on background color brightness.
///
/// Use this with GetX or globally in app entry points like `main.dart`, `BaseView`, etc.
class SystemUiUtils {
  /// 🔹 Set only the **status bar color**, with auto icon contrast.
  ///
  /// - Android:
  ///   - Applies background color to the status bar.
  ///   - Automatically sets **icon color** (black or white) based on brightness of the color.
  ///   - If `isTransparent` is true, makes status bar fully transparent.
  ///
  /// - iOS:
  ///   - Status bar is **always transparent**, so only icon brightness is affected.
  ///
  /// ⚠️ If you pass [Colors.white], icons will be **black**.
  /// ⚠️ If you pass [Colors.black], icons will be **white**.
  ///
  /// ```dart
  /// SystemUiUtils.setStatusBarColor(Colors.white);  // black icons on Android & iOS
  /// SystemUiUtils.setStatusBarColor(Colors.black);  // white icons on Android & iOS
  /// SystemUiUtils.setStatusBarColor(Colors.transparent, isTransparent: true);  // transparent with auto icon color
  /// ```
  static void setStatusBarColor(Color color, {bool isTransparent = false}) {
    final Brightness iconBrightness =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Brightness.light
        : Brightness.dark;

    final SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: isTransparent ? Colors.transparent : color,
      statusBarIconBrightness: iconBrightness, // Android
      statusBarBrightness: iconBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark, // iOS - inverted
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 🔹 Set **both status bar and navigation bar color**, with icon brightness adjustment.
  ///
  /// - Android:
  ///   - Sets both bars' background color and icon color.
  /// - iOS:
  ///   - Affects only status bar icon color (nav bar unaffected).
  ///
  /// ⚠️ Use [isTransparent] for full transparency (Android).
  ///
  /// ```dart
  /// SystemUiUtils.setSystemUI(Colors.deepPurple); // purple bars, white icons
  /// SystemUiUtils.setSystemUI(Colors.white);      // white bars, black icons
  /// SystemUiUtils.setSystemUI(Colors.transparent, isTransparent: true);
  /// ```
  static void setSystemUI(Color color, {bool isTransparent = false}) {
    final Brightness iconBrightness =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Brightness.light
        : Brightness.dark;

    final SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: isTransparent ? Colors.transparent : color,
      statusBarIconBrightness: iconBrightness,
      statusBarBrightness: iconBrightness,
      systemNavigationBarColor: isTransparent ? Colors.transparent : color,
      systemNavigationBarIconBrightness: iconBrightness,
    );

    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 🔹 Force a **transparent status bar**.
  ///
  /// - Android:
  ///   - Makes status bar background transparent.
  ///   - Uses [colorBehindStatusBar] to guess icon color for contrast.
  /// - iOS:
  ///   - Only sets icon brightness.
  ///
  /// Optionally force [forceBrightness] (e.g., `Brightness.light` → white icons).
  ///
  /// ```dart
  /// SystemUiUtils.setTransparentStatusBar(Colors.black); // transparent, white icons
  /// SystemUiUtils.setTransparentStatusBar(Colors.white); // transparent, black icons
  /// SystemUiUtils.setTransparentStatusBar(Colors.red, forceBrightness: Brightness.light);
  /// ```
  static void setTransparentStatusBar(
    Color colorBehindStatusBar, {
    Brightness? forceBrightness,
  }) {
    final Brightness iconBrightness =
        forceBrightness ??
        (ThemeData.estimateBrightnessForColor(colorBehindStatusBar) ==
                Brightness.dark
            ? Brightness.light
            : Brightness.dark);

    final SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: iconBrightness,
      statusBarBrightness: iconBrightness,
    );

    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 🔹 Reset system UI to match platform (system) theme.
  ///
  /// - Uses `MediaQuery.of(context).platformBrightness` to detect system theme (light/dark).
  /// - Useful for restoring after custom styles.
  ///
  /// ```dart
  /// SystemUiUtils.resetSystemUI(context);
  /// ```
  static void resetSystemUI(BuildContext context) {
    final Brightness platformBrightness = MediaQuery.of(
      context,
    ).platformBrightness;

    final SystemUiOverlayStyle style = platformBrightness == Brightness.dark
        ? SystemUiOverlayStyle
              .light // white icons
        : SystemUiOverlayStyle.dark; // black icons

    SystemChrome.setSystemUIOverlayStyle(style);
  }
}
