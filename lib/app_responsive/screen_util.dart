part of 'app_responsive.dart';



typedef FontSizeResolver = double Function(num fontSize);

class ScreenUtil {
  static const Size defaultSize = Size(360, 690);

  // Singleton instance
  static final ScreenUtil _instance = ScreenUtil._internal();
  factory ScreenUtil() => _instance;
  ScreenUtil._internal();

  // Public static getter
  static ScreenUtil get instance => _instance;

  // Scale flags
  static bool Function() _enableScaleWH = () => true;
  static bool Function() _enableScaleText = () => true;

  // Core properties
  late Size _uiSize;
  late Orientation _orientation;
  late bool _minTextAdapt = false;
  late MediaQueryData _data;
  late bool _splitScreenMode = false;
  FontSizeResolver? fontSizeResolver;

  Set<Element>? _elementsToRebuild;

  /// Enable scale
  static void enableScale({bool Function()? enableWH, bool Function()? enableText}) {
    _enableScaleWH = enableWH ?? () => true;
    _enableScaleText = enableText ?? () => true;
  }

  /// Ensure window size initialized
  static Future<void> ensureScreenSize([
    ui.FlutterView? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    await Future.doWhile(() {
      window ??= binding.platformDispatcher.implicitView;
      if (window == null || window!.physicalSize.isEmpty) {
        return Future.delayed(duration, () => true);
      }
      return false;
    });

    binding.allowFirstFrame();
  }

  /// Register elements to rebuild
  static void registerToBuild(BuildContext context, [bool withDescendants = false]) {
    (_instance._elementsToRebuild ??= {}).add(context as Element);

    if (withDescendants) {
      context.visitChildren((element) {
        registerToBuild(element, true);
      });
    }
  }

  /// Configure ScreenUtil
  static void configure({
    MediaQueryData? data,
    Size? designSize,
    bool? splitScreenMode,
    bool? minTextAdapt,
    FontSizeResolver? fontSizeResolver,
  }) {
    try {
      if (data != null) _instance._data = data;
      if (designSize != null) _instance._uiSize = designSize;
    } catch (_) {
      throw Exception('You must either use ScreenUtil.init or ScreenUtilInit first');
    }

    final MediaQueryData? deviceData = _instance._data.nonEmptySizeOrNull();
    final Size deviceSize = deviceData?.size ?? _instance._uiSize;

    final orientation = deviceData?.orientation ??
        (deviceSize.width > deviceSize.height ? Orientation.landscape : Orientation.portrait);

    _instance
      ..fontSizeResolver = fontSizeResolver ?? _instance.fontSizeResolver
      .._minTextAdapt = minTextAdapt ?? _instance._minTextAdapt
      .._splitScreenMode = splitScreenMode ?? _instance._splitScreenMode
      .._orientation = orientation;

    _instance._elementsToRebuild?.forEach((el) => el.markNeedsBuild());
  }

  /// Initialize ScreenUtil
  static void init(
      BuildContext context, {
        Size designSize = defaultSize,
        bool splitScreenMode = false,
        bool minTextAdapt = false,
        FontSizeResolver? fontSizeResolver,
      }) {
    final view = View.maybeOf(context);
    return configure(
      data: view != null ? MediaQueryData.fromView(view) : null,
      designSize: designSize,
      splitScreenMode: splitScreenMode,
      minTextAdapt: minTextAdapt,
      fontSizeResolver: fontSizeResolver,
    );
  }

  /// Ensure screen size and init
  static Future<void> ensureScreenSizeAndInit(
      BuildContext context, {
        Size designSize = defaultSize,
        bool splitScreenMode = false,
        bool minTextAdapt = false,
        FontSizeResolver? fontSizeResolver,
      }) async {
    await ensureScreenSize();
    if (!context.mounted) return;
    init(
      context,
      designSize: designSize,
      splitScreenMode: splitScreenMode,
      minTextAdapt: minTextAdapt,
      fontSizeResolver: fontSizeResolver,
    );
  }

  /// Accessors
   Orientation get orientation => _instance._orientation;
   TextScaler get textScaleFactor => _instance._data.textScaler;
   double? get pixelRatio => _instance._data.devicePixelRatio;
   double get screenWidth => _instance._data.size.width;
   double get screenHeight => _instance._data.size.height;
   double get statusBarHeight => _instance._data.padding.top;
   double get bottomBarHeight => _instance._data.padding.bottom;
   double get scaleWidth => !_enableScaleWH() ? 1 : screenWidth / _instance._uiSize.width;
   double get scaleHeight =>
      !_enableScaleWH() ? 1 : (_instance._splitScreenMode ? max(screenHeight, 700) : screenHeight) / _instance._uiSize.height;
  static double get scaleText =>
      !_enableScaleText() ? 1 : (_instance._minTextAdapt ? min(instance.scaleWidth, instance.scaleHeight) : instance.scaleWidth);

  /// Adaptation methods
   double setWidth(num width) => width * scaleWidth;
   double setHeight(num height) => height * scaleHeight;
   double radius(num r) => r * min(scaleWidth, scaleHeight);
   double diagonal(num d) => d * scaleHeight * scaleWidth;
/* <<<<<<<<<<<<<<  ✨ Windsurf Command ⭐ >>>>>>>>>>>>>>>> */
   /// The adaptation pixel is according to the larger of the current device's width and height,
   /// based on the design draft.
   ///
   /// The width or height of the design draft is divided by the width or height of the device to
   /// get the scale, and then the scale is multiplied by the size to be adapted to get the
   /// adapted size.
   ///
   /// [d] is the size of the design draft.
/* <<<<<<<<<<  739240f2-01c8-4911-865a-ae20d1e68393  >>>>>>>>>>> */
   double diameter(num d) => d * max(scaleWidth, scaleHeight);
  static double setSp(num fontSize) =>
      _instance.fontSizeResolver?.call(fontSize) ?? fontSize * scaleText;

  /// Device type
  static DeviceType deviceType(BuildContext context) {
    var deviceType = DeviceType.web;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    if (kIsWeb) {
      deviceType = DeviceType.web;
    } else {
      bool isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android;
      bool isTablet =
          (orientation == Orientation.portrait && screenWidth >= 600) ||
              (orientation == Orientation.landscape && screenHeight >= 600);

      if (isMobile) {
        deviceType = isTablet ? DeviceType.tablet : DeviceType.mobile;
      } else {
        switch (defaultTargetPlatform) {
          case TargetPlatform.linux:
            deviceType = DeviceType.linux;
            break;
          case TargetPlatform.macOS:
            deviceType = DeviceType.mac;
            break;
          case TargetPlatform.windows:
            deviceType = DeviceType.windows;
            break;
          case TargetPlatform.fuchsia:
            deviceType = DeviceType.fuchsia;
            break;
          default:
            break;
        }
      }
    }

    return deviceType;
  }

  /// Spacing helpers
  static SizedBox setVerticalSpacing(num height) => SizedBox(height: instance.setHeight(height));
  static SizedBox setVerticalSpacingFromWidth(num height) => SizedBox(height: instance.setWidth(height));
  static SizedBox setHorizontalSpacing(num width) => SizedBox(width: instance.setWidth(width));
  static SizedBox setHorizontalSpacingRadius(num width) => SizedBox(width: instance.radius(width));
  static SizedBox setVerticalSpacingRadius(num height) => SizedBox(height: instance.radius(height));
  static SizedBox setHorizontalSpacingDiameter(num width) => SizedBox(width: instance.diameter(width));
  static SizedBox setVerticalSpacingDiameter(num height) => SizedBox(height: instance.diameter(height));
  static SizedBox setHorizontalSpacingDiagonal(num width) => SizedBox(width: instance.diagonal(width));
  static SizedBox setVerticalSpacingDiagonal(num height) => SizedBox(height: instance.diagonal(height));
}

extension on MediaQueryData? {
  MediaQueryData? nonEmptySizeOrNull() {
    if (this?.size.isEmpty ?? true) {
      return null;
    } else {
      return this;
    }
  }
}

enum DeviceType { mobile, tablet, web, mac, windows, linux, fuchsia }
