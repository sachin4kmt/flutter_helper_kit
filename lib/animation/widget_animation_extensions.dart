part of 'animation.dart';



/// PAYDROP ULTIMATE ANIMATION ENGINE (UPDATED WITH REPEAT LOGIC)
/// Rules:
/// 1. All names start with 'animateWidget'.
/// 2. Sequential indexing (1 to 75).
/// 3. Standardized parameters: durationMs, delayMs, repeat, animate.
extension AnimateOnWidget on Widget {
  // Helper internal function to handle repetition logic
  Animate _baseAnimate({int delayMs = 0, bool repeat = false, bool reverse = false}) {
    return animate(
      delay: delayMs.ms,
      onPlay: (controller) {
        if (repeat) controller.repeat(reverse: reverse);
      },
    );
  }

  // ===========================================================================
  // GROUP 1: ENTRANCE ANIMATIONS (Index 1-10)
  // ===========================================================================

  /// 1. Elastic Entrance
  Widget animateWidgetElasticEntry({int delayMs = 0, int durationMs = 800, double begin = 0.5, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: 400.ms).slideX(begin: begin, end: 0, duration: durationMs.ms, curve: Curves.elasticOut);
  }

  /// 2. 3D Perspective Flip (Horizontal)
  Widget animateWidgetPerspectiveFlip({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: durationMs.ms)
        .custom(
          begin: 0.5,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateX(v),
            alignment: Alignment.center,
            child: c,
          ),
        );
  }

  /// 3. Glass Reveal (Blur & Scale)
  Widget animateWidgetGlassReveal({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: durationMs.ms)
        .blurXY(begin: 15, end: 0, duration: durationMs.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), curve: Curves.easeOutCubic);
  }

  /// 4. Spiral Entry
  Widget animateWidgetSpiralIn({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: durationMs.ms)
        .rotate(begin: 0.5, end: 0, duration: durationMs.ms, curve: Curves.easeOutBack)
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1));
  }

  /// 5. Focus Zoom
  Widget animateWidgetZoomFocus({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: durationMs.ms).scale(begin: const Offset(1.8, 1.8), end: const Offset(1, 1), curve: Curves.easeOutExpo);
  }

  /// 6. Skew Entry
  Widget animateWidgetSkewIn({int delayMs = 0, double beginSkew = 0.2, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.2, end: 0)
        .custom(
          begin: beginSkew,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeOut,
          builder: (_, v, c) => Transform(transform: Matrix4.skewX(v), child: c),
        );
  }

  /// 7. Magazine Slide
  Widget animateWidgetMagazineSlide({int delayMs = 0, int durationMs = 700, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 1.5, end: 0, duration: durationMs.ms, curve: Curves.decelerate)
        .scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1), duration: durationMs.ms);
  }

  /// 8. Wing Entry
  Widget animateWidgetWingEntry({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat).fadeIn().custom(
      begin: 1.5,
      end: 0,
      duration: durationMs.ms,
      builder: (_, v, c) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(v),
        alignment: Alignment.centerLeft,
        child: c,
      ),
    );
  }

  /// 9. Slide Fade Entrance
  Widget animateWidgetSlideFade({int delayMs = 0, int durationMs = 400, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: durationMs.ms).slideY(begin: 0.2, end: 0.0, duration: durationMs.ms);
  }

  /// 10. Drop Bounce
  Widget animateWidgetDropBounce({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).slideY(begin: -1.0, end: 0.0, duration: durationMs.ms, curve: Curves.bounceOut).fadeIn();
  }

  // ===========================================================================
  // GROUP 2: INTERACTION & FEEDBACK (Index 11-20)
  // ===========================================================================

  /// 11. Success Pop
  Widget animateWidgetSuccessPop({int delayMs = 0, int durationMs = 400, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .scale(begin: const Offset(0.7, 0.7), end: const Offset(1.1, 1.1), duration: durationMs.ms, curve: Curves.easeOut)
        .then()
        .scale(begin: const Offset(1.1, 1.1), end: const Offset(1.0, 1.0), duration: 200.ms, curve: Curves.bounceOut);
  }

  /// 12. Reward Bloom
  Widget animateWidgetRewardBloom({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .scale(begin: Offset.zero, end: const Offset(1, 1), duration: durationMs.ms, curve: Curves.elasticOut)
        .rotate(begin: -0.2, end: 0, duration: durationMs.ms);
  }

  /// 13. Error Shake
  Widget animateWidgetErrorShake({required bool trigger, Color color = Colors.red, bool repeat = false, bool animate = true}) {
    if (!animate || !trigger) return this;
    return _baseAnimate(repeat: repeat)
        .shakeX(hz: 10, duration: 500.ms)
        .custom(
          duration: 500.ms,
          builder: (_, v, c) => Container(
            decoration: BoxDecoration(boxShadow: [BoxShadow(color: color.withColorOpacity(0.2 * (1 - v)), blurRadius: 10)]),
            child: c,
          ),
        );
  }

  /// 14. Jelly Effect
  Widget animateWidgetJelly({int durationMs = 300, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat)
        .scale(begin: const Offset(1, 1), end: const Offset(1.1, 0.9), duration: (durationMs / 2).ms)
        .then()
        .scale(begin: const Offset(1.1, 0.9), end: const Offset(1, 1), duration: (durationMs / 2).ms, curve: Curves.elasticOut);
  }

  /// 15. Wiggle
  Widget animateWidgetWiggle({int delayMs = 0, int durationMs = 200, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
      reverse: true,
    ).rotate(begin: -0.05, end: 0.05, curve: Curves.easeInOut, duration: durationMs.ms);
  }

  /// 16. Shake X
  Widget animateWidgetShakeX({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat).shake(hz: 4, curve: Curves.easeInOut, duration: durationMs.ms);
  }

  /// 17. Magnetic Pull
  Widget animateWidgetMagnetic({int durationMs = 550, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat)
        .scale(begin: const Offset(1, 1), end: const Offset(0.92, 0.92), duration: 150.ms, curve: Curves.easeOut)
        .then()
        .scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1), duration: 400.ms, curve: Curves.elasticOut);
  }

  /// 18. Hover Scale
  Widget animateWidgetHoverScale({int durationMs = 300, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: _baseAnimate(repeat: repeat, reverse: true).scaleXY(begin: 1.0, end: 1.03, duration: durationMs.ms, curve: Curves.easeInOut),
    );
  }

  /// 19. Toast Entry
  Widget animateWidgetToastEntry({int delayMs = 0, int durationMs = 400, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).slideY(begin: 0.5, end: 0, duration: durationMs.ms, curve: Curves.easeOutBack).fadeIn();
  }

  /// 20. Tap Feedback Detector
  Widget animateWidgetTapFeedback({required VoidCallback? onTap, TapEffect? effects, bool animate = true}) {
    if (!animate) return InkWell(onTap: onTap, child: this);
    return AnimatedGestureDetector(onTap: onTap, effectPreset: effects, child: this);
  }

  // ===========================================================================
  // GROUP 3: LOOPING & DYNAMIC (Index 21-30)
  // ===========================================================================

  /// 21. Neon Pulse (Breathe)
  Widget animateWidgetNeonPulse({Color color = Colors.blue, int durationMs = 1500, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true).custom(
      duration: durationMs.ms,
      builder: (_, v, c) => Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: color.withColorOpacity(0.3 * v), blurRadius: 20 * v, spreadRadius: 2 * v)],
        ),
        child: c,
      ),
    );
  }

  /// 22. Shimmer Glow
  Widget animateWidgetShimmerGlow({Color color = Colors.white24, int durationMs = 1800, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).shimmer(duration: durationMs.ms, color: color, curve: Curves.easeInOutSine);
  }

  /// 23. Attention Magnet
  Widget animateWidgetAttention({int durationMs = 1000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true)
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: durationMs.ms)
        .shimmer(delay: 2000.ms, duration: durationMs.ms);
  }

  /// 24. Breathe (Scale Cycle)
  Widget animateWidgetBreathe({int durationMs = 1500, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true).scaleXY(begin: 1.0, end: 1.03, duration: durationMs.ms, curve: Curves.easeInOutSine);
  }

  /// 25. Pulse (Heartbeat)
  Widget animateWidgetPulse({int delayMs = 0, int durationMs = 600, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
      reverse: true,
    ).scaleXY(begin: 1.0, end: 1.05, duration: durationMs.ms, curve: Curves.easeInOut);
  }

  /// 26. Float Up/Down
  Widget animateWidgetFloatUp({int delayMs = 0, int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
      reverse: true,
    ).slideY(begin: 0, end: -0.03, duration: durationMs.ms, curve: Curves.easeInOut);
  }

  /// 27. Typing Dots Animation
  Widget animateWidgetTypingDots({int delayMs = 0, int durationMs = 300, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
      reverse: true,
    ).scaleXY(begin: 0.8, end: 1.2, duration: durationMs.ms, curve: Curves.easeInOut);
  }

  /// 28. Float with Shadow
  Widget animateWidgetFloatWithShadow({int durationMs = 1500, Color shadowColor = Colors.black, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true)
        .moveY(begin: 0, end: -10, duration: durationMs.ms, curve: Curves.easeInOut)
        .custom(
          duration: durationMs.ms,
          builder: (_, v, c) => Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: shadowColor.withColorOpacity(0.1 * (1 - v)), blurRadius: 10 * v, offset: Offset(0, 15 * v))],
            ),
            child: c,
          ),
        );
  }

  /// 29. Notification Ripple
  Widget animateWidgetNotifyRipple({Color color = Colors.redAccent, int durationMs = 1500, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).custom(
      duration: durationMs.ms,
      builder: (_, v, c) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withColorOpacity(0.4 * (1 - v)), blurRadius: 20 * v, spreadRadius: 10 * v)],
        ),
        child: c,
      ),
    );
  }

  /// 30. Ghost Float (Slow)
  Widget animateWidgetGhostFloat({int durationMs = 3000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      repeat: repeat,
      reverse: true,
    ).moveY(begin: 0, end: -15, duration: durationMs.ms, curve: Curves.easeInOutQuad).blurXY(begin: 0, end: 2, duration: durationMs.ms);
  }

  // ===========================================================================
  // GROUP 4: FINTECH & PREMIUM (Index 31-45)
  // ===========================================================================

  /// 31. Gold Shimmer
  Widget animateWidgetGoldShimmer({Color color = const Color(0xFFFFD700), int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).shimmer(duration: durationMs.ms, color: color.withColorOpacity(0.3), stops: [0, 0.5, 1]);
  }

  /// 32. Cyber Jitter Reveal
  Widget animateWidgetCyberJitter({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: 200.ms).shakeX(amount: 5, hz: 10, duration: durationMs.ms).moveX(begin: 20, end: 0);
  }

  /// 33. Origami Vertical Fold
  Widget animateWidgetOrigamiFold({int delayMs = 0, int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: -1.5,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeOutBack,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(v),
            alignment: Alignment.topCenter,
            child: c,
          ),
        );
  }

  /// 34. Liquid Slide (Modern Perspective)
  Widget animateWidgetLiquidSlide({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 1.0,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeInOutQuart,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..setEntry(0, 1, v * 0.3)
              ..setTranslationRaw(v * 200, 0, 0),
            child: c,
          ),
        );
  }

  /// 35. Stamp Impact
  Widget animateWidgetStamp({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 200.ms)
        .scale(begin: const Offset(2.0, 2.0), end: const Offset(1, 1), curve: Curves.easeInCirc, duration: durationMs.ms)
        .then()
        .shake(hz: 2, duration: 200.ms);
  }

  /// 36. Digital Glitch Flicker
  Widget animateWidgetDigitalGlitch({int durationMs = 200, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true)
        .custom(
          duration: durationMs.ms,
          builder: (_, v, c) => Transform.translate(
            offset: Offset(v * 2, -v * 1),
            child: Opacity(opacity: 0.9 + (v * 0.1), child: c),
          ),
        )
        .then(delay: 2000.ms);
  }

  /// 37. Morph Entrance
  Widget animateWidgetMorphIn({int delayMs = 0, int durationMs = 1000, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 500.ms)
        .scale(begin: const Offset(0.5, 1.5), end: const Offset(1, 1), curve: Curves.elasticOut, duration: durationMs.ms);
  }

  /// 38. Scanner Beam (QR Style)
  Widget animateWidgetScannerBeam({Color beamColor = Colors.blueAccent, int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).custom(
      duration: durationMs.ms,
      builder: (_, v, c) => Stack(
        children: [
          c,
          Positioned(
            top: v * 100,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              decoration: BoxDecoration(boxShadow: [BoxShadow(color: beamColor, blurRadius: 10, spreadRadius: 2)]),
            ),
          ),
        ],
      ),
    );
  }

  /// 39. Coin Spin (Y-Axis)
  Widget animateWidgetCoinSpin({int delayMs = 0, int durationMs = 1000, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat).flipH(begin: 0, end: 2, duration: durationMs.ms, curve: Curves.easeInOutQuart);
  }

  /// 40. Reveal Door (Vertical)
  Widget animateWidgetRevealDoor({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).scaleY(begin: 0, end: 1, alignment: Alignment.topCenter, duration: durationMs.ms, curve: Curves.easeOutQuart).fadeIn();
  }

  /// 41. Credit Card Deal (Staggered)
  Widget animateWidgetCardDeal({int index = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: index * 100, repeat: repeat)
        .moveY(begin: 300, end: 0, curve: Curves.easeOutQuart, duration: durationMs.ms)
        .rotate(begin: 0.1, end: 0, duration: durationMs.ms)
        .fadeIn();
  }

  /// 42. Glass Morph Glow
  Widget animateWidgetGlassGlow({Color glowColor = Colors.amberAccent, int durationMs = 3000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true).custom(
      duration: durationMs.ms,
      builder: (_, v, c) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: glowColor.withColorOpacity(0.2 * (1 - (v - 0.5).abs() * 2)), blurRadius: 20, spreadRadius: 2)],
        ),
        child: c,
      ),
    );
  }

  /// 43. Page Flip (3D)
  Widget animateWidgetPageFlip({int delayMs = 0, int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .custom(
          begin: 1.5,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeOutQuart,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(v),
            alignment: Alignment.center,
            child: c,
          ),
        )
        .fadeIn();
  }

  /// 44. Cyber Scanner Sweep
  Widget animateWidgetCyberScanner({Color color = Colors.cyanAccent, int durationMs = 1500, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).custom(
      duration: durationMs.ms,
      builder: (_, v, c) => LayoutBuilder(
        builder: (ctx, cons) => Stack(
          alignment: Alignment.center,
          children: [
            c,
            Positioned(
              bottom: v * cons.maxHeight,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: (1 - v).clamp(0, 1),
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: color, blurRadius: 15, spreadRadius: 4),
                      BoxShadow(color: color.withColorOpacity(0.5), blurRadius: 30, spreadRadius: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 45. Coin Jump & Spin
  Widget animateWidgetCoinJump({int delayMs = 0, int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .moveY(begin: 0, end: -50, duration: (durationMs / 2).ms, curve: Curves.easeOut)
        .then()
        .moveY(begin: -50, end: 0, duration: (durationMs / 2).ms, curve: Curves.bounceOut)
        .flipH(begin: 0, end: 1, duration: durationMs.ms);
  }

  // ===========================================================================
  // GROUP 5: DATA VISUALIZATION (Index 46-55)
  // ===========================================================================

  /// 46. Bar Grow
  Widget animateWidgetBarGrow({int delayMs = 0, int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .scaleY(begin: 0, end: 1, duration: durationMs.ms, curve: Curves.easeOutBack, alignment: Alignment.bottomCenter);
  }

  /// 47. Line Trace
  Widget animateWidgetLineTrace({int delayMs = 0, int durationMs = 1500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 300.ms)
        .custom(
          duration: durationMs.ms,
          curve: Curves.easeInOutQuart,
          builder: (_, v, c) => ClipRect(
            child: Align(alignment: Alignment.centerLeft, widthFactor: v, child: c),
          ),
        );
  }

  /// 48. Data Point Pop
  Widget animateWidgetPointPop({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).scale(begin: Offset.zero, end: const Offset(1, 1), duration: durationMs.ms, curve: Curves.elasticOut);
  }

  /// 49. Wave Flow (Loop)
  Widget animateWidgetWaveFlow({int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true)
        .moveY(begin: 0, end: -5, duration: durationMs.ms, curve: Curves.easeInOutSine)
        .moveX(begin: -2, end: 2, duration: (durationMs * 0.75).toInt().ms, curve: Curves.easeInOutSine);
  }

  /// 50. Chart Label Overlay
  Widget animateWidgetChartLabel({int delayMs = 0, int durationMs = 400, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: durationMs.ms).slideY(begin: 0.5, end: 0, curve: Curves.easeOutBack);
  }

  /// 51. Pie Slice Rotate
  Widget animateWidgetPieSlice({int delayMs = 0, int durationMs = 1000, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .rotate(begin: -0.2, end: 0, duration: durationMs.ms, curve: Curves.easeOutQuart)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutCubic)
        .fadeIn();
  }

  /// 52. Liquid Wave Reveal
  Widget animateWidgetLiquidWave({int delayMs = 0, int durationMs = 1000, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.7, 1.3), end: const Offset(1, 1), curve: Curves.elasticOut, duration: durationMs.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack);
  }

  /// 53. Progress Infill
  Widget animateWidgetProgressFill({int delayMs = 0, int durationMs = 1000, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: 400.ms).scaleX(begin: 0, end: 1, alignment: Alignment.centerLeft, duration: durationMs.ms, curve: Curves.easeInOut);
  }

  /// 54. Counter Flip
  Widget animateWidgetCounterFlip({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).flipV(begin: 0.5, end: 0, duration: durationMs.ms, curve: Curves.easeOutBack).fadeIn();
  }

  /// 55. Insight Reveal
  Widget animateWidgetInsightReveal({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).fadeIn(duration: durationMs.ms).blurXY(begin: 10, end: 0).slideX(begin: 0.1, end: 0);
  }

  // ===========================================================================
  // GROUP 6: TRANSFORMATIONS & SHIMMERS (Index 56-75)
  // ===========================================================================

  /// 56. 3D Tilt Entrance
  Widget animateWidget3DTilt({int delayMs = 0, int durationMs = 600, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat).fadeIn().custom(
      begin: 0.1,
      end: 0,
      duration: durationMs.ms,
      curve: Curves.easeOutBack,
      builder: (_, v, c) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(v)
          ..rotateX(v),
        alignment: Alignment.center,
        child: c,
      ),
    );
  }

  /// 57. Border Glow Breathe
  Widget animateWidgetBorderGlow({Color color = Colors.greenAccent, int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true).custom(
      duration: durationMs.ms,
      builder: (_, v, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withColorOpacity(0.1 + (0.5 * v)), width: 1 + (2 * v)),
        ),
        child: child,
      ),
    );
  }

  /// 58. Color Reveal (B&W to Color)
  Widget animateWidgetColorReveal({int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).custom(
      duration: durationMs.ms,
      builder: (_, v, child) =>
          ColorFiltered(colorFilter: ColorFilter.matrix([v, 0, 0, 0, 0, 0, v, 0, 0, 0, 0, 0, v, 0, 0, 0, 0, 0, 1, 0]), child: child),
    );
  }

  /// 59. Sepia Nostalgia
  Widget animateWidgetSepia({int delayMs = 0, int durationMs = 700, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 0,
          end: 1,
          duration: durationMs.ms,
          builder: (_, v, c) => ColorFiltered(
            colorFilter: ColorFilter.matrix([
              (1 - v) + (v * 0.393),
              v * 0.769,
              v * 0.189,
              0,
              0,
              v * 0.349,
              (1 - v) + (v * 0.686),
              v * 0.168,
              0,
              0,
              v * 0.272,
              v * 0.534,
              (1 - v) + (v * 0.131),
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: c,
          ),
        );
  }

  /// 60. Glass Shine Sweep
  Widget animateWidgetGlassShine({int delayMs = 0, int durationMs = 1200, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .shimmer(delay: 200.ms, duration: durationMs.ms, color: Colors.white.withColorOpacity(0.4), stops: const [0, 0.5, 1], angle: 45);
  }

  /// 61. Gold Metallic Sweep (Loop)
  Widget animateWidgetGoldSweep({int durationMs = 2500, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      repeat: repeat,
    ).shimmer(duration: durationMs.ms, color: const Color(0xFFFFD700).withColorOpacity(0.3), stops: const [0, 0.5, 1], angle: 45);
  }

  /// 62. Helix Spin Entrance
  Widget animateWidgetHelixEntry({int delayMs = 0, int durationMs = 700, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 1.2,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeOutBack,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateX(v)
              ..translateByDouble(0.0, v * 50, 0.0, 1),
            alignment: Alignment.center,
            child: c,
          ),
        );
  }

  /// 63. 3D Swing Hook
  Widget animateWidgetSwingHook({int delayMs = 0, int durationMs = 1200, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.2, end: 0, curve: Curves.easeOut, duration: (durationMs * 0.4).toInt().ms)
        .rotate(begin: 0.08, end: 0, curve: Curves.elasticOut, duration: durationMs.ms, alignment: Alignment.topCenter);
  }

  /// 64. Depth Zoom Tunnel
  Widget animateWidgetTunnelIn({int delayMs = 0, int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.0, 0.0), end: const Offset(1, 1), curve: Curves.fastOutSlowIn, duration: durationMs.ms)
        .blurXY(begin: 25, end: 0, duration: durationMs.ms);
  }

  /// 65. Aurora Sweep (Loop)
  Widget animateWidgetAurora({int durationMs = 4000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true)
        .shimmer(duration: durationMs.ms, color: Colors.purpleAccent.withColorOpacity(0.1))
        .shimmer(duration: (durationMs * 0.75).toInt().ms, color: Colors.blueAccent.withColorOpacity(0.1));
  }

  /// 66. Ghost Bloom
  Widget animateWidgetGhostBloom({int delayMs = 0, int durationMs = 800, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: durationMs.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutCirc, duration: durationMs.ms)
        .saturate(begin: 0, end: 1, duration: durationMs.ms);
  }

  /// 67. 3D Skew Slide
  Widget animateWidget3DSkew({int delayMs = 0, int durationMs = 700, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 0.5,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setEntry(0, 1, v)
              ..translateByDouble(v * 100, 0, 0, 1),
            child: c,
          ),
        );
  }

  /// 68. Star Particle Shine (Loop)
  Widget animateWidgetStarShine({int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat)
        .shimmer(duration: durationMs.ms, color: Colors.white.withColorOpacity(0.4), blendMode: BlendMode.overlay)
        .shake(hz: 0.5, curve: Curves.easeInOut)
        .scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02), duration: (durationMs / 2).ms);
  }

  /// 69. Inset Shadow Pulse (Loop)
  Widget animateWidgetInsetPulse({int durationMs = 1200, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true).custom(
      duration: durationMs.ms,
      builder: (_, v, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withColorOpacity(0.05 * v),
              blurRadius: 10 * v,
              spreadRadius: -5 * v,
              offset: Offset(2 * v, 2 * v),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  /// 70. Final Luxury Spotlight
  Widget animateWidgetSpotlightReveal({int delayMs = 0, int durationMs = 1000, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(delayMs: delayMs, repeat: repeat)
        .fadeIn(duration: 500.ms)
        .shimmer(duration: durationMs.ms, color: Colors.white.withColorOpacity(0.2), angle: 45)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: durationMs.ms);
  }

  /// 71. Circle Radial Shimmer (Loop)
  Widget animateWidgetCircleShimmer({
    Alignment alignment = Alignment.center,
    Color color = Colors.white,
    int durationMs = 1500,
    bool repeat = true,
    bool animate = true,
  }) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).custom(
      duration: durationMs.ms,
      builder: (_, v, child) {
        final double smoothV = Curves.easeInOutSine.transform(v);
        return ShaderMask(
          shaderCallback: (rect) => RadialGradient(
            center: alignment,
            radius: smoothV * 3.0,
            colors: [color.withColorOpacity(0.0), color.withColorOpacity(0.4 * (1 - smoothV.clamp(0.7, 1.0))), color.withColorOpacity(0.0)],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(rect),
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
    );
  }

  /// 72. Slide Up Fade
  Widget animateWidgetSlideUpFade({int delayMs = 0, int durationMs = 500, bool repeat = false, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(
      delayMs: delayMs,
      repeat: repeat,
    ).slideY(begin: 1.0, end: 0.0, duration: durationMs.ms, curve: Curves.easeOut).fadeIn(duration: durationMs.ms);
  }

  /// 73. Radar Scan (Radar Loop)
  Widget animateWidgetRadarScan({Color color = Colors.blueAccent, int durationMs = 2000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat).custom(
      duration: durationMs.ms,
      builder: (_, v, child) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withColorOpacity(1 - v), width: v * 20),
            ),
            width: v * 200,
            height: v * 200,
          ),
          child,
        ],
      ),
    );
  }

  /// 74. Neon Flow Sweep (Loop)
  Widget animateWidgetNeonFlow({Color color = Colors.cyanAccent, int durationMs = 1500, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat)
        .shimmer(duration: durationMs.ms, color: color.withColorOpacity(0.4), angle: 0)
        .shimmer(duration: durationMs.ms, color: color.withColorOpacity(0.2), angle: 90);
  }

  /// 75. Liquid Fill Breathe (Loop)
  Widget animateWidgetLiquidFill({Color color = Colors.greenAccent, int durationMs = 3000, bool repeat = true, bool animate = true}) {
    if (!animate) return this;
    return _baseAnimate(repeat: repeat, reverse: true).custom(
      duration: durationMs.ms,
      builder: (_, v, child) => ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [color, Colors.transparent],
          stops: [v, v + 0.1],
        ).createShader(rect),
        blendMode: BlendMode.srcATop,
        child: child,
      ),
    );
  }
}
