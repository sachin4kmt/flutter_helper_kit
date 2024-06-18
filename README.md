
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
  - [BuildContext Extensions](#build-context-extensions)
  - [DateTime Extensions](#datetime-extensions---utils)
  - [double Extensions](#double-extensions)
  - [Duration Extensions](#duration-extensions)
  - [int Extensions](#int-extensions)
  - [List Extensions](#list-extensions)
  - [num Extensions](#num-extensions)
  - [Widget Extensions](#widget-extensions)
  - [Widget Extensions](#widget-extensions)
  - [ScopeFunction Extensions](#scopefunction-extensions)
- [System Methods](#systems-methods)
- [Utils](#utils)
- [Typedefs for Callback Functions](#typedefs-for-callback-functions)

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


```dart
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
  message: 'Press back again to exit', // Optional
  onWillPop: () {
    print('Double press confirmed');
  },
  child: AnyWidget
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

```dart
RoundedCheckBox(
  isChecked: true,
  borderColor: Colors.grey,
  onTap: (isChecked) {
    print('Checkbox is now: $isChecked');
  },
  text: 'Accept Terms',
),
```
[Image](#rounded-check-box)

```dart
// To use the `SeparatedColumn` widget, simply wrap your children widgets with `SeparatedColumn` and provide a `separatorBuilder` to create the separators between the children.
SeparatedColumn(
  separatorBuilder: (BuildContext context, int index) => Container(height: 1, color: Colors.grey),
  children: const [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

```dart
//To use the `TextAvatar` widget, simply create an instance of it and provide the required parameters.
TextAvatar(
  text: 'Flutter Helper Kit',
)
```

```dart
TextIcon(
  text: 'Hello World',
  textStyle: TextStyle(color: Colors.blue, fontSize: 18),
  prefix: Icon(Icons.star, color: Colors.yellow),
  suffix: Icon(Icons.arrow_forward, color: Colors.red),
  spacing: 8,
  maxLine: 1,
  onTap: () {
    print('TextIcon tapped!');
  },
  edgeInsets: EdgeInsets.all(10),
  expandedText: true,
  useMarquee: false,
  boxDecoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
)
```
[Image](#text-icon)


```dart
// The `TimerBuilder` widget in Flutter allows you to rebuild your widget tree on specific and/or periodic timer events. It's highly customizable and can be used to create widgets that update at certain intervals or on a schedule.
//The example below shows how to use `TimerBuilder.periodic` to rebuild a widget every 5 seconds:
TimerBuilder.periodic(
  Duration(seconds: 5),
  builder: (context) {
  return Text(
      'Current Time: ${DateTime.now()}',
      style: TextStyle(fontSize: 20),
    );
  },
)

//The example below shows how to use TimerBuilder.scheduled to rebuild a widget at specific times:
TimerBuilder.scheduled(
  [
    DateTime.now().add(Duration(seconds: 10)),
    DateTime.now().add(Duration(seconds: 20)),
    DateTime.now().add(Duration(seconds: 30)),
  ],
  builder: (context) {
    return Text(
      'Current Time: ${DateTime.now()}',
      style: TextStyle(fontSize: 20),
    );
  },
),
```

```dart
//A new list of widgets where the divider is inserted between each pair of adjacent widgets in the input list.
List<Widget> interspersedItems = WidgetHelper.intersperse(
  items,
  Divider(color: Colors.black),
  leading: true,
  trailing: true,
);

//A new list of widgets where each object in the input list is mapped to a list of widgets using the provided mapping function.
List<Widget> mappedWidgets = WidgetHelper.widgetMap(
  items, (item) => [
    Text(item), 
    SizedBox(height: 10)
  ],
);
```

# Extensions
## String Extensions
```dart
bool get isNotEmptyOrNull
num? get toNumber
bool get isDateTime
DateTime? get toDateTime
bool get isDouble
double? get toDouble
int get toLength
bool get validatePhone
bool get validatePhoneWithCountryCode
bool get isValidateEmail
bool get isContainsAlphabetLetter
bool get isAlphabetOnly
String get removeAllWhiteSpace
String get reversed
bool get validateURL
String get capitalizeFirstCharacter
String get capitalizeEachWordFirstCharacter
bool get isJsonDecodable
int get countWords

String validate([String value = ""])
bool startsWithCharacters(String characters,{bool matchCase = false})
String lastChars(int n)
String toWordsFirstCharacters({int? numberOfCharacters, String splitBy = "\\s+"})
String take(int numberOfCharacters)
bool isPasswordValidator({int minLength = 6,int uppercaseCharCount = 0,int lowercaseCharCount = 0,int numericCharCount = 0,int specialCharCount = 0})
```

## Bool Extensions
```dart
bool validate({bool value = false})

bool get isTrue
bool get isFalse
bool get isNotTrue
bool get isNotFalse
int get toInt
bool get toggle
```

## Color Extensions
```dart
String toHex({bool leadingHashSign = true, bool includeAlpha = false})
MaterialColor createMaterialColor()
Color lighten([double amount = .1])
Color darken([double amount = .1])

bool get isDark
bool get isLight
double get getBrightness
double get getLuminance
```

## Build Context Extensions
```dart
void requestFocus(FocusNode focus)
void unFocus(FocusNode focus)
void unFocusKeyboard()
void pop<T extends Object>([T? result])
void openDrawer()
void openEndDrawer()
void hideCurrentSnackBar()
void removeCurrentSnackBar()
void clearSnackBars()
void showSnackBar()

Size get size
double get width
double get height
double get pixelRatio
double get minScreenSize
double get maxScreenSize
Brightness get platformBrightness
double get statusBarHeight
double get navigationBarHeight
ThemeData get theme
TextTheme get textTheme
DefaultTextStyle get defaultTextStyle
FormState? get formState
ScaffoldState get scaffoldState
OverlayState? get overlayState
Color get primaryColor
Color get secondaryColor
Color get accentColor
Color get scaffoldBackgroundColor
Color get cardColor
Color get dividerColor
Color get iconColor
dynamic get getArguments
Orientation get orientation
bool get isLandscape
bool get isPortrait
bool get canPop
TargetPlatform get platform
bool get isAndroid
bool get isIOS
bool get isMacOS
bool get isWindows
bool get isFuchsia
bool get isLinux
```

## DateTime Extensions - Utils
```dart
/// You can use .timeAgo on a DateTime object like this
String result = DateTime.now().timeAgo;

/// Returns the current timestamp in seconds.
int get currentTimeStamp

/// Returns the number between the current DateTime instance and [differenceDateTime].
int countSeconds(DateTime? differenceDateTime)
int countMinutes(DateTime? differenceDateTime)
int countHours(DateTime? differenceDateTime)
int countDays(DateTime? differenceDateTime)
int countWeeks(DateTime? differenceDateTime)
int countMonths(DateTime? differenceDateTime)
int countYears(DateTime? differenceDateTime)

bool get isToday
bool get isYesterday
bool get isTomorrow

String? get toTimeAmPm

DateTime? toIndiaTimeZone()

/// Returns a DateTime object in UTC timezone.
DateTime? get asUtc

String? weekdayName({bool isHalfName = false})
String? monthName({bool isHalfName = false})
```

## Double Extensions
```dart
double validate({double value = 0.0})
bool isBetween(num first, num second)
SizedBox get squareSizeBox
Size get squareSize

/// Returns a [BorderRadius] with circular radius.
BorderRadius get circularRadius
```

## Duration Extensions
```dart
/// await Duration(seconds: 1).delay();
Future<void> get delay
```

## int Extensions
```dart
bool get isEmptyOrNull
Widget get height
Widget get width
Widget get space
Widget get maxSpace
Widget get spaceExpand
Duration get microseconds
Duration get milliseconds
Duration get seconds
Duration get minutes
Duration get hours
Duration get days
Duration get weeks
Duration get month
Duration get years
Size get size
BorderRadius get circularBorderRadius
String? get addZeroPrefix

bool toBool([int value = 1])
int validate({int value = 0})
int lastDigits(int n)
/// returns month name from the given int value between [1-12]
String toMonthName({bool isHalfName = false})
/// returns WeekDay from the given int value [1-7]
String toWeekDay({bool isHalfName = false})
```

## List Extensions
```dart
T? get firstOrNull
List<T> get removeFirstElement
List<T> get removeLastElement
int? get lastIndex

T? firstWhereOrNull(bool Function(T element) test)
T? lastWhereOrNull(bool Function(T element) test)
int countWhere(bool Function(T element) predicate)
T? elementAtOrNull(int index)
Iterable<T> filterOrNewList(bool Function(T e) fun)
Iterable<T> filterNot(bool Function(T element) fun)
List<Widget> toWidgetList(Widget Function(T value) mapFunc)
int countWhere(bool Function(T) test)
void forEachIndexed(void Function( int index,T element) f)
T? random({int? seed})
List<T> separatorEvery(T separator,{bool start= false,bool end=false})
List<List<T>> divideListByFunction(bool Function(T) condition)
List<List<T>>? divideListByRange(int rangeSize)
```

## num Extensions
```dart
bool get isNullOrEmpty
num validate({num value = 0})
bool between(int min, int max)
bool isInRange(num min, num max)
List<num> randomList({int min = 0, int max = 100})
String toNumeral({bool international = true, int digitAfterDecimal = 0})
```

## ScopeFunction Extensions
```dart
int number = 5;
String result = number.let((it) => 'Number is $it');
print(result); // Output: Number is 5

var person = Person('John').also((it) => it.name = 'Doe');
print(person.name); // Output: Doe

var result = 'Hello'.run(() => 'Hello World');
print(result); // Output: Hello World

var list = [1, 2, 3].apply(() => print('List has ${list.length} elements')); // Output: List has 3 elements

int? number = 5.takeIf((it) => it > 3);
print(number); // Output: 5
number = 5.takeIf((it) => it > 6);
print(number); // Output: null

int? number = 5.takeUnless((it) => it > 6);
print(number); // Output: 5
number = 5.takeUnless((it) => it > 3);
print(number); // Output: null
```

## Systems Methods
```dart
/// Change status bar Color and Brightness
setStatusBarColor(Colors.blue);

setDarkStatusBar();
setLightStatusBar();

/// Show Status Bar
showStatusBar();

/// Hide Status Bar
hideStatusBar();

/// Set orientation to portrait
setOrientationPortrait();

/// Set orientation to landscape
setOrientationLandscape();
```

# Utils
```dart
DateTime pastDate = DateTime.now().subtract(Duration(hours: 2, minutes: 30));
print('English: ${timeAgoCalculated(pastDate)}'), //output: 3 hours ago
print('Hindi: ${timeAgoCalculated(pastDate, inHindi: true)}'),  //output: Hindi: 3 घंटे पूर्व
```
```dart
hasMatch(testString, pattern)
```
```dart
String randomString({int? length, bool includeNumeric = true})
```
## Decoration
```dart
BorderRadius radius([double? radius])
Radius radiusCircular([double? radius])
ShapeBorder dialogShape([double? borderRadius])
BorderRadius radiusOnly({double? topRight, double? topLeft, double? bottomRight, double? bottomLeft})
Decoration boxDecorationWithShadow({Color backgroundColor = whiteColor, Color? shadowColor, double? blurRadius, double? spreadRadius, Offset offset = const Offset(0.0, 0.0), LinearGradient? gradient, BoxBorder? border, List<BoxShadow>? boxShadow, DecorationImage? decorationImage, BoxShape boxShape = BoxShape.rectangle, BorderRadius? borderRadius,})
Decoration boxDecorationDefault({BorderRadiusGeometry? borderRadius, Color? color, Gradient? gradient, BoxBorder? border, BoxShape? shape, BlendMode? backgroundBlendMode, List<BoxShadow>? boxShadow, DecorationImage? image})
Decoration boxDecorationWithRoundedCorners({Color backgroundColor = whiteColor, BorderRadius? borderRadius, LinearGradient? gradient, BoxBorder? border, List<BoxShadow>? boxShadow, DecorationImage? decorationImage, BoxShape boxShape = BoxShape.rectangle})
Decoration boxDecorationRoundedWithShadow(int radiusAll, {Color backgroundColor = whiteColor, Color? shadowColor, double? blurRadius, double? spreadRadius, Offset offset = const Offset(0.0, 0.0), LinearGradient? gradient})
List<BoxShadow> defaultBoxShadow({Color? shadowColor, double? blurRadius, double? spreadRadius, Offset offset = const Offset(0.0, 0.0)})
```
## Numeral
```dart
//The Numeral class provides methods to format numbers based on the chosen numeral system.
Numeral numeral = Numeral(1234567.89);
String indianFormatted = numeral.indian; // Output: 12.34 L
String internationalFormatted = numeral.international; // Output: 1.23 M
```

## Validator
```dart
Validator.hasMinimumLength(String password, int minLength)
Validator.hasMinimumUppercase(String password, int uppercaseCount)
Validator.hasMinimumLowercase(String password, int lowercaseCount)
Validator.hasMinimumNumericCharacters(String password, int numericCount)
Validator.hasMinimumSpecialCharacters(String password, int specialCharactersCount)
```
## Random Image
```dart
// Example: Get a random image URL with custom dimensions (300x400) from Picsum
Image.network(RandomImage.picsumImage(300, 400)),

// Example: Get a random image URL from Robohash with custom parameters
Image.network(
  RandomImage.randomImage(
    slug: 'example-slug',
    size: Size(400, 400),
    set: ImageSet.set1,
    bg: ImageBg.bg1,
    imageType: ImageType.jpg,
    color: ImageColor.blue)
),

// Example: Get a random image URL from DummyImage with custom parameters
Image.network(
  RandomImage.dummyImage(
    text: 'Hello World',
    size: Size(300, 300),
    imageType: ImageType.png,
    bgColor: Colors.red,
    fgColor: Colors.white)
),
```

```dart
degreeToRadian(45); //// Output: 0.7853981633974483

// Delay execution for 500 milliseconds and return a value.
String result = await wait<String>(500, () => 'Delayed value');

//This method loads bytes from the specified asset path.
Future<Uint8List> getBytesFromAsset(String path, {int? width})

//This method checks the network connection by attempting to lookup 'google.com'.
bool isConnected = await checkConnection();
```

# Typedefs for Callback Functions
```dart
FutureVoidCallback      // Future<void> Function();
FutureDynamicCallback   // Future<dynamic> Function();
FutureIntCallback       // Future<int> Function();
FutureStringCallback    // Future<String> Function();
FutureDoubleCallback    // Future<double> Function();
DynamicCallback         // dynamic Function();
IntCallback             // int Function();
StringCallback          // String Function();
DoubleCallback          // double Function();
StringArgVoidCallback   // void Function(String arg);
IntArgVoidCallback      // void Function(int arg);
DoubleArgVoidCallback   // void Function(double arg);
```




# Image Previews
## Flutter Toast
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/flutetr_toast.gif?raw=true" height="300px">

## Avatar Glow
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/avatar_glow.gif?raw=true" width="200px">

## Outline Avatar Glow
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/outline_avatar_glow.gif?raw=true" width="200px">

## Avatar Glow MultiColor
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/avatar_glow_multi_color.gif?raw=true" width="200px">

## Outline Avatar Glow MultiColor
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/outline_avatar_glow_multi_color.gif?raw=true" width="200px">

## App Button
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/app_button.gif?raw=true" width="200px">

## Marquee
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/marquee.gif?raw=true" width="200px">

## RatingBar
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/rating_bar.gif?raw=true" width="200px">

## Read More Text
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/read_more.gif?raw=true" width="400px">

## Rounded Check Box
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/roundedcheckbox.gif?raw=true" width="200px">

## Text Icon
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/text_icon.gif?raw=true" width="400px">


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].
[tracker]: https://github.com/sachin4kmt/flutter_helper_kit/issues

## ⭐ If you like the package, a star to the repo will mean a lot.
## You can also contribute by adding new widgets or helpful methods.
## If you want to give suggestion, please contact me via email - sachin4kmt@gmail.com
## Thank you ❤