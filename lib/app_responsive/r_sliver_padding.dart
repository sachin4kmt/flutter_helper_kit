part of 'app_responsive.dart';



class RSliverPadding extends SingleChildRenderObjectWidget {
  /// Creates an adapt sliver padding widget.
  ///
  /// The [padding] argument must not be null.
  const RSliverPadding({
    super.key,
    required this.padding,
    Widget? sliver,
  }) : super(child: sliver);

  /// The amount of space by which to inset the sliver.
  final EdgeInsets padding;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: padding is REdgeInsets ? padding : padding.r,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context,
      RenderSliverPadding renderObject,
      ) {
    renderObject
      ..padding = padding is REdgeInsets ? padding : padding.r
      ..textDirection = Directionality.maybeOf(context);
  }
}

