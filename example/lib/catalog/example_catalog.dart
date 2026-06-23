import 'package:example/catalog/example_entry.dart';
import 'package:example/examples/animation/animation_examples.dart';
import 'package:example/examples/app_responsive/screen_util_example.dart';
import 'package:example/examples/custom_painter/google_logo_example.dart';
import 'package:example/examples/extensions/extensions_examples.dart';
import 'package:example/examples/formatters/formatters_example.dart';
import 'package:example/examples/reactive/rx_datetime_example.dart';
import 'package:example/examples/utils/utils_examples.dart';
import 'package:example/examples/widgets/more_widgets_examples.dart';
import 'package:example/examples/widgets/widgets_examples.dart';

/// Central registry: every demo maps to a package source file + API list.
final List<ExampleEntry> exampleCatalog = [
  // ── Extensions ──────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'ext_string',
    category: ExampleCategory.extensions,
    title: 'String & Validation',
    sourceFile: 'lib/extensions/string/string_case.dart',
    apis: ['toSnakeCase', 'toCamelCase', 'isValidateEmail', 'extractPhoneNumber', 'isEmptyOrNull'],
    builder: stringExtensionsDemo,
    description: 'Also uses validation.dart and string_extension.dart',
  ),
  ExampleEntry(
    id: 'ext_number',
    category: ExampleCategory.extensions,
    title: 'Number & Smart Round',
    sourceFile: 'lib/extensions/number/smart_round_to_string.dart',
    apis: ['toStringAsSmartRounded', 'height'],
    builder: numberExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_color_date',
    category: ExampleCategory.extensions,
    title: 'Color & DateTime',
    sourceFile: 'lib/extensions/color/color_extension.dart',
    apis: ['withColorOpacity', 'timeAgo', 'format'],
    builder: colorDateExtensionsDemo,
    description: 'Also uses date_extension.dart and date_format.dart',
  ),
  ExampleEntry(
    id: 'ext_list_map',
    category: ExampleCategory.extensions,
    title: 'List & Map',
    sourceFile: 'lib/extensions/list/list_extension.dart',
    apis: ['firstOrNull', 'getOrDefault', 'validate'],
    builder: listMapExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_widget_context',
    category: ExampleCategory.extensions,
    title: 'Widget & BuildContext',
    sourceFile: 'lib/extensions/context/build_context_extension.dart',
    apis: ['showSnackBar', 'width', 'height', 'paddingAll'],
    builder: widgetContextExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_type_conversion',
    category: ExampleCategory.extensions,
    title: 'Type Conversion',
    sourceFile: 'lib/extensions/type_conversion.dart',
    apis: ['toInt', 'toBool', 'toDouble'],
    builder: typeConversionDemo,
  ),
  ExampleEntry(
    id: 'ext_alignment',
    category: ExampleCategory.extensions,
    title: 'Alignment',
    sourceFile: 'lib/extensions/alignment/alignment_extensions.dart',
    apis: ['isTop', 'isCenterVertical', 'isRight'],
    builder: alignmentExtensionsDemo,
  ),

  // ── Widgets ─────────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'w_app_button',
    category: ExampleCategory.widgets,
    title: 'AppButton',
    sourceFile: 'lib/widgets/app_button.dart',
    apis: ['AppButton'],
    builder: appButtonDemo,
  ),
  ExampleEntry(
    id: 'w_slider_button',
    category: ExampleCategory.widgets,
    title: 'SliderButton',
    sourceFile: 'lib/widgets/slider_button.dart',
    apis: ['SliderButton', 'ShimmerWidget'],
    builder: sliderButtonDemo,
  ),
  ExampleEntry(
    id: 'w_password_strength',
    category: ExampleCategory.widgets,
    title: 'PasswordStrengthIndicator',
    sourceFile: 'lib/widgets/password_strength_indicator/password_strength_indicator.dart',
    apis: ['PasswordStrengthIndicator', 'PasswordRule', 'PasswordStrength'],
    builder: passwordStrengthDemo,
  ),
  ExampleEntry(
    id: 'w_read_more',
    category: ExampleCategory.widgets,
    title: 'ReadMoreText & Enhanced',
    sourceFile: 'lib/widgets/read_more_enhanced.dart',
    apis: ['ReadMoreText', 'ReadMoreTextEnhanced', 'Annotation'],
    builder: readMoreDemo,
  ),
  ExampleEntry(
    id: 'w_sharp_corners',
    category: ExampleCategory.widgets,
    title: 'Sharp Corners',
    sourceFile: 'lib/widgets/sharp_corners/sharp_border_radius.dart',
    apis: ['SharpBorderRadius', 'SharpClipRect'],
    builder: sharpCornersDemo,
  ),
  ExampleEntry(
    id: 'w_flutter_tag',
    category: ExampleCategory.widgets,
    title: 'FlutterTag',
    sourceFile: 'lib/widgets/flutter_tag/flutter_tag.dart',
    apis: ['FlutterTag', 'FlutterTagStyle'],
    builder: flutterTagDemo,
  ),
  ExampleEntry(
    id: 'w_avatar_glow',
    category: ExampleCategory.widgets,
    title: 'Avatar Glow',
    sourceFile: 'lib/widgets/avatar_glow/avatar_glow.dart',
    apis: ['AvatarGlow', 'OutlineGlow'],
    builder: avatarGlowDemo,
  ),
  ExampleEntry(
    id: 'w_ui_components',
    category: ExampleCategory.widgets,
    title: 'UI Components',
    sourceFile: 'lib/widgets/center_text_divider.dart',
    apis: ['CenterTextDivider', 'DashDivider', 'GradientText', 'RatingBarWidget', 'Marquee', 'DottedBorderWidget'],
    builder: uiComponentsDemo,
  ),
  ExampleEntry(
    id: 'w_pagination',
    category: ExampleCategory.widgets,
    title: 'ListViewPagination',
    sourceFile: 'lib/widgets/list_view_pagination.dart',
    apis: ['ListViewPagination', 'nextData', 'hasNext'],
    builder: paginationDemo,
  ),
  ExampleEntry(
    id: 'w_rolling_digit',
    category: ExampleCategory.widgets,
    title: 'UniversalDigitCounter',
    sourceFile: 'lib/widgets/rolling_digit/digit_count_animation.dart',
    apis: ['UniversalDigitCounter', 'DigitAnimationType'],
    builder: rollingDigitDemo,
  ),
  ExampleEntry(
    id: 'w_ticket_clippers',
    category: ExampleCategory.widgets,
    title: 'Ticket Clippers',
    sourceFile: 'lib/widgets/ticket_clippers/ticket_clipper.dart',
    apis: ['TicketClipper', 'PointedEdgeClipper', 'TicketShadowPainter'],
    builder: ticketClippersDemo,
  ),
  ExampleEntry(
    id: 'w_cupertino',
    category: ExampleCategory.widgets,
    title: 'Cupertino Dialogs',
    sourceFile: 'lib/widgets/app_cupertino_action_sheet/app_cupertino_action_sheet.dart',
    apis: ['AppCupertinoActionSheet', 'AppCupertinoDialog', 'ActionSheetItem'],
    builder: cupertinoDialogsDemo,
  ),
  ExampleEntry(
    id: 'w_timer_space',
    category: ExampleCategory.widgets,
    title: 'Timer & Space',
    sourceFile: 'lib/widgets/timer_builder.dart',
    apis: ['TimerBuilder.periodic', 'Space', 'height'],
    builder: timerSpaceDemo,
  ),
  ExampleEntry(
    id: 'w_shimmer_toast',
    category: ExampleCategory.widgets,
    title: 'Shimmer & Toast',
    sourceFile: 'lib/widgets/simmer.dart',
    apis: ['TextShimmer', 'FlutterToast'],
    builder: shimmerToastDemo,
  ),
  ExampleEntry(
    id: 'w_custom_banner',
    category: ExampleCategory.widgets,
    title: 'CustomBanner',
    sourceFile: 'lib/widgets/custom_banner.dart',
    apis: ['CustomBanner', 'CustomBannerLocation'],
    builder: customBannerDemo,
  ),
  ExampleEntry(
    id: 'w_double_press_back',
    category: ExampleCategory.widgets,
    title: 'DoublePressBackWidget',
    sourceFile: 'lib/widgets/double_press_back_widget.dart',
    apis: ['DoublePressBackWidget'],
    builder: doublePressBackLiveDemo,
  ),
  ExampleEntry(
    id: 'w_tap_safe',
    category: ExampleCategory.widgets,
    title: 'TapSafeGesture',
    sourceFile: 'lib/widgets/tap_safe_gesture.dart',
    apis: ['TapSafeGesture', 'FutureVoidCallback'],
    builder: tapSafeGestureDemo,
  ),
  ExampleEntry(
    id: 'w_flutter_list_view',
    category: ExampleCategory.widgets,
    title: 'FlutterListView',
    sourceFile: 'lib/widgets/flutter_list_view.dart',
    apis: ['FlutterListView', 'FlutterScrollDirection'],
    builder: flutterListViewDemo,
  ),
  ExampleEntry(
    id: 'w_unfocusable',
    category: ExampleCategory.widgets,
    title: 'UnFocusable',
    sourceFile: 'lib/widgets/hide_keyboard.dart',
    apis: ['UnFocusable'],
    builder: unFocusableDemo,
  ),
  ExampleEntry(
    id: 'w_custom_indicator',
    category: ExampleCategory.widgets,
    title: 'CustomIndicator',
    sourceFile: 'lib/widgets/custom_indicator.dart',
    apis: ['CustomIndicator'],
    builder: customIndicatorDemo,
  ),
  ExampleEntry(
    id: 'w_separated_column',
    category: ExampleCategory.widgets,
    title: 'SeparatedColumn',
    sourceFile: 'lib/widgets/separated_column.dart',
    apis: ['SeparatedColumn'],
    builder: separatedColumnDemo,
  ),
  ExampleEntry(
    id: 'w_profile_shimmer',
    category: ExampleCategory.widgets,
    title: 'ProfileShimmer',
    sourceFile: 'lib/widgets/simmer.dart',
    apis: ['ProfileShimmer', 'TextShimmer', 'ListTileShimmer'],
    builder: profileShimmerDemo,
  ),
  ExampleEntry(
    id: 'w_animated_list',
    category: ExampleCategory.widgets,
    title: 'AnimatedListWrapper',
    sourceFile: 'lib/animation/list_view_animation.dart',
    apis: ['AnimatedListWrapper', 'ListAnimationType'],
    builder: animatedListWrapperDemo,
  ),
  ExampleEntry(
    id: 'w_outline_glow',
    category: ExampleCategory.widgets,
    title: 'OutlineAvatarGlow',
    sourceFile: 'lib/widgets/avatar_glow/outline_glow.dart',
    apis: ['OutlineAvatarGlow'],
    builder: outlineGlowDemo,
  ),
  ExampleEntry(
    id: 'w_text_avatar',
    category: ExampleCategory.widgets,
    title: 'TextAvatar',
    sourceFile: 'lib/widgets/text_avatar.dart',
    apis: ['TextAvatar'],
    builder: textAvatarDemo,
  ),
  ExampleEntry(
    id: 'w_rounded_checkbox',
    category: ExampleCategory.widgets,
    title: 'RoundedCheckBox',
    sourceFile: 'lib/widgets/rounded_checkbox_widget.dart',
    apis: ['RoundedCheckBox'],
    builder: roundedCheckBoxDemo,
  ),
  ExampleEntry(
    id: 'w_dialog_close',
    category: ExampleCategory.widgets,
    title: 'showDialogWithCloseIcon',
    sourceFile: 'lib/utils/close_icon_show_dialog.dart',
    apis: ['showDialogWithCloseIcon'],
    builder: showDialogCloseDemo,
  ),

  // ── Animation ───────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'anim_widget',
    category: ExampleCategory.animation,
    title: 'Widget Animations',
    sourceFile: 'lib/animation/widget_animation_extensions.dart',
    apis: ['animateWidgetElasticEntry', 'animateWidgetGlassReveal', 'animateWidgetZoomFocus'],
    builder: widgetAnimationsDemo,
    description: '75+ animateWidget* methods available',
  ),
  ExampleEntry(
    id: 'anim_list',
    category: ExampleCategory.animation,
    title: 'List Item Animations',
    sourceFile: 'lib/animation/list_item_animations.dart',
    apis: ['animateListEntry', 'AnimationListViewItemWidget'],
    builder: listAnimationsDemo,
  ),
  ExampleEntry(
    id: 'anim_gesture',
    category: ExampleCategory.animation,
    title: 'AnimatedGestureDetector',
    sourceFile: 'lib/animation/animated_gesture_detector.dart',
    apis: ['AnimatedGestureDetector', 'TapEffect'],
    builder: gestureAnimationDemo,
  ),
  ExampleEntry(
    id: 'anim_sheet',
    category: ExampleCategory.animation,
    title: 'Bottom Sheet Animations',
    sourceFile: 'lib/animation/animations_bottom_sheet.dart',
    apis: ['animateSheetReveal', 'animateModalPop'],
    builder: bottomSheetAnimationDemo,
  ),

  // ── App Responsive ──────────────────────────────────────────────────────
  ExampleEntry(
    id: 'resp_screen_util',
    category: ExampleCategory.appResponsive,
    title: 'ScreenUtil & Sizing',
    sourceFile: 'lib/app_responsive/screen_util.dart',
    apis: ['ScreenUtilInit', '.w', '.h', '.sp', '.r', 'RPadding', 'RSizedBox'],
    builder: screenUtilDemo,
  ),

  // ── Utils ───────────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'util_misc',
    category: ExampleCategory.utils,
    title: 'Utils',
    sourceFile: 'lib/utils/ago_time.dart',
    apis: ['timeAgoCalculated', 'RandomImage', 'RandomPicsumImage', 'SystemUiUtils'],
    builder: utilsDemo,
  ),
  ExampleEntry(
    id: 'util_map_adapter',
    category: ExampleCategory.utils,
    title: 'Map Info Window Adapter',
    sourceFile: 'lib/utils/map_info_window_callback_adapter.dart',
    apis: ['CallbackMapInfoWindowAdapter', 'MapCustomInfoWindow'],
    builder: mapAdapterDemo,
  ),

  // ── Reactive ────────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'rx_datetime',
    category: ExampleCategory.reactive,
    title: 'RxDateTime',
    sourceFile: 'lib/reactive/rx_datetime.dart',
    apis: ['RxDateTime', 'format', 'timeAgo', 'addDuration'],
    builder: rxDatetimeDemo,
  ),

  // ── Formatters ──────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'fmt_text_field',
    category: ExampleCategory.formatters,
    title: 'Text Field Formatters',
    sourceFile: 'lib/text_field/no_leading_space_formatter.dart',
    apis: ['NoLeadingSpaceFormatter', 'NoSpaceFormatter'],
    builder: formattersDemo,
  ),

  // ── Custom Painter ──────────────────────────────────────────────────────
  ExampleEntry(
    id: 'paint_google_logo',
    category: ExampleCategory.customPainter,
    title: 'GoogleLogoWidget',
    sourceFile: 'lib/custom_painter/google_logo_painter.dart',
    apis: ['GoogleLogoWidget'],
    builder: googleLogoDemo,
  ),
];

ExampleEntry? findExampleById(String id) {
  for (final entry in exampleCatalog) {
    if (entry.id == id) return entry;
  }
  return null;
}
