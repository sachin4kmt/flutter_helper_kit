## 1.2.2
* Fixed `GenericPickerSheet` debug assertion: sheet surface uses `Material` instead of `DecoratedBox` over `RadioListTile` / `CheckboxListTile` so ink and tile background render correctly.

## 1.2.1
* Fixed `LinearPercentIndicator` not painting when `center` is null (`CustomPaint` sized to `SizedBox.shrink()` → zero size). `CustomPaint` now expands via `SizedBox.expand` + `StackFit.expand`.
* Added `toCurrency` / `toCurrencyText` number extension.
* Reworked `TextAvatar` (shape, initials modes, tinted bg/text opacity).
* Added `durationMs` and `hz` to `animateWidgetErrorShake`.

## 1.2.0
* Added `flutter_percent_indicator` widgets: `CircularPercentIndicator`, `LinearPercentIndicator`, `MultiSegmentLinearIndicator`.
* Improved `SpaceMin` / `SpaceMax` scrollable support and layout tests.

## 1.1.0
* Added `FlutterTagPosition.topCenter` and `FlutterTagPosition.bottomCenter`.

## 1.0.10
* Added `SpaceMin` (min gap + optional max / expand) and renamed `MaxSpace` → `SpaceMax` (deprecated alias kept).
* Added `CircleContainer` circular layout widget.
* Added `DecimalTextInputFormatter` and `NonZeroFormatter`.
* Added `FlutterDateTime` cross-platform date/time pickers with min/max clamp fix for Cupertino.

## 1.0.9
* Added `FlutterTagAnimation.none` and `FlutterTagAnimationType.none` to disable tag animations.

## 1.0.8
* Synced from `flutter_helper_kit`: printf console, `GenericPickerSheet`, 79+ catalog demos, expanded tests.
* Preserved all live-only example code (`home.dart`, `MyCustomTextField`, standalone pagination).
* Added **Live Sandbox** catalog category; kept fixed `degreeToRadian` / `wait` in `flutter_helper_utils.dart`.

## 1.0.7
* fix : fix: core utils bugs

## 1.0.6
* Consolidated custom_helper modules (animation, responsive, widgets, extensions, utils).
* Added modular entry points: `flutter_helper_kit_extensions.dart`, `_widgets.dart`, `_animation.dart`, `_responsive.dart`, `_utils.dart`.
* Added `CallbackMapInfoWindowAdapter` for map info windows without extra dependencies.
* Renamed `PasswordStrength` string extension to `PasswordStrengthExtension` (enum conflict fix).
* Example catalog expanded to 44 demos with source-file mapping.
* Expanded test coverage and analyze warning fixes.

## 1.0.5
* Optimizations and fixes across core extensions.
* Standardized `SharpBorderRadius` parameter handling.
* Removed layout static analysis warnings.

## 1.0.4
* TODO: DateTimeFormatExtension implement

## 1.0.3
* TODO: analysis issue, improve score

## 1.0.2
* TODO: analysis issue, improve score

## 1.0.1
* TODO: analysis issue, improve score  

## 1.0.0
* TODO: New Widgets DottedBorderWidget, Change get methods and code analyze 

## 0.0.20
* TODO: String Extension Update

## 0.0.19
* TODO: Dart Format Update

## 0.0.18
* TODO: Example update Android Version

## 0.0.17
* TODO: improve pub score

## 0.0.16
* TODO: improve pub score

## 0.0.15
* TODO: improve pub score

## 0.0.14
* TODO: Change PopScope onPopInvoked to onPopInvokedWithResult

## 0.0.13
* TODO: unnecessary import remove.

## 0.0.12
* TODO: Update Readme File Documentation

## 0.0.11
* TODO: Update Readme File Documentation

## 0.0.10
* TODO: Add SharpBorder, FlutterTag, showDialogWithCloseIcon

## 0.0.9
* TODO: Add TapSafeGesture Widget

## 0.0.8
* TODO: dart format fix analyze issue

## 0.0.7
* TODO: add FlutterListView widget and Change ReadMe file..

## 0.0.6
* TODO: add FlutterListView widget.

## 0.0.5
* TODO: Update Readme Example Images Path.

## 0.0.4
* TODO: Update ReadMe file.

## 0.0.3
* TODO: Update ReadMe file.

## 0.0.2
* TODO: Change ReadMe file.

## 0.0.1
* TODO: Release this package init .

