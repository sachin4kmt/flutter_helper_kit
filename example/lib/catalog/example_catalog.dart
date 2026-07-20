import 'package:example/catalog/example_entry.dart';
import 'package:example/examples/animation/animation_examples.dart';
import 'package:example/examples/app_responsive/responsive_examples.dart';
import 'package:example/examples/app_responsive/screen_util_example.dart';
import 'package:example/examples/custom_painter/google_logo_example.dart';
import 'package:example/examples/extensions/extensions_examples.dart';
import 'package:example/examples/extensions/more_extensions_examples.dart';
import 'package:example/examples/formatters/formatters_example.dart';
import 'package:example/examples/reactive/rx_datetime_example.dart';
import 'package:example/examples/utils/more_utils_examples.dart';
import 'package:example/examples/utils/utils_examples.dart';
import 'package:example/examples/live/live_examples.dart';
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
    apis: [
      'toSnakeCase',
      'toCamelCase',
      'isValidateEmail',
      'extractPhoneNumber',
      'isEmptyOrNull'
    ],
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
    sourceFile: 'lib/extensions/alignment/alignment.dart',
    apis: ['isTop', 'isCenter', 'isCorner', 'opposite', 'isLeftResolved'],
    builder: alignmentExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_bool',
    category: ExampleCategory.extensions,
    title: 'Bool Extensions',
    sourceFile: 'lib/extensions/bool/bool_extensions.dart',
    apis: ['validate', 'isTrue', 'isFalse', 'toInt', 'toggle'],
    builder: boolExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_int',
    category: ExampleCategory.extensions,
    title: 'Int Extensions',
    sourceFile: 'lib/extensions/number/integer_extension.dart',
    apis: [
      'toWords',
      'toRoman',
      'toOrdinal',
      'seconds',
      'validate',
      'addZeroPrefix'
    ],
    builder: intExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_num',
    category: ExampleCategory.extensions,
    title: 'Num Extensions',
    sourceFile: 'lib/extensions/number/number_extension.dart',
    apis: [
      'height',
      'width',
      'space',
      'maxSpace',
      'isBetween',
      'increaseByPercentage',
      'generateLoremIpsumWords'
    ],
    builder: numExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_duration_scope',
    category: ExampleCategory.extensions,
    title: 'Duration, Random & Scope',
    sourceFile: 'lib/extensions/duration/duration_extensions.dart',
    apis: [
      'delay',
      'let',
      'also',
      'takeIf',
      'generateLoremIpsumWords',
      'pastDate'
    ],
    builder: durationRandomScopeDemo,
    description:
        'Also uses scope_functions_extension.dart and random_extension.dart',
  ),
  ExampleEntry(
    id: 'ext_widget',
    category: ExampleCategory.extensions,
    title: 'Widget Extension',
    sourceFile: 'lib/extensions/widget/widget_extension.dart',
    apis: [
      'withSize',
      'withWidth',
      'visible',
      'opacity',
      'onTap',
      'cornerRadiusWithClipRRect',
      'center'
    ],
    builder: widgetExtensionDemo,
  ),
  ExampleEntry(
    id: 'ext_padding_border',
    category: ExampleCategory.extensions,
    title: 'Padding & Border',
    sourceFile: 'lib/extensions/widget/padding.dart',
    apis: [
      'padAll',
      'padHorizontal',
      'paddingAll',
      'paddingSymmetric',
      'circularRadius',
      'circularSharpRadius'
    ],
    builder: paddingBorderExtensionsDemo,
    description: 'Also uses border.dart',
  ),
  ExampleEntry(
    id: 'ext_set_iterable',
    category: ExampleCategory.extensions,
    title: 'Set & Iterable',
    sourceFile: 'lib/extensions/set/set_extension.dart',
    apis: ['whereSet', 'sorted', 'groupBy', 'maxBy', 'isNullOrEmpty'],
    builder: setIterableExtensionsDemo,
    description: 'Also uses iterable_extension.dart',
  ),
  ExampleEntry(
    id: 'ext_listenable',
    category: ExampleCategory.extensions,
    title: 'Listenable Extensions',
    sourceFile: 'lib/extensions/function/listenable_extension.dart',
    apis: ['builder', 'listen', 'listenChild', 'buildWhenTrue'],
    builder: listenableExtensionsDemo,
  ),
  ExampleEntry(
    id: 'ext_row_column_list',
    category: ExampleCategory.extensions,
    title: 'Row, Column & Widget List',
    sourceFile: 'lib/extensions/widget/row_extension.dart',
    apis: [
      'intrinsicHeight',
      'intrinsicWidth',
      'expandEvery',
      'flexibleEvery',
      'spacerEvery'
    ],
    builder: rowColumnWidgetListDemo,
    description:
        'Also uses column_extension.dart and widget_list_extension.dart',
  ),
  ExampleEntry(
    id: 'ext_map_full',
    category: ExampleCategory.extensions,
    title: 'Map Extension',
    sourceFile: 'lib/extensions/map/map_extension.dart',
    apis: [
      'isNullOrEmpty',
      'getOrDefault',
      'filter',
      'addIfNotNull',
      'capitalizeKeysFirstCharacter'
    ],
    builder: mapExtensionDemo,
  ),
  ExampleEntry(
    id: 'ext_color_full',
    category: ExampleCategory.extensions,
    title: 'Color Extensions (full)',
    sourceFile: 'lib/extensions/color/color_extension.dart',
    apis: [
      'toHex',
      'withColorOpacity',
      'lighten',
      'darken',
      'createMaterialColor',
      'isDark'
    ],
    builder: colorExtensionsFullDemo,
  ),
  ExampleEntry(
    id: 'ext_list_num',
    category: ExampleCategory.extensions,
    title: 'List Num',
    sourceFile: 'lib/extensions/list/list_num.dart',
    apis: ['total', 'isNotNullAndEmpty', 'isNullAndEmpty'],
    builder: listNumExtensionDemo,
  ),
  ExampleEntry(
    id: 'ext_date',
    category: ExampleCategory.extensions,
    title: 'DateTime Extensions',
    sourceFile: 'lib/extensions/date/date_extension.dart',
    apis: [
      'isInPast',
      'isInFuture',
      'timeAgo',
      'format',
      'formatTime',
      'timeZoneOffSet'
    ],
    builder: dateExtensionsDemo,
    description: 'Also uses date_format.dart',
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
    sourceFile:
        'lib/widgets/password_strength_indicator/password_strength_indicator.dart',
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
    apis: [
      'CenterTextDivider',
      'DashDivider',
      'GradientText',
      'RatingBarWidget',
      'Marquee',
      'DottedBorderWidget'
    ],
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
    sourceFile:
        'lib/widgets/app_cupertino_action_sheet/app_cupertino_action_sheet.dart',
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
  ExampleEntry(
    id: 'w_generic_picker',
    category: ExampleCategory.widgets,
    title: 'GenericPickerSheet',
    sourceFile: 'lib/widgets/dropdown_sheet/generic_dropdown_sheet.dart',
    apis: [
      'GenericPickerSheet',
      'singleSelection',
      'multiSelection',
      'DropdownItem',
      'MyDropdownItem'
    ],
    builder: genericPickerDemo,
  ),
  ExampleEntry(
    id: 'w_text_icon',
    category: ExampleCategory.widgets,
    title: 'TextIcon',
    sourceFile: 'lib/widgets/text_icon_widget.dart',
    apis: ['TextIcon'],
    builder: textIconDemo,
  ),
  ExampleEntry(
    id: 'w_widget_helper',
    category: ExampleCategory.widgets,
    title: 'WidgetHelper',
    sourceFile: 'lib/widgets/widget_helper.dart',
    apis: ['WidgetHelper.intersperse', 'WidgetHelper.widgetMap'],
    builder: widgetHelperDemo,
  ),
  ExampleEntry(
    id: 'w_sliver_space',
    category: ExampleCategory.widgets,
    title: 'SliverSpace & SpaceMax / SpaceMin',
    sourceFile: 'lib/widgets/space/sliver_space.dart',
    apis: ['SliverSpace', 'SpaceMax', 'SpaceMin', 'Space.expand'],
    builder: sliverSpaceDemo,
    description: 'Also uses space.dart',
  ),
  ExampleEntry(
    id: 'w_percent_indicator',
    category: ExampleCategory.widgets,
    title: 'Percent Indicators',
    sourceFile:
        'lib/widgets/flutter_percent_indicator/flutter_percent_indicator.dart',
    apis: [
      'CircularPercentIndicator',
      'LinearPercentIndicator',
      'MultiSegmentLinearIndicator',
      'SegmentLinearIndicator',
    ],
    builder: percentIndicatorsDemo,
    description: 'Circular, linear, and multi-segment progress bars',
  ),
  ExampleEntry(
    id: 'w_avatar_glow_multi',
    category: ExampleCategory.widgets,
    title: 'AvatarGlowMultiColor',
    sourceFile: 'lib/widgets/avatar_glow/avatar_glow_multi_color.dart',
    apis: ['AvatarGlowMultiColor'],
    builder: avatarGlowMultiColorDemo,
  ),
  ExampleEntry(
    id: 'w_outline_glow_multi',
    category: ExampleCategory.widgets,
    title: 'OutlineAvatarGlowMultiColor',
    sourceFile: 'lib/widgets/avatar_glow/outline_glow_multi_color.dart',
    apis: ['OutlineAvatarGlowMultiColor'],
    builder: outlineGlowMultiColorDemo,
  ),
  ExampleEntry(
    id: 'w_sharp_full',
    category: ExampleCategory.widgets,
    title: 'Sharp Corners (full)',
    sourceFile: 'lib/widgets/sharp_corners/sharp.dart',
    apis: [
      'SharpClipRect',
      'SharpCircleBorder',
      'SharpRadius',
      'SharpRectangleBorder'
    ],
    builder: sharpCornersFullDemo,
  ),
  ExampleEntry(
    id: 'w_shimmer_variants',
    category: ExampleCategory.widgets,
    title: 'Shimmer Variants',
    sourceFile: 'lib/widgets/simmer.dart',
    apis: [
      'ProfilePageShimmer',
      'ListTileShimmer',
      'VideoShimmer',
      'YoutubeShimmer',
      'PlayStoreShimmer'
    ],
    builder: shimmerVariantsDemo,
  ),
  ExampleEntry(
    id: 'w_ticket_full',
    category: ExampleCategory.widgets,
    title: 'Ticket Clippers (all)',
    sourceFile: 'lib/widgets/ticket_clippers/rounded_edge.dart',
    apis: [
      'RoundedEdgeClipper',
      'TicketRoundedEdgeClipper',
      'PointedEdgeClipper',
      'TicketShadowPainter'
    ],
    builder: ticketClippersFullDemo,
  ),
  ExampleEntry(
    id: 'w_digit_types',
    category: ExampleCategory.widgets,
    title: 'Digit Animation Types',
    sourceFile: 'lib/widgets/rolling_digit/digit_count_animation.dart',
    apis: ['UniversalDigitCounter', 'DigitAnimationType'],
    builder: digitAnimationTypesDemo,
  ),
  ExampleEntry(
    id: 'w_read_more_basic',
    category: ExampleCategory.widgets,
    title: 'ReadMoreText (basic)',
    sourceFile: 'lib/widgets/read_more_text.dart',
    apis: ['ReadMoreText', 'TrimMode'],
    builder: readMoreTextBasicDemo,
  ),

  // ── Animation ───────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'anim_widget',
    category: ExampleCategory.animation,
    title: 'Widget Animations',
    sourceFile: 'lib/animation/widget_animation_extensions.dart',
    apis: [
      'animateWidgetElasticEntry',
      'animateWidgetGlassReveal',
      'animateWidgetZoomFocus'
    ],
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
  ExampleEntry(
    id: 'anim_staggered',
    category: ExampleCategory.animation,
    title: 'Staggered List Animations',
    sourceFile: 'lib/animation/widget_list_animation.dart',
    apis: [
      'animateStaggeredList',
      'animateStaggeredListRight',
      'animateStaggeredScale',
      'animateStaggeredBounce'
    ],
    builder: staggeredListAnimationsDemo,
  ),
  ExampleEntry(
    id: 'anim_flutter_animate',
    category: ExampleCategory.animation,
    title: 'flutter_animate Core',
    sourceFile: 'lib/core/flutter_animate/flutter_animate.dart',
    apis: [
      'Animate',
      '.animate()',
      'fadeIn',
      'slideY',
      'scale',
      'shake',
      'NumDurationExtensions.ms'
    ],
    builder: flutterAnimateDemo,
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
  ExampleEntry(
    id: 'resp_sliver',
    category: ExampleCategory.appResponsive,
    title: 'Responsive Slivers',
    sourceFile: 'lib/app_responsive/r_sliver_padding.dart',
    apis: [
      'RSliverPadding',
      'RSliverSizedBox',
      'verticalSpace',
      'horizontalSpace',
      'REdgeInsets'
    ],
    builder: sliverResponsiveDemo,
    description: 'Also uses size_extension.dart and r_sliver_sized_box.dart',
  ),

  // ── Utils ───────────────────────────────────────────────────────────────
  ExampleEntry(
    id: 'util_misc',
    category: ExampleCategory.utils,
    title: 'Utils',
    sourceFile: 'lib/utils/ago_time.dart',
    apis: [
      'timeAgoCalculated',
      'RandomImage',
      'RandomPicsumImage',
      'SystemUiUtils'
    ],
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
  ExampleEntry(
    id: 'util_decorations',
    category: ExampleCategory.utils,
    title: 'Decorations',
    sourceFile: 'lib/utils/decorations.dart',
    apis: [
      'primaryTextStyle',
      'defaultInputDecoration',
      'boxDecorationWithShadow',
      'boxDecorationRoundedWithShadow',
      'radius'
    ],
    builder: decorationsDemo,
  ),
  ExampleEntry(
    id: 'util_system_chrome',
    category: ExampleCategory.utils,
    title: 'System Chrome',
    sourceFile: 'lib/utils/system_chrome_utils.dart',
    apis: [
      'setStatusBarColor',
      'setDarkStatusBar',
      'setLightStatusBar',
      'hideStatusBar',
      'showStatusBar'
    ],
    builder: systemChromeDemo,
  ),
  ExampleEntry(
    id: 'util_validator',
    category: ExampleCategory.utils,
    title: 'Password Validator',
    sourceFile: 'lib/utils/password_validator.dart',
    apis: [
      'Validator.hasMinimumLength',
      'hasMinimumUppercase',
      'hasMinimumLowercase',
      'hasMinimumNumericCharacters'
    ],
    builder: passwordValidatorDemo,
  ),
  ExampleEntry(
    id: 'util_numeral',
    category: ExampleCategory.utils,
    title: 'Numeral Utils',
    sourceFile: 'lib/utils/numberal_utils.dart',
    apis: ['Numeral.indian', 'Numeral.international'],
    builder: numeralUtilsDemo,
  ),
  ExampleEntry(
    id: 'util_common',
    category: ExampleCategory.utils,
    title: 'Common Functions',
    sourceFile: 'lib/utils/common_functions.dart',
    apis: ['hasMatch', 'randomString'],
    builder: commonFunctionsDemo,
  ),
  ExampleEntry(
    id: 'util_pattern',
    category: ExampleCategory.utils,
    title: 'RegExp Patterns',
    sourceFile: 'lib/utils/pattern.dart',
    apis: [
      'RegExpPatterns.url',
      'RegExpPatterns.email',
      'RegExpPatterns.phone',
      'RegExpPatterns.image'
    ],
    builder: patternUtilsDemo,
  ),
  ExampleEntry(
    id: 'util_flutter_helper',
    category: ExampleCategory.utils,
    title: 'Flutter Helper Utils',
    sourceFile: 'lib/utils/flutter_helper_utils.dart',
    apis: ['degreeToRadian', 'wait', 'getBytesFromAsset'],
    builder: flutterHelperUtilsDemo,
  ),
  ExampleEntry(
    id: 'util_printf',
    category: ExampleCategory.utils,
    title: 'Printf Console',
    sourceFile: 'lib/utils/console/printf_console.dart',
    apis: [
      'printf',
      'printfDebug',
      'printfInfo',
      'printfSuccess',
      'printfWarn',
      'printfError',
      'printfBox',
      'printfTable',
      'printfSeparator',
      'printHttpRequest',
      'printHttpResponse',
      'PrintfStyle',
      'PrintfConfig',
    ],
    builder: printfConsoleDemo,
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
  ExampleEntry(
    id: 'rxn_datetime',
    category: ExampleCategory.reactive,
    title: 'RxnDateTime',
    sourceFile: 'lib/reactive/rx_datetime.dart',
    apis: ['RxnDateTime', 'format', 'timeAgo', 'addDuration'],
    builder: rxnDatetimeDemo,
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

  // ── Live Sandbox (preserved live-only example code) ─────────────────────
  ExampleEntry(
    id: 'live_home',
    category: ExampleCategory.liveSandbox,
    title: 'Home Screen Sandbox',
    sourceFile: 'example/lib/home.dart',
    apis: ['HomeScreen', 'MyCustomTextField', 'AppButton'],
    builder: liveHomeSandboxDemo,
    description: 'Original live example home screen — not removed',
  ),
  ExampleEntry(
    id: 'live_custom_text_field',
    category: ExampleCategory.liveSandbox,
    title: 'MyCustomTextField',
    sourceFile: 'example/lib/widgets_example/my_custom_text_field.dart',
    apis: ['MyCustomTextField'],
    builder: liveCustomTextFieldDemo,
  ),
  ExampleEntry(
    id: 'live_pagination',
    category: ExampleCategory.liveSandbox,
    title: 'Pagination Standalone',
    sourceFile: 'example/lib/pagination_list_view_example.dart',
    apis: ['PaginationListViewExample', 'ListViewPagination'],
    builder: livePaginationStandaloneDemo,
    description: 'Standalone pagination screen preserved from live project',
  ),
];

ExampleEntry? findExampleById(String id) {
  for (final entry in exampleCatalog) {
    if (entry.id == id) return entry;
  }
  return null;
}
