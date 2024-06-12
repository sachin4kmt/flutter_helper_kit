part of flutter_helper_kit;

class DashDivider extends StatelessWidget {
  /// Creates a [DashDivider] widget.
  ///
  /// The [height] parameter defines the height of the divider.
  /// The [dashWidth] parameter defines the width of each dash.
  /// The [dashSpace] parameter defines the space between each dash.
  /// The [color] parameter defines the color of the dashes.
  const DashDivider({
    Key? key,
    this.height = 1,
    this.dashWidth = 10,
    this.dashSpace = 2,
    this.color,
  })  : assert(dashWidth >= 1.0 && dashWidth <= 10.0),
        assert(dashSpace >= 1.0 && dashSpace <= 10.0),
        super(key: key);

  /// The height of the divider.
  final double height;

  /// The width of each dash. Must be between 1.0 and 10.0.
  final double dashWidth;

  /// The space between each dash. Must be between 1.0 and 10.0.
  final double dashSpace;

  /// The color of the dashes. If not provided, it will use the theme's divider color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final defaultDashWidth = dashWidth;
        final dashHeight = height;
        final dashCount = (boxWidth / ((dashSpace) * defaultDashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: defaultDashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color ?? Theme.of(context).dividerColor,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}