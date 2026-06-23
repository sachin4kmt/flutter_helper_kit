part of 'animation.dart';



extension GlobalWidgetListAnimations on List<Widget> {
  // ===========================================================================
  // STAGGERED LIST ANIMATIONS
  // ===========================================================================

  /// 1. Staggered Vertical Slide (Up/Down)
  List<Widget> animateStaggeredList({int intervalMs = 80, int durationMs = 300, double beginY = 0.1, bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (index) {
      return this[index]
          .animate(delay: (index * intervalMs).ms)
          .fadeIn(duration: durationMs.ms)
          .slideY(begin: beginY, end: 0, duration: durationMs.ms);
    });
  }

  /// 2. Staggered Slide from Right
  List<Widget> animateStaggeredListRight({int intervalMs = 100, double begin = 0.2, int durationMs = 300, bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (index) {
      return this[index]
          .animate(delay: (index * intervalMs).ms)
          .fadeIn(duration: durationMs.ms)
          .slideX(begin: begin, end: 0, duration: durationMs.ms);
    });
  }

  /// 3. Staggered Slide from Left
  List<Widget> animateStaggeredListLeft({int intervalMs = 100, double begin = -0.2, int durationMs = 300, bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (index) {
      return this[index]
          .animate(delay: (index * intervalMs).ms)
          .fadeIn(duration: durationMs.ms)
          .slideX(begin: begin, end: 0, duration: durationMs.ms);
    });
  }

  /// 4. Apply staggered slide + fade animation from left
  List<Widget> animateStaggeredSlideFadeX({
    double offsetX = -0.3,
    int intervalMs = 80,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOut,
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .slideX(begin: offsetX, end: 0, duration: duration, curve: curve);
    });
  }

  /// 5. Apply staggered slide + fade animation from bottom
  List<Widget> animateStaggeredSlideFadeY({
    double offsetY = 0.2,
    int intervalMs = 80,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOut,
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .slideY(begin: offsetY, end: 0, duration: duration, curve: curve);
    });
  }

  /// 6. Items scale up from small to full size one by one
  List<Widget> animateStaggeredScale({
    double beginScale = 0.5,
    int intervalMs = 100,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutBack,
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .scale(begin: Offset(beginScale, beginScale), end: const Offset(1, 1), duration: duration, curve: curve);
    });
  }

  /// 7. Items reveal with a blur-to-clear effect
  List<Widget> animateStaggeredBlur({
    double beginBlur = 10.0,
    int intervalMs = 120,
    Duration duration = const Duration(milliseconds: 500),
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i].animate(delay: (i * intervalMs).ms).fadeIn(duration: duration).blurXY(begin: beginBlur, end: 0, duration: duration);
    });
  }

  /// 8. Items flip into view (X-axis rotation)
  List<Widget> animateStaggeredFlip({int intervalMs = 150, Duration duration = const Duration(milliseconds: 600), bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .flip(begin: -0.5, end: 0, duration: duration, curve: Curves.easeOut);
    });
  }

  /// 9. Adds a moving shimmer light effect to each item
  List<Widget> animateStaggeredShimmer({Color? color, int intervalMs = 200, bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i].animate(delay: (i * intervalMs).ms).shimmer(duration: 1500.ms, color: color ?? Colors.white.withColorOpacity(0.4));
    });
  }

  /// 10. STAGGERED BOUNCE (Very Organic feel)
  List<Widget> animateStaggeredBounce({int intervalMs = 100, Duration duration = const Duration(milliseconds: 600), bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .scale(begin: const Offset(0.7, 0.7), end: const Offset(1, 1), duration: duration, curve: Curves.elasticOut);
    });
  }

  /// 11. PERSPECTIVE 3D (Premium Card Entry)
  List<Widget> animateStaggered3D({int intervalMs = 150, Duration duration = const Duration(milliseconds: 800), bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1))
        ..animate(delay: (i * intervalMs).ms).custom(
          begin: 0.6,
          end: 0,
          duration: duration,
          builder: (context, value, child) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(value),
            alignment: Alignment.center,
            child: child,
          ),
        );
    });
  }

  /// 12. STAGGERED GLASS (Blur & Zoom)
  List<Widget> animateStaggeredGlass({
    double beginBlur = 15.0,
    int intervalMs = 120,
    Duration duration = const Duration(milliseconds: 500),
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .blurXY(begin: beginBlur, end: 0, duration: duration)
          .scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1), duration: duration);
    });
  }

  /// 13. STAGGERED SHAKE ENTRY
  List<Widget> animateStaggeredShake({int intervalMs = 100, bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i].animate(delay: (i * intervalMs).ms).fadeIn().shake(hz: 4, duration: 400.ms, curve: Curves.easeInOut);
    });
  }

  /// 14. STAGGERED ELASTIC SLIDE
  List<Widget> animateStaggeredElastic({
    double begin = 0.5,
    int intervalMs = 80,
    Duration duration = const Duration(milliseconds: 800),
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .slideX(begin: begin, end: 0, duration: duration, curve: Curves.elasticOut);
    });
  }

  /// 15. PERSPECTIVE FLIP IN
  List<Widget> animateStaggered3DFlip({int intervalMs = 120, Duration duration = const Duration(milliseconds: 600), bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .flipH(begin: -1, end: 0, duration: duration, curve: Curves.easeOutCubic, alignment: Alignment.center)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
    });
  }

  /// 16. SPIRAL ENTRANCE
  List<Widget> animateStaggeredSpiral({int intervalMs = 100, Duration duration = const Duration(milliseconds: 500), bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .rotate(begin: 0.5, end: 0, duration: duration, curve: Curves.easeOutBack)
          .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1));
    });
  }

  /// 17. SHIMMER GLOW
  List<Widget> animateStaggeredGlow({Color shimmerColor = Colors.white24, int intervalMs = 150, bool animate = true}) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i].animate(delay: (i * intervalMs).ms).shimmer(duration: 1800.ms, color: shimmerColor, curve: Curves.easeInOutSine);
    });
  }

  /// 18. ZOOM OUT ENTRANCE (Focus effect)
  List<Widget> animateStaggeredZoomFocus({
    int intervalMs = 120,
    Duration duration = const Duration(milliseconds: 500),
    bool animate = true,
  }) {
    if (!animate) return this;
    return List<Widget>.generate(length, (int i) {
      return this[i]
          .animate(delay: (i * intervalMs).ms)
          .fadeIn(duration: duration)
          .scale(begin: const Offset(1.5, 1.5), end: const Offset(1, 1), curve: Curves.easeOutExpo);
    });
  }

  /// 19. Morph Entrance (Staggered for List)
  List<Widget> animateMorphIn({int intervalMs = 100, bool animate = true}) {
    if (!animate) return this;
    return asMap().entries.map((entry) {
      final index = entry.key;
      final widget = entry.value;

      return widget
          .animate(delay: (index * intervalMs).ms)
          .fadeIn(duration: 500.ms)
          .scale(begin: const Offset(0.5, 1.5), end: const Offset(1, 1), curve: Curves.elasticOut, duration: 1000.ms);
    }).toList();
  }
}
