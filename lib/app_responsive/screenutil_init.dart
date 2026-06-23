part of 'app_responsive.dart';



typedef RebuildFactor = bool Function(MediaQueryData old, MediaQueryData data);
typedef ScreenUtilInitBuilder = Widget Function(BuildContext context, Widget? child);

abstract class RebuildFactors {
  static bool size(MediaQueryData old, MediaQueryData data) => old.size != data.size;
  static bool orientation(MediaQueryData old, MediaQueryData data) => old.orientation != data.orientation;
  static bool sizeAndViewInsets(MediaQueryData old, MediaQueryData data) => old.viewInsets != data.viewInsets;
  static bool change(MediaQueryData old, MediaQueryData data) => old != data;
  static bool always(MediaQueryData _, MediaQueryData data) => true;
  static bool none(MediaQueryData _, MediaQueryData data) => false;
}

abstract class FontSizeResolvers {
  static double width(num fontSize) => ScreenUtil.instance.setWidth(fontSize);
  static double height(num fontSize) => ScreenUtil.instance.setHeight(fontSize);
  static double radius(num fontSize) => ScreenUtil.instance.radius(fontSize);
  static double diameter(num fontSize) => ScreenUtil.instance.diameter(fontSize);
  static double diagonal(num fontSize) => ScreenUtil.instance.diagonal(fontSize);
}


class ScreenUtilInit extends StatefulWidget {
  const ScreenUtilInit({
    super.key,
    this.builder,
    this.child,
    this.rebuildFactor = RebuildFactors.size,
    this.designSize = ScreenUtil.defaultSize,
    this.splitScreenMode = false,
    this.minTextAdapt = false,
    this.useInheritedMediaQuery = false,
    this.ensureScreenSize = false,
    this.enableScaleWH,
    this.enableScaleText,
    this.responsiveWidgets,
    this.excludeWidgets,
    this.fontSizeResolver = FontSizeResolvers.width,
  });

  final ScreenUtilInitBuilder? builder;
  final Widget? child;
  final bool splitScreenMode;
  final bool minTextAdapt;
  final bool useInheritedMediaQuery;
  final bool ensureScreenSize;
  final bool Function()? enableScaleWH;
  final bool Function()? enableScaleText;
  final RebuildFactor rebuildFactor;
  final FontSizeResolver fontSizeResolver;
  final Size designSize;
  final Iterable<String>? responsiveWidgets;
  final Iterable<String>? excludeWidgets;

  @override
  State<ScreenUtilInit> createState() => _ScreenUtilInitState();
}

class _ScreenUtilInitState extends State<ScreenUtilInit> with WidgetsBindingObserver {
  final _canMarkedToBuild = HashSet<String>();
  final _excludedWidgets = HashSet<String>();
  MediaQueryData? _mediaQueryData;
  final _binding = WidgetsBinding.instance;
  final _screenSizeCompleter = Completer<void>();

  @override
  void initState() {
    if (widget.responsiveWidgets != null) _canMarkedToBuild.addAll(widget.responsiveWidgets!);
    if (widget.excludeWidgets != null) _excludedWidgets.addAll(widget.excludeWidgets!);

    ScreenUtil.enableScale(enableWH: widget.enableScaleWH, enableText: widget.enableScaleText);
    _validateSize().then(_screenSizeCompleter.complete);

    super.initState();
    _binding.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _revalidate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _revalidate();
  }

  MediaQueryData? _newData() {
    final view = View.maybeOf(context);
    if (view != null) return MediaQueryData.fromView(view);
    if (widget.useInheritedMediaQuery) return MediaQuery.of(context);
    return null;
  }

  Future<void> _validateSize() async {
    if (widget.ensureScreenSize) await ScreenUtil.ensureScreenSize();
  }

  void _markNeedsBuildIfAllowed(Element el) {
    final widgetName = el.widget.runtimeType.toString();
    if (_excludedWidgets.contains(widgetName)) return;
    final allowed = _canMarkedToBuild.contains(widgetName) || !(widgetName.startsWith('_') || flutterWidgets.contains(widgetName));
    if (allowed) el.markNeedsBuild();
  }

  void _updateTree(Element el) {
    _markNeedsBuildIfAllowed(el);
    el.visitChildren(_updateTree);
  }

  void _revalidate([void Function()? callback]) {
    final oldData = _mediaQueryData;
    final newData = _newData();
    if (newData == null) return;

    if (oldData == null || widget.rebuildFactor(oldData, newData)) {
      setState(() {
        _mediaQueryData = newData;
        _updateTree(context as Element);
        callback?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = _mediaQueryData;
    if (mq == null) return const SizedBox.shrink();

    void configureScreenUtil() {
      ScreenUtil.configure(
        data: mq,
        designSize: widget.designSize,
        splitScreenMode: widget.splitScreenMode,
        minTextAdapt: widget.minTextAdapt,
        fontSizeResolver: widget.fontSizeResolver,
      );
    }

    if (!widget.ensureScreenSize) {
      configureScreenUtil();
      return widget.builder?.call(context, widget.child) ?? widget.child!;
    }

    return FutureBuilder<void>(
      future: _screenSizeCompleter.future,
      builder: (c, snapshot) {
        configureScreenUtil();
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder?.call(context, widget.child) ?? widget.child!;
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _binding.removeObserver(this);
    super.dispose();
  }
}
