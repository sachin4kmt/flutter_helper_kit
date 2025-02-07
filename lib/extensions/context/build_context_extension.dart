import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb

extension BuildContextExension on BuildContext {
  /// Returns the screen size.
  /// This method returns the size of the screen using MediaQuery, which includes the width and height.
  /// If the MediaQuery context is unavailable, it returns a default size of (0, 0).
  Size get size => MediaQuery.maybeOf(this)?.size ?? const Size(0, 0);

  /// Returns the screen width.
  /// This property provides the width of the current screen using the size property.
  double get width => size.width;

  /// Returns the screen height.
  /// This property provides the height of the current screen using the size property.
  double get height => size.height;

  /// Returns the screen's devicePixelRatio.
  /// This property retrieves the device's pixel density. A higher value means more pixels per logical pixel.
  /// If MediaQuery is unavailable, it defaults to a ratio of 1.0.
  double get pixelRatio => MediaQuery.maybeOf(this)?.devicePixelRatio ?? 1.0;

  /// Returns the minimum screen size (either width or height).
  /// This property returns the smaller dimension between the width and height of the screen.
  double get minScreenSize => size.shortestSide;

  /// Returns the maximum screen size (either width or height).
  /// This property returns the larger dimension between the width and height of the screen.
  double get maxScreenSize => size.longestSide;

  /// Returns the current platform's brightness.
  /// This property returns the brightness of the platform (either light or dark) based on the system's settings.
  Brightness get platformBrightness =>
      MediaQuery.maybeOf(this)?.platformBrightness ?? Brightness.light;

  /// Returns the height of the status bar.
  /// This property retrieves the height of the system's status bar (e.g., the area with time and network indicators).
  /// If no MediaQuery context is available, it defaults to 0.0.
  double get statusBarHeight => MediaQuery.maybeOf(this)?.padding.top ?? 0.0;

  /// Returns the height of the navigation bar.
  /// This property retrieves the height of the system's navigation bar (e.g., the bar with back/home buttons).
  /// If no MediaQuery context is available, it defaults to 0.0.
  double get navigationBarHeight =>
      MediaQuery.maybeOf(this)?.padding.bottom ?? 0.0;

  /// Returns the current ThemeData of the context.
  /// This property retrieves the `ThemeData` of the current context,
  /// which contains various theme-related properties like colors, typography, and other styles.
  ThemeData get theme => Theme.of(this);

  /// Returns the textTheme of the current theme.
  /// This property provides access to the text styles defined in the current theme's `textTheme`.
  /// It can be used to retrieve predefined text styles like headline1, bodyText1, etc.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the DefaultTextStyle of the context.
  /// This property retrieves the default text style applied to the text in the widget tree.
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  /// Returns the FormState of the context, if available.
  /// This property retrieves the state of a `Form` widget if present in the widget tree.
  /// It allows for interacting with form validation, saving, or resetting.
  FormState? get formState => Form.of(this);

  /// Returns the ScaffoldState of the context, if available.
  /// This property retrieves the state of a `Scaffold` widget, enabling access to
  /// methods like opening/closing drawers, showing snackbars, or navigating.
  ScaffoldState? get scaffoldState => Scaffold.maybeOf(this);

  /// Returns the OverlayState of the context, if available.
  /// This property retrieves the state of the `Overlay` widget, allowing access to overlays
  /// for things like showing floating widgets or positioning other types of overlays.
  OverlayState? get overlayState => Overlay.maybeOf(this);

  /// Returns the primaryColor of the current theme.
  /// This property retrieves the primary color defined in the theme, which is typically used
  /// for main elements such as buttons, app bars, and other prominent UI components.
  Color get primaryColor => theme.primaryColor;

  /// Returns the secondaryColor of the current theme.
  /// This property retrieves the secondary color defined in the theme, often used for elements
  /// that need to complement the primary color, like accents and secondary UI components.
  Color get secondaryColor => theme.colorScheme.secondary;

  /// Returns the accentColor of the current theme.
  /// This property retrieves the accent color from the theme, typically used for highlighting
  /// interactive or focusable elements. In many themes, this is the same as the secondary color.
  Color get accentColor => theme.colorScheme.secondary;

  /// Returns the scaffoldBackgroundColor of the current theme.
  /// This property retrieves the background color of the `Scaffold`, which is usually applied
  /// to the main body of the app's layout.
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// Returns the cardColor of the current theme.
  /// This property retrieves the color applied to cards in the app, typically used for elements
  /// that need to stand out, such as cards or containers with elevated content.
  Color get cardColor => theme.cardColor;

  /// Returns the dividerColor of the current theme.
  /// This property retrieves the color used for dividers in the UI, typically applied to
  /// separating content or sections in lists, settings, or menus.
  Color get dividerColor => theme.dividerColor;

  /// Returns the iconColor of the current theme.
  /// This property retrieves the color applied to icons in the current theme.
  /// It is useful for setting the color of icons in buttons, menus, or toolbars.
  Color get iconColor => theme.iconTheme.color!;

  /// Requests focus on the given [FocusNode].
  /// This method moves the focus to the provided [focus] node,
  /// making it the active input field.
  void requestFocus(FocusNode focus) => FocusScope.of(this).requestFocus(focus);

  /// Unfocuses the given [FocusNode].
  /// This method removes focus from the provided [focus] node.
  void unFocus(FocusNode focus) => focus.unfocus();

  /// Hides the keyboard by unfocusing the current input field.
  /// This method is a shortcut to dismiss the keyboard by unfocusing
  /// the currently focused node.
  void unFocusKeyboard() => FocusScope.of(this).unfocus();

  /// Gets the arguments passed to the current named route.
  /// This property retrieves any arguments that were passed when
  /// navigating to the current route using `Navigator.pushNamed`.
  dynamic get getArguments => ModalRoute.of(this)?.settings.arguments;

  // Uncommented, these methods check the device type based on screen width.
  // bool isPhone() => width < tabletBreakpointGlobal;

  // bool isTablet() => width < desktopBreakpointGlobal && width >= tabletBreakpointGlobal;

  // bool isDesktop() => width >= desktopBreakpointGlobal;

  /// Gets the current screen orientation.
  /// This property retrieves the current device orientation,
  /// either `portrait` or `landscape`.
  Orientation get orientation =>
      MediaQuery.maybeOf(this)?.orientation ?? Orientation.portrait;

  /// Returns `true` if the current screen orientation is landscape.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns `true` if the current screen orientation is portrait.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns `true` if the current route can be popped (i.e., the current route
  /// is not the root route or the only route in the navigator stack).
  bool get canPop => Navigator.canPop(this);

  /// Pops the current route and optionally returns a result to the previous route.
  /// The [result] type should match the type expected by the previous route.
  void pop<T extends Object>([T? result]) => Navigator.pop(this, result);

  /// Returns the current platform as a [TargetPlatform].
  ///
  /// The returned platform can be one of the following:
  /// - [TargetPlatform.android]
  /// - [TargetPlatform.iOS]
  /// - [TargetPlatform.macOS]
  /// - [TargetPlatform.windows]
  /// - [TargetPlatform.fuchsia]
  /// - [TargetPlatform.linux]
  ///
  /// Example usage:
  /// ```dart
  /// TargetPlatform currentPlatform = context.platform;
  /// if (currentPlatform == TargetPlatform.iOS) {
  ///   print('Running on iOS');
  /// } else if (currentPlatform == TargetPlatform.android) {
  ///   print('Running on Android');
  /// }
  /// ```
  TargetPlatform get platform => Theme.of(this).platform;

  /// Returns `true` if the current platform is Android.
  bool get isAndroid => platform == TargetPlatform.android;

  /// Returns `true` if the current platform is iOS.
  bool get isIOS => platform == TargetPlatform.iOS;

  /// Returns `true` if the current platform is macOS.
  bool get isMacOS => platform == TargetPlatform.macOS;

  /// Returns `true` if the current platform is Windows.
  bool get isWindows => platform == TargetPlatform.windows;

  /// Returns `true` if the current platform is Fuchsia.
  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  /// Returns `true` if the current platform is Linux.
  bool get isLinux => platform == TargetPlatform.linux;

  /// Returns `true` if the current platform is Web.
  bool get isWeb => kIsWeb;

  /// Opens the app drawer using the current [ScaffoldState].
  /// This method triggers the opening of the main drawer,
  /// which is typically used for navigation.
  void openDrawer() => Scaffold.of(this).openDrawer();

  /// Opens the end drawer using the current [ScaffoldState].
  /// This method triggers the opening of the secondary drawer
  /// (if available), often used for additional options or settings.
  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  /// Hides the current SnackBar from the build context.
  /// This method dismisses the currently displayed SnackBar
  /// from the screen without removing it from the queue.
  void hideCurrentSnackBar() =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar();

  /// Removes the current SnackBar from the build context.
  /// This method removes the currently visible SnackBar and
  /// ensures no further SnackBars are displayed until new ones are added.
  void removeCurrentSnackBar() =>
      ScaffoldMessenger.of(this).removeCurrentSnackBar();

  /// Clears all SnackBars from the build context.
  /// This method removes all SnackBars that are in the queue,
  /// ensuring no SnackBars are displayed.
  void clearSnackBars() => ScaffoldMessenger.of(this).clearSnackBars();

  /// Displays a custom SnackBar from the build context with various customizable options.
  ///
  /// This method allows for a fully customized SnackBar to be shown, including control over
  /// appearance, duration, actions, and layout. It provides flexibility to display a wide
  /// variety of SnackBar styles with different content, animations, and behaviors.
  ///
  /// Parameters:
  /// - [key]: The optional key for the SnackBar widget.
  /// - [backgroundColor]: The background color of the SnackBar.
  /// - [elevation]: The elevation (shadow) of the SnackBar.
  /// - [margin]: The margin around the SnackBar.
  /// - [padding]: The padding within the SnackBar.
  /// - [width]: The width of the SnackBar.
  /// - [hitTestBehavior]: Determines the behavior of hit testing (default is `null`).
  /// - [behavior]: Defines how the SnackBar behaves. The default is `SnackBarBehavior.floating`.
  /// - [action]: The optional action button for the SnackBar.
  /// - [actionOverflowThreshold]: The threshold for action overflow (optional).
  /// - [showCloseIcon]: Whether or not to show a close icon on the SnackBar.
  /// - [closeIconColor]: The color of the close icon (if shown).
  /// - [animation]: An optional custom animation for the SnackBar.
  /// - [onVisible]: A callback function triggered when the SnackBar becomes visible.
  /// - [dismissDirection]: Direction to dismiss the SnackBar. Default is `DismissDirection.down`.
  /// - [clipBehavior]: Defines how the content is clipped. Default is `Clip.hardEdge`.
  /// - [duration]: Duration for how long the SnackBar will be visible. Default is 4 seconds.
  /// - [style]: The text style for the SnackBar.
  /// - [direction]: The text direction for the SnackBar.
  /// - [borderRadius]: The border radius of the SnackBar.
  /// - [horizontalPadding]: Horizontal padding inside the SnackBar. Default is 16.
  /// - [verticalPadding]: Vertical padding inside the SnackBar. Default is 8.
  /// - [leading]: The leading widget in the SnackBar (e.g., an icon).
  /// - [leadingPadding]: The padding between the leading widget and content. Default is 4.
  /// - [title]: The optional title widget to display in the SnackBar.
  /// - [description]: The optional description widget to display in the SnackBar.
  /// - [trailing]: The trailing widget, typically an icon or button.
  /// - [trailingPadding]: The padding between the trailing widget and content. Default is 4.
  void showSnackBar({
    Key? key,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    double? actionOverflowThreshold,
    bool? showCloseIcon,
    Color? closeIconColor,
    Animation<double>? animation,
    void Function()? onVisible,
    DismissDirection dismissDirection = DismissDirection.down,
    Clip clipBehavior = Clip.hardEdge,
    Duration duration = const Duration(seconds: 4),
    TextStyle? style,
    TextDirection? direction,
    BorderRadius? borderRadius,
    double horizontalPadding = 16,
    double verticalPadding = 8,
    Widget? leading,
    double leadingPadding = 4,
    Widget? title,
    Widget? description,
    Widget? trailing,
    double trailingPadding = 4,
  }) {
    try {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          padding: padding ??
              EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8)),
          backgroundColor: backgroundColor ?? primaryColor.withColorOpacity(.8),
          content: Row(
            children: [
              if (leading != null) leading,
              SizedBox(width: leadingPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (title != null) title,
                    if (title != null && description != null) 2.height(),
                    if (description != null) description
                  ],
                ),
              ),
              SizedBox(width: trailingPadding),
              if (trailing != null) trailing,
            ],
          ),
          duration: duration,
          elevation: elevation,
          margin: margin,
          width: width,
          // hitTestBehavior: hitTestBehavior,
          behavior: behavior,
          action: action,
          actionOverflowThreshold: actionOverflowThreshold,
          showCloseIcon: showCloseIcon,
          closeIconColor: closeIconColor,
          animation: animation,
          onVisible: onVisible,
          dismissDirection: dismissDirection,
          clipBehavior: clipBehavior,
          key: key,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('SnackBar Error $e');
      }
    }
  }
}
