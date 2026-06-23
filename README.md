# flutter_helper_kit

A production-ready Flutter utility kit — extensions, widgets, animations, responsive sizing, and utils in **one package with zero external dependencies** (Flutter SDK only).

Consolidates helpers previously spread across `custom_helper` folders (Paydrop, WhereToNow, etc.) into a single maintainable package.

[![pub package](https://img.shields.io/pub/v/flutter_helper_kit.svg)](https://pub.dev/packages/flutter_helper_kit)

**Platforms:** Android · iOS · Web · macOS · Windows · Linux

---

## Installation

```yaml
dependencies:
  flutter_helper_kit: ^1.0.6
```

```bash
flutter pub add flutter_helper_kit
```

```dart
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
```

### Modular imports (smaller compile surface)

```dart
import 'package:flutter_helper_kit/flutter_helper_kit_extensions.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_widgets.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_animation.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_responsive.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_utils.dart';
```

---

## Package structure

Every feature maps to a `lib/` path. Use this table to find the right file.

| Module | Source path | Key APIs |
|--------|-------------|----------|
| **Extensions** | `lib/extensions/` | String, Color, DateTime, List, Map, Widget, Context, Alignment, Type conversion |
| **Widgets** | `lib/widgets/` | AppButton, SliderButton, ReadMore, FlutterTag, Sharp corners, Pagination, etc. |
| **Animation** | `lib/animation/` | 75+ `animateWidget*`, list animations, `AnimatedGestureDetector` |
| **App Responsive** | `lib/app_responsive/` | `ScreenUtilInit`, `.w`, `.h`, `.sp`, `.r`, `RPadding`, `RSizedBox` |
| **Reactive** | `lib/reactive/` | `RxDateTime`, `RxnDateTime` (ValueNotifier-based) |
| **Utils** | `lib/utils/` | `timeAgoCalculated`, `RandomImage`, `SystemUiUtils`, `MapCustomInfoWindow` |
| **Formatters** | `lib/text_field/` | `NoLeadingSpaceFormatter`, `NoSpaceFormatter` |
| **Custom Painter** | `lib/custom_painter/` | `GoogleLogoWidget` |

Full single import via `flutter_helper_kit.dart`.

---

## Example app

Runnable demos for every module — each screen shows **source file + API names**.

```bash
cd example
flutter run
```

See [example/README.md](example/README.md) for catalog structure and how to add new demos.

---

## Quick start

### Responsive sizing (`app_responsive/`)

```dart
ScreenUtilInit(
  designSize: const Size(360, 690),
  builder: (_, child) => MaterialApp(home: child),
  child: Builder(
    builder: (context) => Container(
      width: 200.w,
      height: 80.h,
      child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
    ),
  ),
);
```

| API | File |
|-----|------|
| `.w`, `.h`, `.sp`, `.r`, `.sw`, `.sh` | `app_responsive/size_extension.dart` |
| `ScreenUtilInit` | `app_responsive/screenutil_init.dart` |
| `RPadding`, `RSizedBox` | `app_responsive/r_padding.dart`, `r_sized_box.dart` |

### Widget animations (`animation/`)

```dart
Text('Hello')
  .animateWidgetElasticEntry()
  .animateWidgetGlassReveal();

// List item stagger
ListTile(title: Text('Item'))
  .animateListEntry(index: 0);

// Tap feedback
AnimatedGestureDetector(
  effectPreset: TapEffect.bounce,
  onTap: () {},
  child: Icon(Icons.favorite),
);
```

| API | File |
|-----|------|
| `animateWidget*` (75+ methods) | `animation/widget_animation_extensions.dart` |
| `animateList*` | `animation/list_item_animations.dart` |
| `AnimatedGestureDetector` | `animation/animated_gesture_detector.dart` |
| `animateSheetReveal` | `animation/animations_bottom_sheet.dart` |

### Extensions

```dart
'edit_item'.toSnakeCase();           // string_case.dart
'user@mail.com'.isValidateEmail();  // validation.dart
1.50.toStringAsSmartRounded();       // smart_round_to_string.dart
Colors.blue.withColorOpacity(0.5);   // color_extension.dart
DateTime.now().timeAgo();            // date_extension.dart
'42'.toInt();                        // type_conversion.dart (on Object?)
context.showSnackBar(title: Text('Hi')); // build_context_extension.dart
```

### Widgets

```dart
// Slider with shimmer label
SliderButton(
  width: 300,
  label: Text('Slide to confirm'),
  action: () async => true,
);

// Password strength meter
PasswordStrengthIndicator(textController: controller);

// Enhanced read-more with regex annotations
ReadMoreTextEnhanced(longText, trimLines: 3, annotations: [...]);

// iOS-style sheets (pass BuildContext)
AppCupertinoActionSheet.showActionSheet(
  context: context,
  actions: [ActionSheetItem(value: 'a', label: 'Option A')],
);

// Animated digit counter
UniversalDigitCounter(value: 12345, type: DigitAnimationType.simple);

// Ticket shape clipper
TicketClipper(
  clipper: PointedEdgeClipper(),
  child: Container(color: Colors.orange),
);

// Infinite scroll list
ListViewPagination(
  itemCount: items.length,
  hasNext: hasMore,
  nextData: fetchMore,
  itemBuilder: (_, i) => ListTile(title: Text(items[i])),
);
```

| Widget | File |
|--------|------|
| `AppButton` | `widgets/app_button.dart` |
| `SliderButton` | `widgets/slider_button.dart` |
| `PasswordStrengthIndicator` | `widgets/password_strength_indicator/` |
| `ReadMoreText` / `ReadMoreTextEnhanced` | `widgets/read_more_text.dart`, `read_more_enhanced.dart` |
| `FlutterTag` | `widgets/flutter_tag/` |
| `SharpBorderRadius`, `SharpClipRect` | `widgets/sharp_corners/` |
| `ListViewPagination` | `widgets/list_view_pagination.dart` |
| `CenterTextDivider`, `CustomBanner` | `widgets/center_text_divider.dart`, `custom_banner.dart` |
| `AvatarGlow`, `OutlineGlow` | `widgets/avatar_glow/` |
| `TicketClipper` | `widgets/ticket_clippers/` |
| `UniversalDigitCounter` | `widgets/rolling_digit/` |

### Reactive datetime (`reactive/`)

```dart
final rx = RxDateTime.now();
rx.addDuration(const Duration(hours: 1));
print(rx.format('yyyy-MM-dd'));
print(rx.timeAgo());
```

No GetX required — built on `ValueNotifier<DateTime>`.

### Utils

```dart
timeAgoCalculated(DateTime.now().subtract(Duration(minutes: 5)));
RandomImage.picsumImage(300, 200);
RandomPicsumImage.image(width: 400, height: 300);
SystemUiUtils.setStatusBarColor(Colors.deepPurple);
```

| Util | File |
|------|------|
| `timeAgoCalculated` | `utils/ago_time.dart` |
| `RandomImage` | `utils/random_image.dart` |
| `RandomPicsumImage` | `utils/random_picsum_image.dart` |
| `SystemUiUtils` | `utils/system_ui_utils.dart` |
| `MapCustomInfoWindow` | `utils/map_custom_info_window.dart` |
| `showDialogWithCloseIcon` | `utils/close_icon_show_dialog.dart` |
| `Validator` | `utils/password_validator.dart` |
| `Numeral` | `utils/numberal_utils.dart` |

### Map info window (callback adapter)

No `google_maps_flutter` dependency in this package. Use [CallbackMapInfoWindowAdapter](lib/utils/map_info_window_callback_adapter.dart):

```dart
final adapter = CallbackMapInfoWindowAdapter(
  onGetScreenCoordinate: (latLng) async {
    final coord = await googleMapController.getScreenCoordinate(
      LatLng(latLng.latitude, latLng.longitude),
    );
    return MapScreenCoordinate(coord.x, coord.y);
  },
);
controller.mapAdapter = adapter;
```

### Text field formatters

```dart
TextField(
  inputFormatters: [
    NoLeadingSpaceFormatter(),
    NoSpaceFormatter(),
  ],
);
```

---

## Extensions reference

<details>
<summary><strong>String</strong> — <code>extensions/string/</code></summary>

- `string_extension.dart` — `isEmptyOrNull`, `capitalize`, `reversed`, parsing helpers
- `string_case.dart` — `toSnakeCase`, `toCamelCase`, `toPascalCase`, `toKebabCase`, `toTitleCase`
- `validation.dart` — `isValidateEmail`, `validatePhone`, `extractPhoneNumber`, URL/password checks

</details>

<details>
<summary><strong>Color</strong> — <code>extensions/color/color_extension.dart</code></summary>

- `toHex`, `createMaterialColor`, `lighten`, `darken`, `withColorOpacity`, `isDark`, `isLight`

</details>

<details>
<summary><strong>DateTime</strong> — <code>extensions/date/</code></summary>

- `date_extension.dart` — `timeAgo`, `isToday`, `isYesterday`, timezone helpers
- `date_format.dart` — `format(pattern:)`, `formatTime()`

</details>

<details>
<summary><strong>List / Map / Set / Iterable</strong> — <code>extensions/list/</code>, <code>map/</code>, <code>set/</code></summary>

- `firstOrNull`, `lastWhereOrNull`, `separatorEvery`, `getOrDefault`, `validate`

</details>

<details>
<summary><strong>Number</strong> — <code>extensions/number/</code></summary>

- `integer_extension.dart`, `double_extension.dart`, `number_extension.dart`
- `smart_round_to_string.dart` — `toStringAsSmartRounded()`
- `height()`, `width()`, `circularBorderRadius` spacing helpers

</details>

<details>
<summary><strong>Widget / Context</strong> — <code>extensions/widget/</code>, <code>context/</code></summary>

- `paddingAll`, `withSize`, `visible`, `expanded`, `centered`
- `width`, `height`, `showSnackBar`, `theme`, platform checks

</details>

<details>
<summary><strong>Other</strong></summary>

- `alignment/alignment_extensions.dart` — `isTop`, `isBottom`, `isLeft`, `isRight`
- `type_conversion.dart` — `toInt`, `toDouble`, `toBool`, `toStr` on `Object?`
- `bool/bool_extensions.dart` — `validate`, `toggle`, `toInt`
- `duration/duration_extensions.dart` — `.delay`
- `function/scope_functions_extension.dart` — `let`, `also`, `run`, `takeIf`
- `random/random_extension.dart` — random helpers on `math.Random`

</details>

---

## Widgets reference

<details>
<summary><strong>UI & feedback</strong></summary>

| Widget | File | Description |
|--------|------|-------------|
| `FlutterToast` | `flutter_toast.dart` | Toast messages |
| `CustomIndicator` | `custom_indicator.dart` | Loading overlay |
| `UnFocusable` | `hide_keyboard.dart` | Dismiss keyboard on outside tap |
| `DoublePressBackWidget` | `double_press_back_widget.dart` | Press back twice to exit |
| `TapSafeGesture` | `tap_safe_gesture.dart` | Debounced async tap |
| `TextShimmer`, `ProfileShimmer`, … | `simmer.dart` | Shimmer placeholders |

</details>

<details>
<summary><strong>Layout & display</strong></summary>

| Widget | File |
|--------|------|
| `Space`, `SliverSpace` | `space/space.dart`, `sliver_space.dart` |
| `SeparatedColumn` | `separated_column.dart` |
| `FlutterListView` | `flutter_list_view.dart` |
| `DashDivider` | `dash_divider.dart` |
| `DottedBorderWidget` | `dotted_border_widget.dart` |
| `GradientText` | `gradient_text.dart` |
| `Marquee` | `marquee_widget.dart` |
| `TextAvatar`, `TextIcon` | `text_avatar.dart`, `text_icon_widget.dart` |
| `WidgetHelper` | `widget_helper.dart` |

</details>

<details>
<summary><strong>Forms & input</strong></summary>

| Widget | File |
|--------|------|
| `RoundedCheckBox` | `rounded_checkbox_widget.dart` |
| `RatingBarWidget` | `rating_bar_widget.dart` |
| `TimerBuilder` | `timer_builder.dart` |

</details>

---

## Typedefs

Callback types in `utils/type_def.dart`:

`FutureVoidCallback`, `StringCallback`, `IntArgVoidCallback`, `DoubleCallback`, and more.

---

## Migration from custom_helper

| Before | After |
|--------|-------|
| `import '.../custom_helper.dart'` | `import 'package:flutter_helper_kit/flutter_helper_kit.dart'` |
| `Get.context` in Cupertino dialogs | Pass `context:` parameter |
| `Rx<DateTime>` (GetX) | `RxDateTime` / `RxnDateTime` |
| Google Maps `LatLng` in info window | `MapLatLng` + `MapInfoWindowAdapter` |

---

## Screenshots

### Flutter Toast
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/flutetr_toast.gif?raw=true" height="300" alt="Flutter Toast">

### Tap Safe Gesture
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/tap_safe_gesture.gif?raw=true" height="200" alt="Tap Safe Gesture">

### Avatar Glow
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/avatar_glow.gif?raw=true" width="200" alt="Avatar Glow">

### Outline Avatar Glow
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/outline_avatar_glow.gif?raw=true" width="200" alt="Outline Avatar Glow">

### Avatar Glow MultiColor
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/avatar_glow_multi_color.gif?raw=true" width="200" alt="Avatar Glow MultiColor">

### Outline Avatar Glow MultiColor
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/outline_avatar_glow_multi_color.gif?raw=true" width="200" alt="Outline Avatar Glow MultiColor">

### App Button
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/app_button.gif?raw=true" width="200" alt="App Button">

### Marquee
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/marquee.gif?raw=true" width="200" alt="Marquee">

### RatingBar
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/rating_bar.gif?raw=true" width="200" alt="RatingBar">

### Read More Text
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/read_more.gif?raw=true" width="400" alt="Read More Text">

### Rounded Check Box
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/roundedcheckbox.gif?raw=true" width="200" alt="Rounded Check Box">

### Text Icon
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/text_icon.gif?raw=true" width="400" alt="Text Icon">

### showDialogWithCloseIcon
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/show_dialog_with_close_icon.jpg?raw=true" height="200" alt="showDialogWithCloseIcon">

### Sharp Borders
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/sharp_borders.jpg?raw=true" height="300" alt="Sharp Borders">

### Flutter Tag
<img src="https://github.com/sachin4kmt/flutter_helper_kit/blob/master/screenshots/flutter_tag.gif?raw=true" width="400" alt="Flutter Tag">

---

## Contributing

- **Issues & features:** [GitHub Issues](https://github.com/sachin4kmt/flutter_helper_kit/issues)
- **New widget/API:** add under `lib/`, export in `flutter_helper_kit.dart`, register demo in `example/lib/catalog/example_catalog.dart`
- **Contact:** sachin4kmt@gmail.com

If this package helps your project, consider giving it a star on GitHub.
