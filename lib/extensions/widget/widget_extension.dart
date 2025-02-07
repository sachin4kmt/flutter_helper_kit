import 'package:flutter/material.dart';

// Widget Extensions
extension WidgetExtension on Widget? {
  /// Wraps the widget inside a `SizedBox` with a custom height and width.
  ///
  /// ```dart
  /// Container().withSize(width: 100, height: 50);
  /// ```
  SizedBox withSize({double width = 0.0, double height = 0.0}) =>
      SizedBox(height: height, width: width, child: this);

  /// Wraps the widget inside a `SizedBox` with a custom width.
  ///
  /// ```dart
  /// Text("Hello").withWidth(200);
  /// ```
  SizedBox withWidth(double width) => SizedBox(width: width, child: this);

  /// Wraps the widget inside a `SizedBox` with a custom height.
  ///
  /// ```dart
  /// Text("Hello").withHeight(50);
  /// ```
  SizedBox withHeight(double height) => SizedBox(height: height, child: this);

  /// Controls the visibility of the widget.
  ///
  /// If `visible` is `false`, it returns a `SizedBox` or a custom default widget.
  ///
  /// ```dart
  /// Text("Visible").visible(true);
  /// ```
  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this! : (defaultWidget ?? const SizedBox());
  }

  /// Adds rounded corners to the widget using `ClipRRect` with custom radii.
  ///
  /// ```dart
  /// Container().cornerRadiusWithClipRRectOnly(topLeft: 10, bottomRight: 20);
  /// ```
  ClipRRect cornerRadiusWithClipRRectOnly({
    int bottomLeft = 0,
    int bottomRight = 0,
    int topLeft = 0,
    int topRight = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// Adds a uniform corner radius to the widget using `ClipRRect`.
  ///
  /// ```dart
  /// Container().cornerRadiusWithClipRRect(10);
  /// ```
  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: this,
    );
  }

  /// Adds animated opacity to the widget.
  ///
  /// ```dart
  /// Text("Fade").opacity(opacity: 0.5);
  /// ```
  Widget opacity({
    required double opacity,
    int durationInSecond = 1,
    Duration? duration,
  }) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration ?? const Duration(milliseconds: 500),
      child: this,
    );
  }

  /// Rotates the widget using `Transform.rotate`.
  ///
  /// ```dart
  /// Icon(Icons.refresh).rotate(angle: 0.5);
  /// ```
  Widget rotate({
    required double angle,
    bool transformHitTests = true,
    Offset? origin,
  }) {
    return Transform.rotate(
      origin: origin,
      angle: angle,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Scales the widget using `Transform.scale`.
  ///
  /// ```dart
  /// Icon(Icons.zoom_in).scale(scale: 1.5);
  /// ```
  Widget scale({
    required double scale,
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
  }) {
    return Transform.scale(
      scale: scale,
      origin: origin,
      alignment: alignment,
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Translates (moves) the widget using `Transform.translate`.
  ///
  /// ```dart
  /// Icon(Icons.arrow_forward).translate(offset: Offset(10, 0));
  /// ```
  Widget translate({
    required Offset offset,
    bool transformHitTests = true,
    Key? key,
  }) {
    return Transform.translate(
      offset: offset,
      transformHitTests: transformHitTests,
      key: key,
      child: this,
    );
  }

  /// Centers the widget within a `Center` widget.
  ///
  /// ```dart
  /// Text("Centered").center();
  /// ```
  Widget center({double? heightFactor, double? widthFactor}) {
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: this,
    );
  }

  /// Wraps the widget with an `InkWell` for tap functionality.
  ///
  /// ```dart
  /// Text("Tap me").onTap(() => print("Tapped!"));
  /// ```
  Widget onTap(
    Function? function, {
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? hoverColor,
    Color? highlightColor,
  }) {
    return InkWell(
      onTap: function as void Function()?,
      borderRadius: borderRadius,
      splashColor: splashColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      child: this,
    );
  }

  /* /// Launch a new screen
  Future<T?> launch<T>(BuildContext context,
      {bool isNewTask = false,
        PageRouteAnimation? pageRouteAnimation,
        Duration? duration}) async {
    if (isNewTask) {
      return await Navigator.of(context).pushAndRemoveUntil(
        buildPageRoute(
            this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
            (route) => false,
      );
    } else {
      return await Navigator.of(context).push(
        buildPageRoute(
            this!, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
      );
    }
  }
*/

  /// Wraps the widget with a `ShaderMask` using a list of colors.
  ///
  /// Example:
  /// ```dart
  /// Text('Gradient Text').withShaderMask([Colors.red, Colors.blue]);
  /// ```
  Widget withShaderMask(
    List<Color> colors, {
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return withShaderMaskGradient(
      LinearGradient(colors: colors),
      blendMode: blendMode,
    );
  }

  /// Wraps the widget with a `ShaderMask` using a custom `Gradient`.
  ///
  /// Example:
  /// ```dart
  /// Text('Gradient Text').withShaderMaskGradient(
  ///   LinearGradient(colors: [Colors.red, Colors.blue])
  /// );
  /// ```
  Widget withShaderMaskGradient(
    Gradient gradient, {
    BlendMode blendMode = BlendMode.srcATop,
  }) {
    return ShaderMask(
      shaderCallback: (rect) => gradient.createShader(rect),
      blendMode: blendMode,
      child: this,
    );
  }

  /// Wraps the widget with `Expanded`.
  ///
  /// Example:
  /// ```dart
  /// Container().expand();
  /// ```
  Widget expand({flex = 1}) => Expanded(flex: flex, child: this!);

  /// Wraps the widget with `Flexible`.
  ///
  /// Example:
  /// ```dart
  /// Container().flexible();
  /// ```
  Widget flexible({flex = 1, FlexFit? fit}) {
    return Flexible(flex: flex, fit: fit ?? FlexFit.loose, child: this!);
  }

  /// Wraps the widget with `FittedBox`.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('image.png').fit();
  /// ```
  Widget fit({BoxFit? fit, AlignmentGeometry? alignment}) {
    return FittedBox(
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
      child: this,
    );
  }

  /// Returns the widget if it is not null, otherwise returns a default value.
  ///
  /// Example:
  /// ```dart
  /// Widget? myWidget;
  /// myWidget.validate(value: Text('Default'));
  /// ```
  Widget validate({Widget value = const SizedBox()}) => this ?? value;

  /// Wraps the widget with a `Tooltip`.
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.info).withTooltip(msg: 'Information Icon');
  /// ```
  Widget withTooltip({required String msg}) {
    return Tooltip(message: msg, child: this);
  }

  /// Wraps the widget with a `RefreshIndicator` to make it refreshable.
  /// This assumes that the widget is inside a `Stack` with a `ListView`.
  ///
  /// Example:
  /// ```dart
  /// ListView().makeRefreshable();
  /// ```
  Widget makeRefreshable() {
    return Stack(children: [ListView(), this!]);
  }
}
