/// A comprehensive utility kit containing high-performance extensions,
/// production-ready pagination widgets, geometric squircle paths, and advanced formatters.
///
/// Modular imports (smaller compile surface):
/// - [flutter_helper_kit_extensions.dart]
/// - [flutter_helper_kit_widgets.dart]
/// - [flutter_helper_kit_animation.dart]
/// - [flutter_helper_kit_responsive.dart]
/// - [flutter_helper_kit_utils.dart]
library;

/// Extensions
export 'extensions/alignment/alignment_extensions.dart';
export 'extensions/bool/bool_extensions.dart';
export 'extensions/context/build_context_extension.dart';
export 'extensions/color/color_extension.dart';
export 'extensions/date/date_extension.dart';
export 'extensions/date/date_format.dart';
export 'extensions/number/double_extension.dart';
export 'extensions/duration/duration_extensions.dart';
export 'extensions/number/integer_extension.dart';
export 'extensions/list/list_extension.dart';
export 'extensions/list/list_null_extension.dart';
export 'extensions/function/listenable_extension.dart';
export 'extensions/map/map_extension.dart';
export 'extensions/number/number_extension.dart';
export 'extensions/number/smart_round_to_string.dart';
export 'extensions/random/random_extension.dart';
export 'extensions/function/scope_functions_extension.dart';
export 'extensions/string/string_extension.dart';
export 'extensions/string/string_case.dart';
export 'extensions/string/validation.dart';
export 'extensions/type_conversion.dart';
export 'extensions/widget/widget_extension.dart';
export 'extensions/widget/widget_list_extension.dart';
export 'extensions/widget/row_extension.dart';
export 'extensions/widget/column_extension.dart';
export 'extensions/set/set_extension.dart';
export 'extensions/list/iterable_extension.dart';
export 'extensions/list/list_num.dart';
export 'extensions/widget/border.dart';
export 'extensions/widget/padding.dart';

/// Formatter
export 'text_field/no_leading_space_formatter.dart';
export 'text_field/no_space_formatter.dart';

/// Utils
export 'utils/system_chrome_utils.dart';
export 'utils/system_ui_utils.dart';
export 'utils/common_functions.dart';
export 'utils/decorations.dart';
export 'utils/password_validator.dart';
export 'utils/ago_time.dart';
export 'utils/flutter_helper_utils.dart';
export 'utils/numberal_utils.dart';
export 'utils/random_image.dart';
export 'utils/random_picsum_image.dart';
export 'utils/map_custom_info_window.dart';
export 'utils/map_info_window_callback_adapter.dart';
export 'utils/close_icon_show_dialog.dart';
export 'utils/pattern.dart';

/// Reactive helpers
export 'reactive/rx_datetime.dart';

/// Responsive layout (ScreenUtil)
export 'app_responsive/app_responsive.dart';

/// Animation engine
export 'animation/animation.dart';

/// Core (vendored animate engine)
export 'core/flutter_animate/flutter_animate.dart';

/// Widgets
export 'widgets/hide_keyboard.dart';
export 'widgets/custom_indicator.dart';
export 'widgets/flutter_toast.dart';
export 'widgets/simmer.dart';
export 'widgets/widget_helper.dart';
export 'widgets/text_avatar.dart';
export 'widgets/dash_divider.dart';
export 'widgets/read_more_text.dart';
export 'widgets/read_more_enhanced.dart' hide TrimMode;
export 'widgets/app_button.dart';
export 'widgets/marquee_widget.dart';
export 'widgets/text_icon_widget.dart';
export 'widgets/rounded_checkbox_widget.dart';
export 'widgets/rating_bar_widget.dart';
export 'widgets/double_press_back_widget.dart';
export 'widgets/timer_builder.dart';
export 'widgets/separated_column.dart';
export 'widgets/space/sliver_space.dart';
export 'widgets/space/space.dart';
export 'widgets/flutter_list_view.dart';
export 'widgets/tap_safe_gesture.dart';
export 'widgets/sharp_corners/sharp.dart';
export 'widgets/flutter_tag/flutter_tag.dart';
export 'widgets/dotted_border_widget.dart';
export 'widgets/gradient_text.dart';
export 'widgets/list_view_pagination.dart';
export 'widgets/slider_button.dart';
export 'widgets/custom_banner.dart';
export 'widgets/center_text_divider.dart';
export 'widgets/password_strength_indicator/password_rules_enum.dart';
export 'widgets/password_strength_indicator/password_strength_enum.dart';
export 'widgets/password_strength_indicator/password_strength_indicator.dart';
export 'widgets/app_cupertino_action_sheet/app_cupertino_action_sheet.dart';
export 'widgets/app_cupertino_action_sheet/app_cupertino_dialog.dart';
export 'widgets/rolling_digit/rolling_digit.dart';
export 'widgets/rolling_digit/digit_count_animation.dart';
export 'widgets/ticket_clippers/edge_enum.dart';
export 'widgets/ticket_clippers/pointed_edge.dart';
export 'widgets/ticket_clippers/rounded_edge.dart';
export 'widgets/ticket_clippers/shadow_radius.dart';
export 'widgets/ticket_clippers/ticket_clipper.dart';
export 'widgets/ticket_clippers/ticket_edge.dart';
export 'widgets/ticket_clippers/ticket_painter.dart';

/// CustomPainter
export 'custom_painter/google_logo_painter.dart';

/// CallBack Custom Type
export 'utils/type_def.dart';

/// Avatar & Glow UI Components
export 'widgets/avatar_glow/avatar_glow.dart';
export 'widgets/avatar_glow/avatar_glow_multi_color.dart';
export 'widgets/avatar_glow/outline_glow.dart';
export 'widgets/avatar_glow/outline_glow_multi_color.dart';
