part of 'app_responsive.dart';



class RSliverSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const RSliverSizedBox({
    super.key,
    this.height,
    this.width,
    this.child,
  });

  /// vertical space
  const RSliverSizedBox.vertical(
      double this.height, {
        super.key,
        this.child,
      })  : width = null;

  /// horizontal space (rare in slivers but kept for parity)
  const RSliverSizedBox.horizontal(
      double this.width, {
        super.key,
        this.child,
      })  : height = null;

  /// square space
  const RSliverSizedBox.square(
      double dimension, {
        super.key,
        this.child,
      })  : height = dimension,
        width = dimension;

  /// shrink
  const RSliverSizedBox.shrink({super.key})
      : height = 0,
        width = 0,
        child = null;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
