part of 'animation.dart';



// 1. Enum update: Saare naye constants yahan add kiye hain
enum ListAnimationType {
  slideY,
  slideX,
  scale,
  blur,
  flip,
  perspective,
  glass,
  entrance,
  elastic,
  rotate3D,
  shimmerReveal,
  wheel,
  zoomOut,
  bounceIn,
  slideSkew,
  spiral,
  reveal,
  blurSlide,
  morph,
}

class AnimatedListWrapper extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int? crossAxisCount;
  final ListAnimationType animationType;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final int intervalMs;
  final int durationMs;
  final Axis scrollDirection;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool animate; // ✅ Naya Parameter: Global Animation Toggle

  const AnimatedListWrapper({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.isLoading = false,
    this.loadingWidget,
    this.separatorBuilder,
    this.crossAxisCount,
    this.animationType = ListAnimationType.slideY,
    this.spacing = 10,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.intervalMs = 60,
    this.durationMs = 400,
    this.scrollDirection = Axis.vertical,
    this.animate = true, // ✅ Default value: true
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && loadingWidget != null) {
      return _buildLoadingState();
    }

    if (crossAxisCount != null) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount!,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
        ),
        scrollDirection: scrollDirection,
        itemCount: itemCount,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemBuilder: (ctx, index) => _buildAnimatedItem(ctx, index),
      );
    }

    if (separatorBuilder != null) {
      return ListView.separated(
        itemCount: itemCount,
        scrollDirection: scrollDirection,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        separatorBuilder: separatorBuilder!,
        itemBuilder: (ctx, index) => _buildAnimatedItem(ctx, index),
      );
    }

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemBuilder: (ctx, index) => _buildAnimatedItem(ctx, index),
    );
  }

  // Shimmer Effect builder
  Widget _buildLoadingState() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: shrinkWrap,
      padding: padding,
      scrollDirection: scrollDirection,
      itemBuilder: (context, index) {
        // ✅ Agar animate false hai toh normal widget return hoga bina shimmer ke
        if (!animate) return loadingWidget!;

        return loadingWidget!
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms, color: Colors.grey.withColorOpacity(0.3));
      },
    );
  }

  Widget _buildAnimatedItem(BuildContext context, int index) {
    Widget child = itemBuilder(context, index);

    // ✅ Agar animate flag false hai, toh direct child return kar do
    if (!animate) return child;

    var delay = (index * intervalMs).ms;
    if (index > 10) delay = 0.ms;

    switch (animationType) {
      case ListAnimationType.morph:
        return child
            .animate(delay: delay)
            .fadeIn(duration: 500.ms)
            .scale(
          begin: const Offset(0.5, 1.5),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
          duration: 1000.ms,
        );
      case ListAnimationType.bounceIn:
        return child
            .animate(delay: delay)
            .scale(begin: const Offset(0.3, 0.3), end: const Offset(1, 1), duration: 600.ms, curve: Curves.bounceOut)
            .fadeIn(duration: 400.ms);

      case ListAnimationType.slideSkew:
        return child
            .animate(delay: delay)
            .fadeIn(duration: durationMs.ms)
            .slideX(begin: 0.3, end: 0, curve: Curves.easeOutCubic)
            .custom(
          begin: 0.2,
          end: 0,
          builder: (_, v, c) => Transform(transform: Matrix4.skewX(v), child: c),
        );

      case ListAnimationType.spiral:
        return child
            .animate(delay: delay)
            .fadeIn(duration: 500.ms)
            .scale(begin: const Offset(0, 0), end: const Offset(1, 1), curve: Curves.easeOutBack)
            .rotate(begin: 0.5, end: 0);

      case ListAnimationType.reveal:
        return child
            .animate(delay: delay)
            .fadeIn(duration: 300.ms)
            .moveY(begin: 50, end: 0, curve: Curves.easeOutExpo)
            .scaleY(begin: 0, end: 1, alignment: Alignment.bottomCenter);

      case ListAnimationType.blurSlide:
        return child
            .animate(delay: delay)
            .blurXY(begin: 10, end: 0, duration: 600.ms)
            .slideY(begin: 0.5, end: 0, curve: Curves.easeOutCubic)
            .fadeIn();

      case ListAnimationType.elastic:
        return child.animate(delay: delay).fadeIn().slideX(begin: 0.5, end: 0, curve: Curves.elasticOut, duration: 800.ms);

      case ListAnimationType.rotate3D:
        return child
            .animate(delay: delay)
            .fadeIn()
            .custom(
          begin: -0.5,
          end: 0,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(v),
            alignment: Alignment.centerLeft,
            child: c,
          ),
        );

      case ListAnimationType.shimmerReveal:
        return child.animate(delay: delay).fadeIn().shimmer(delay: 200.ms, color: Colors.white24).moveX(begin: -20);

      case ListAnimationType.wheel:
        return child.animate(delay: delay).fadeIn().scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack).rotate(begin: 0.1);

      case ListAnimationType.zoomOut:
        return child.animate(delay: delay).fadeIn().scale(begin: const Offset(1.5, 1.5), curve: Curves.easeOutExpo);

      case ListAnimationType.perspective:
        return child
            .animate(delay: delay)
            .fadeIn()
            .custom(
          begin: 0.5,
          end: 0,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(v),
            alignment: Alignment.center,
            child: c,
          ),
        );

      case ListAnimationType.glass:
        return child.animate(delay: delay).fadeIn().blurXY(begin: 15, end: 0).scale(begin: const Offset(0.9, 0.9));

      case ListAnimationType.entrance:
        return child.animate(delay: delay).moveY(begin: 100, curve: Curves.easeOutBack).fadeIn();

      case ListAnimationType.slideY:
        return child.animate(delay: delay).fadeIn().slideY(begin: 0.2);

      case ListAnimationType.slideX:
        return child.animate(delay: delay).fadeIn().slideX(begin: 0.2);

      case ListAnimationType.scale:
        return child.animate(delay: delay).fadeIn().scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);

      case ListAnimationType.blur:
        return child.animate(delay: delay).fadeIn().blurXY(begin: 10);

      case ListAnimationType.flip:
        return child.animate(delay: delay).fadeIn().flipH(begin: 1);
    }
  }
}