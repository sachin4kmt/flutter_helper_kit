
## Installation

Add this package to `pubspec.yaml` as follows:

```console
$ flutter pub add flutter_helper_kit
```

Import package

```dart
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
```

## Contents
- [Useful Methods](#useful-methods-or-extensions-you-will-ever-need)
- [Widgets](#widgets)
- [Extensions](#extensions)
  - [String Extensions](#string-extensions)
  - [bool Extensions](#bool-extensions)
  - [Color Extensions](#color-extensions)
  - [BuildContext Extensions](#buildcontext-extensions)
  - [DateTime Extensions](#datetime-extensions---utils)
  - [Device Extensions](#device-extensions)
  - [double Extensions](#double-extensions)
  - [Duration Extensions](#duration-extensions)
  - [int Extensions](#int-extensions)
  - [List Extensions](#list-extensions)
  - [num Extensions](#num-extensions)
  - [ScrollController Extensions](#scrollcontroller-extensions)
  - [Widget Extensions](#widget-extensions)
- [System Methods](#systems-methods)
- [System Methods](#systems-methods)
- [Network Utils](#network-utils)
- [JWT Decoder](#jwt-decoder)
- [Dialog](#show-dialogs)
- [Custom Dialogs](#custom-dialogs)

## Useful methods or extensions you will ever need
```dart
/// Toast 
AppButton(
onTap: () {
//The `FlutterToast` widget allows you to display customizable toast messages in your Flutter application.
FlutterToast.show('Flutter Helper Kit', context, position: FlutterToastPosition.bottom, duration: 500.milliseconds);
},
text: 'click'
),
```
[GIF](#flutter-toast)


## Widgets

```dart
/// Add a Google Logo
/// Add size parameter for custom size - Default is 24
GoogleLogoWidget()
```

```dart
AvatarGlow(
glowColor: Colors.cyan,
glowCount: 5,
startDelay: 2.seconds,
glowRadiusFactor: 2,
child: GoogleLogoWidget(),
),
```
[GIF](#avatar-glow)

```dart
OutlineAvatarGlow(
glowColor: Colors.cyan,
glowCount: 5,
startDelay: 2.seconds,
glowRadiusFactor: 2,
child: GoogleLogoWidget(),
),
```
[GIF](#outline-avatar-glow)


```dart
AvatarGlowMultiColor (
glowColors: [Colors.red,Colors.blue,Colors.red,Colors.green,Colors.yellow,],
startDelay: 2.seconds,
glowRadiusFactor: 2,
child: GoogleLogoWidget(),
),
```
[GIF](#avatar-glow-multicolor)


```dart[app_button.da  rt](..%2F..%2F..%2FAppData%2FLocal%2FTemp%2Fapp_button.dart)
OutlineAvatarGlowMultiColor (
glowColors: [Colors.red,Colors.blue,Colors.red,Colors.green,Colors.yellow,],
startDelay: 2.seconds,
glowRadiusFactor: 2,
child: GoogleLogoWidget(),
),
```
[GIF](#outline-avatar-glow-multicolor)

```dart
/// add a 'Space' inside a 'Column' or a 'Row' with the specified extent.
/// The 'MaxSpace' widget will try to fill the available space in a 'Column' or a Row 'with' the specified size. If the available space is lesser than the specified size, the MaxSpace widget will only take the available space.
Column(
children: <Widget>[
Container(color: Colors.red, height: 20),
const Gap(20), // Adds an empty space of 20 pixels.
Container(color: Colors.red, height: 20),
],
);

/// There is also a Sliver version of the `Space` widget:
CustomScrollView(
slivers: <Widget>[
const SliverGap(20), // Adds an empty space of 20 pixels.
],
);
```

```dart
AppButton(
onTap: () {},
text: 'Flutter Helper Kit',
shapeBorder: RoundedRectangleBorder(borderRadius: 16.circularBorderRadius),
color: Colors.blue,
textStyle: TextStyle(fontSize: 28),enabled: false,
)
```
[GIF](#app-button)

```dart
CustomIndicator(
isActive: true, //A boolean value that determines whether the overlay indicator is shown. If set to true, the overlay indicator is displayed. 
opacity: 0.6, //The value should be between 0.0 and 1.0, where 0.0 is fully transparent and 1.0 is fully opaque. In the example above, it is set to 0.6.
bgColor: Colors.grey,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('Screen1')
],
),
)
```

The `DashDivider` widget creates a dashed line divider in your Flutter application. It is customizable, allowing you to set the color, thickness, dash length, and gap length.
```dart
DashDivider()
```

```dart
DoublePressBackWidget(
child: AnyWidget(),
message: 'Your message' // Optional
),
```

```dart
//The `UnFocusable` widget is a simple utility that helps to unfocus text fields or other focusable widgets when a user taps outside of them. This is particularly useful for dismissing the keyboard when a user taps outside a `TextField`.
UnFocusable(
child: Scaffold(),
),
```

```dart
// The `Marquee` widget allows you to display its child in a scrolling manner, either horizontally or vertically. This widget is useful for creating scrolling text effects, such as news tickers or any other scrolling content.
//    - Scrolls its child widget horizontally or vertically.
//    - Supports continuous scrolling in one or two directions.
//    - Customizable animation durations and pause durations.
//    - Handles text direction for internationalization.

Marquee(
child: Text(
'Flutter Helper Kit example using the Marquee widget.',
style: TextStyle(fontSize: 24),
),
direction: Axis.horizontal,
textDirection: TextDirection.ltr,
animationDuration: Duration(milliseconds: 3000),
backDuration: Duration(milliseconds: 2000),
pauseDuration: Duration(milliseconds: 1000),
directionMarguee: DirectionMarguee.twoDirection,
)
```
[GIF](#marquee)

```dart
//The `RatingBarWidget` is a customizable rating bar widget for Flutter. It allows users to select a rating by tapping on icons. The widget supports half ratings, customizable icons, colors, and spacing between icons.
RatingBarWidget(
rating: 3.5,
onRatingChanged: (newRating) {
print('Rating changed: $newRating');
},
activeColor: Colors.yellow,
inActiveColor: Colors.grey,
size: 40,
allowHalfRating: true,
filledIconData: Icons.star,
halfFilledIconData: Icons.star_half,
defaultIconData: Icons.star_border,
spacing: 4.0,
disable: false,
)
```
[GIF](#ratingbar)

```dart
//The `ReadMoreText` widget allows you to display a portion of a long text and provide a "read more" link to expand the text. You can also collapse the text back with a "read less" link.
ReadMoreText(
'This is a very long text that needs to be trimmed.\nClick on the "read more" link to see the full text.\nClick on the "read less" link to collapse the text.',
trimLines: 2,
trimMode: TrimMode.line,
trimCollapsedText: '...read more',
trimExpandedText: ' read less',
style: TextStyle(color: Colors.black),
colorClickableText: Colors.blue,
textAlign: TextAlign.start,
),
```
[GIF](#read-more-text)












## Flutter Toast
![FlutterToast](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/flutetr_toast.gif)

## Avatar Glow
![AvatarGlow](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/avatar_glow.gif)

## Outline Avatar Glow
![OutlineAvatarGlow](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/avatar_glow_multi_color.gif)

## Avatar Glow MultiColor
![AvatarGlowMultiColor](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/outline_avatar_glow.gif)

## Outline Avatar Glow MultiColor
![OutlineAvatarGlowMultiColor](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/outline_avatar_glow_multi_color.gif)

## App Button
![AppButton](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/app_button.gif)

## Marquee
![Marquee](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/marquee.gif)

## RatingBar
![RatingBarWidget](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/rating_bar.gif)

## Read More Text
![ReadMoreText](https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/read_more.gif)

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/sachin4kmt/flutter_helper_kit/issues

## ⭐ If you like the package, a star to the repo will mean a lot.

## You can also contribute by adding new widgets or helpful methods.

## If you want to give suggestion, please contact me via email - sachin4kmt@gmail.com

## Thank you ❤ 