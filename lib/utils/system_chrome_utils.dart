import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// Sets the status bar color and optional system navigation bar color.
///
/// This function updates the **status bar color, icon brightness, and navigation bar color** dynamically.
///
/// - [statusBarColor] → The color of the status bar.
/// - [systemNavigationBarColor] (optional) → The color of the navigation bar.
/// - [statusBarBrightness] (optional) → Defines whether the status bar icons are dark/light.
/// - [statusBarIconBrightness] (optional) → Manually set the brightness of status bar icons.
/// - [delayInMilliSeconds] → Delays the update (default: **200ms**) to ensure smooth UI transitions.
///
/// Example Usage:
/// ```dart
/// setStatusBarColor(
///   Colors.red,
///   systemNavigationBarColor: Colors.black,
///   statusBarBrightness: Brightness.dark,
/// );
/// ```
Future<void> setStatusBarColor(
  Color statusBarColor, {
  Color? systemNavigationBarColor,
  Brightness? statusBarBrightness,
  Brightness? statusBarIconBrightness,
  int delayInMilliSeconds = 200,
}) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ??
          (statusBarColor.isDark() ? Brightness.light : Brightness.dark),
    ),
  );
}

/// Configures the system UI for a **dark-themed status bar** and navigation bar.
///
/// - **Navigation Bar** → Sets to **black** with **light icons**.
/// - **Status Bar** → Transparent with **dark icons**.
/// - **Brightness Adjustments**:
///   - `statusBarBrightness: Brightness.light` (for better contrast)
///   - `statusBarIconBrightness: Brightness.dark` (for visibility)
///
/// Example Usage:
/// ```dart
/// setDarkStatusBar();
/// ```
void setDarkStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

/// Configures the system UI for a **light-themed status bar** and navigation bar.
///
/// - **Navigation Bar** → Sets to **white** with **dark icons**.
/// - **Status Bar** → Transparent with **light icons**.
/// - **Brightness Adjustments**:
///   - `statusBarBrightness: Brightness.dark` (for better contrast)
///   - `statusBarIconBrightness: Brightness.light` (for visibility)
///
/// Example Usage:
/// ```dart
/// setLightStatusBar();
/// ```
void setLightStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
}

/// Hides both the **status bar** and **navigation bar**, making the app fullscreen.
///
/// - Best for **immersive experiences** like video players and games.
/// - To restore, use `showStatusBar()`.
///
/// ### Example Usage:
/// ```dart
/// hideStatusBar();
/// ```
Future<void> hideStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

/// Restores the **status bar and navigation bar** visibility.
///
/// - ✅ Enables **both overlays** (status bar + navigation bar).
/// - ✅ Works after using **SystemUiMode.immersive**.
/// - ✅ Call this method when you need to **show system UI again**.
///
/// ### Example Usage:
/// ```dart
/// await showStatusBar();
/// ```
Future<void> showStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
}

/// Locks the screen orientation to **portrait mode**.
///
/// - Allows only **portraitUp** and **portraitDown**.
/// - Useful for **social apps, messaging apps, or reading content**.
///
/// ### Example Usage:
/// ```dart
/// setOrientationPortrait();
/// ```
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Locks the screen orientation to **landscape mode**.
///
/// - Allows only **landscapeRight** and **landscapeLeft**.
/// - Useful for **gaming apps, video players, and drawing apps**.
///
/// ### Example Usage:
/// ```dart
/// setOrientationLandscape();
/// ```
void setOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
