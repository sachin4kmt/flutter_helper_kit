import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb

extension BuildContextExension on BuildContext {
  /// Returns the screen size.
  Size get size => MediaQuery.maybeOf(this)?.size ?? const Size(0, 0);

  /// return screen width
  double get width => size.width;

  /// return screen height
  double get height => size.height;

  /// return screen devicePixelRatio
  double get pixelRatio => MediaQuery.maybeOf(this)?.devicePixelRatio ?? 1.0;

  /// Returns the minimum screen size (width or height).
  double get minScreenSize => size.shortestSide;

  /// Returns the maximum screen size (width or height).
  double get maxScreenSize => size.longestSide;

  /// returns brightness
  Brightness get platformBrightness =>
      MediaQuery.maybeOf(this)?.platformBrightness ?? Brightness.light;

  /// Return the height of status bar
  double get statusBarHeight => MediaQuery.maybeOf(this)?.padding.top ?? 0.0;

  /// Return the height of navigation bar
  double get navigationBarHeight =>
      MediaQuery.maybeOf(this)?.padding.bottom ?? 0.0;

  /// Returns Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Returns Theme.of(context).textTheme
  TextTheme get textTheme => theme.textTheme;

  /// Returns DefaultTextStyle.of(context)
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  /// Returns Form.of(context)
  FormState? get formState => Form.of(this);

  /// Returns Scaffold.of(context)
  ScaffoldState? get scaffoldState => Scaffold.maybeOf(this);

  /// Returns Overlay.of(context)
  OverlayState? get overlayState => Overlay.maybeOf(this);

  /// Returns primaryColor Color
  Color get primaryColor => theme.primaryColor;

  /// Returns secondaryColor Color
  Color get secondaryColor => theme.colorScheme.secondary;

  /// Returns accentColor Color
  Color get accentColor => theme.colorScheme.secondary;

  /// Returns scaffoldBackgroundColor Color
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// Returns cardColor Color
  Color get cardColor => theme.cardColor;

  /// Returns dividerColor Color
  Color get dividerColor => theme.dividerColor;

  /// Returns dividerColor Color
  Color get iconColor => theme.iconTheme.color!;

  /// Request focus to given FocusNode
  void requestFocus(FocusNode focus) => FocusScope.of(this).requestFocus(focus);

  /// Request focus to given FocusNode
  void unFocus(FocusNode focus) => focus.unfocus();

  ///Hide Keyboard
  void unFocusKeyboard() => FocusScope.of(this).unfocus();

  ///Get  Named Route arguments
  dynamic get getArguments => ModalRoute.of(this)?.settings.arguments;

  // bool isPhone() => width < tabletBreakpointGlobal;

  // bool isTablet() => width < desktopBreakpointGlobal && width >= tabletBreakpointGlobal;

  // bool isDesktop() => width >= desktopBreakpointGlobal;

  Orientation get orientation =>
      MediaQuery.maybeOf(this)?.orientation ?? Orientation.portrait;

  ///This will return Orientation object and you can check is the landscape
  bool get isLandscape => orientation == Orientation.landscape;

  ///This will return Orientation object and you can check is the portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// [Route.isFirst], which returns true for routes for which [canPop] returns false.
  bool get canPop => Navigator.canPop(this);

  /// The type of `result`, if provided, must match the type argument of the class of the popped route (`T`).
  void pop<T extends Object>([T? result]) => Navigator.pop(this, result);

  /// Returns the current platform.
  ///
  /// The returned platform value can be one of the following:
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

  /// Returns `true` if the current platform is Linux.
  bool get isWeb => kIsWeb;

  ///To open the drawer, use either ScaffoldState.openDrawer
  void openDrawer() => Scaffold.of(this).openDrawer();

  ///To close the drawer, use either ScaffoldState.closeEndDrawer or Navigator.pop.
  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  ///? hide current SnackBar from build context
  void hideCurrentSnackBar() =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar();

  ///? remove current SnackBar from build context
  void removeCurrentSnackBar() =>
      ScaffoldMessenger.of(this).removeCurrentSnackBar();

  ///? remove all SnackBar from build context
  void clearSnackBars() => ScaffoldMessenger.of(this).clearSnackBars();

  ///? Show SnackBar from build context
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
