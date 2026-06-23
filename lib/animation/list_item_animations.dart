part of 'animation.dart';



extension AnimationListViewItemWidget on Widget {
  // Helper to handle delay capping
  int _getDelay(int index, int intervalMs) => index > 10 ? 0 : index * intervalMs;

  // ===========================================================================
  // SECTION 1: STAGGERED LIST ENTRANCE ANIMATIONS (Method 1-60)
  // ===========================================================================

  /// 1. Staggered Slide & Fade
  Widget animateListEntry({required int index, int intervalMs = 50, int durationMs = 400, double begin = 0.2, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: durationMs.ms)
        .slideX(begin: begin, end: 0, curve: Curves.easeOutCubic);
  }

  /// 2. Staggered Scale (Pop-in)
  Widget animateListGridPop({required int index, int intervalMs = 40, int durationMs = 400, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack, duration: durationMs.ms)
        .fadeIn(duration: (durationMs / 2).toInt().ms);
  }

  /// 3. Staggered Flip
  Widget animateListStaggeredFlip({required int index, int intervalMs = 60, int durationMs = 500, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .flipH(begin: 1, end: 0, duration: durationMs.ms)
        .fadeIn(duration: (durationMs / 2).toInt().ms);
  }

  /// 4. Staggered 3D Perspective
  Widget animateListStaggeredPerspective({required int index, int intervalMs = 70, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .custom(
          begin: 0.5,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(v),
            alignment: Alignment.center,
            child: c,
          ),
        )
        .fadeIn(duration: (durationMs / 2).toInt().ms);
  }

  /// 5. Staggered Blur & Slide
  Widget animateListBlurSlide({required int index, int intervalMs = 60, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .blurXY(begin: 10, end: 0, duration: durationMs.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic, duration: durationMs.ms)
        .fadeIn(duration: (durationMs / 1.5).toInt().ms);
  }

  /// 6. Morph Entrance
  Widget animateListMorphIn({required int index, int intervalMs = 80, int durationMs = 1000, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: (durationMs / 2).toInt().ms)
        .scale(begin: const Offset(0.5, 1.5), end: const Offset(1, 1), curve: Curves.elasticOut, duration: durationMs.ms);
  }

  /// 7. Shimmer Reveal
  Widget animateListShimmerReveal({required int index, int intervalMs = 100, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .moveX(begin: -20, end: 0, duration: durationMs.ms)
        .shimmer(delay: 200.ms, duration: durationMs.ms, color: Colors.white24);
  }

  /// 8. Bounce Up
  Widget animateListBounce({required int index, int intervalMs = 50, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .scale(begin: const Offset(0.3, 0.3), end: const Offset(1, 1), curve: Curves.bounceOut, duration: durationMs.ms)
        .fadeIn(duration: (durationMs / 2).toInt().ms);
  }

  /// 9. Spiral Rotate
  Widget animateListSpiral({required int index, int intervalMs = 70, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .rotate(begin: 0.5, end: 0, curve: Curves.easeOutBack, duration: durationMs.ms)
        .scale(begin: Offset.zero, end: const Offset(1, 1), duration: durationMs.ms)
        .fadeIn();
  }

  /// 10. Glitch & Slide
  Widget animateListGlitch({required int index, int intervalMs = 50, int durationMs = 400, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .shake(hz: 4, duration: durationMs.ms, curve: Curves.easeInOut)
        .slideX(begin: 0.1, end: 0, curve: Curves.decelerate, duration: durationMs.ms);
  }

  /// 11. Reveal Clip (Vertical)
  Widget animateListRevealScale({required int index, int intervalMs = 60, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .scaleY(begin: 0, end: 1, alignment: Alignment.bottomCenter, curve: Curves.easeOutExpo, duration: durationMs.ms)
        .moveY(begin: 20, end: 0, duration: durationMs.ms);
  }

  /// 12. 3D Swing
  Widget animateList3DSwing({required int index, int intervalMs = 80, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .custom(
          begin: -0.5,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeOutBack,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(v),
            alignment: Alignment.centerLeft,
            child: c,
          ),
        )
        .fadeIn();
  }

  /// 13. Focus In (Depth)
  Widget animateListFocusDepth({required int index, int intervalMs = 100, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .scale(begin: const Offset(1.5, 1.5), end: const Offset(1, 1), duration: durationMs.ms, curve: Curves.easeOutCubic)
        .blurXY(begin: 15, end: 0, duration: durationMs.ms)
        .fadeIn();
  }

  /// 14. Skew Entry
  Widget animateListSkewSlide({required int index, int intervalMs = 50, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.5, end: 0, curve: Curves.easeOutQuart, duration: durationMs.ms)
        .custom(
          begin: 0.2,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(transform: Matrix4.skewX(v), child: c),
        );
  }

  /// 15. Origami Fold
  Widget animateListOrigami({required int index, int intervalMs = 80, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
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

  /// 16. Elastic Slide (Magnetic)
  Widget animateListMagnetic({required int index, int intervalMs = 60, int durationMs = 1200, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 1.0, end: 0, curve: Curves.elasticOut, duration: durationMs.ms);
  }

  /// 17. Floating Bubble
  Widget animateListFloatingBubble({required int index, int intervalMs = 70, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 500.ms)
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), curve: Curves.easeOutBack, duration: durationMs.ms)
        .moveY(begin: 50, end: 0, duration: durationMs.ms);
  }

  /// 18. Depth Zoom (Tunnel)
  Widget animateListTunnel({required int index, int intervalMs = 90, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.0, 0.0), end: const Offset(1, 1), curve: Curves.fastOutSlowIn, duration: durationMs.ms)
        .blurXY(begin: 20, end: 0, duration: durationMs.ms);
  }

  /// 19. Tilt & Shift
  Widget animateListTiltShift({required int index, int intervalMs = 50, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.5, end: 0, curve: Curves.easeOutExpo, duration: durationMs.ms)
        .custom(
          begin: 0.1,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateZ(v),
            child: c,
          ),
        );
  }

  /// 20. Neon Flash
  Widget animateListNeonFlash({required int index, int intervalMs = 120, int durationMs = 500, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 200.ms)
        .shimmer(duration: (durationMs * 2).toInt().ms, color: Colors.white30)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: durationMs.ms);
  }

  /// 21. Jelly Wave
  Widget animateListJelly({required int index, int intervalMs = 60, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(1.2, 0.8), end: const Offset(1, 1), duration: durationMs.ms, curve: Curves.elasticOut)
        .slideY(begin: 0.2, end: 0, duration: durationMs.ms);
  }

  /// 22. Vortex Spin
  Widget animateListVortex({required int index, int intervalMs = 100, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 500.ms)
        .rotate(begin: 1.5, end: 0, curve: Curves.easeOutCubic, duration: durationMs.ms)
        .scale(begin: Offset.zero, end: const Offset(1, 1), duration: durationMs.ms)
        .blurXY(begin: 10, end: 0, duration: durationMs.ms);
  }

  /// 23. Paper Slide & Lift
  Widget animateListPaperLift({required int index, int intervalMs = 100, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.5, end: 0, curve: Curves.easeOutQuart, duration: durationMs.ms)
        .custom(
          begin: 10,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform.translate(
            offset: Offset(0, -v),
            child: PhysicalModel(
              color: Colors.white,
              shadowColor: Colors.black.withValues(alpha: v > 0 ? 0.1 : 0),
              elevation: v,
              borderRadius: BorderRadius.circular(12),
              child: c,
            ),
          ),
        );
  }

  /// 24. Horizon Tilt
  Widget animateListHorizon({required int index, int intervalMs = 20, int durationMs = 300, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 1.0,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(v),
            alignment: Alignment.centerRight,
            child: c,
          ),
        );
  }

  /// 25. Ghost Sweep
  Widget animateListGhostSweep({required int index, int intervalMs = 40, int durationMs = 400, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 200.ms)
        .slideX(begin: -0.3, end: 0, curve: Curves.linearToEaseOut, duration: durationMs.ms)
        .blurX(begin: 20, end: 0, duration: durationMs.ms);
  }

  /// 26. Perspective Helix
  Widget animateListHelix({required int index, int intervalMs = 60, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
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
              ..setTranslationRaw(0.0, v * 50, 0.0),
            alignment: Alignment.center,
            child: c,
          ),
        );
  }

  /// 27. Zoom-In Blur (Explosion)
  Widget animateListExplosion({required int index, int intervalMs = 80, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .scale(begin: const Offset(0.0, 0.0), end: const Offset(1, 1), curve: Curves.easeOutExpo, duration: durationMs.ms)
        .blurXY(begin: 30, end: 0, duration: (durationMs * 0.8).toInt().ms)
        .fadeIn();
  }

  /// 28. Slide & Swing
  Widget animateListSwingHook({required int index, int intervalMs = 70, int durationMs = 1200, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.2, end: 0, curve: Curves.easeOut, duration: (durationMs * 0.4).toInt().ms)
        .rotate(begin: 0.05, end: 0, curve: Curves.elasticOut, duration: durationMs.ms, alignment: Alignment.topCenter);
  }

  /// 29. Slide Skew Reveal
  Widget animateListSkewReveal({required int index, int intervalMs = 50, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 0.4,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(0, 1, v)
              ..setTranslationRaw(v * 100, 0.0, 0.0),
            child: c,
          ),
        );
  }

  /// 30. Spotlight Focus
  Widget animateListSpotlight({required int index, int intervalMs = 120, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: (durationMs * 0.75).toInt().ms)
        .shimmer(duration: (durationMs * 1.5).toInt().ms, color: Colors.white12)
        .saturate(begin: 0, end: 1, duration: durationMs.ms)
        .scale(begin: const Offset(0.98, 0.98), end: const Offset(1, 1), duration: durationMs.ms);
  }

  /// 31. Elastic Pull-Back
  Widget animateListPullBack({required int index, int intervalMs = 60, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(1.3, 1.3), end: const Offset(1, 1), curve: Curves.elasticOut, duration: durationMs.ms)
        .slideY(begin: -0.2, end: 0);
  }

  /// 32. Liquid Swipe
  Widget animateListLiquidSwipe({required int index, int intervalMs = 50, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
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
              ..setTranslationRaw(v * 200, 0.0, 0.0),
            child: c,
          ),
        );
  }

  /// 33. Card Stack Reveal
  Widget animateListCardDeal({required int index, int intervalMs = 100, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .moveY(begin: 200, end: 0, curve: Curves.easeOutBack, duration: durationMs.ms)
        .rotate(begin: 0.1, end: 0, duration: durationMs.ms);
  }

  /// 34. Cyber Glitch Blur
  Widget animateListCyberBlur({required int index, int intervalMs = 80, int durationMs = 500, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 200.ms)
        .blurXY(begin: 20, end: 0, duration: durationMs.ms)
        .shake(hz: 3, duration: durationMs.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }

  /// 35. Fold & Float
  Widget animateListFoldFloat({required int index, int intervalMs = 120, int durationMs = 1000, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .scaleY(begin: 0, end: 1, alignment: Alignment.center, curve: Curves.elasticOut, duration: durationMs.ms)
        .moveY(begin: 30, end: 0, duration: (durationMs * 0.8).toInt().ms);
  }

  /// 36. Split Reveal (Horizontal)
  Widget animateListSplitReveal({required int index, int intervalMs = 70, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .scaleX(begin: 0.2, end: 1, alignment: Alignment.center, curve: Curves.easeOutExpo, duration: durationMs.ms)
        .blurX(begin: 15, end: 0, duration: durationMs.ms);
  }

  /// 37. Arc Path Entry
  Widget animateListArcEntry({required int index, int intervalMs = 50, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .move(begin: const Offset(100, 100), end: Offset.zero, curve: Curves.easeOutBack, duration: durationMs.ms)
        .rotate(begin: -0.2, end: 0, duration: durationMs.ms);
  }

  /// 38. Glass Morph Shine
  Widget animateListGlassShine({required int index, int intervalMs = 150, int durationMs = 1200, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.1, end: 0)
        .shimmer(delay: 200.ms, duration: durationMs.ms, color: Colors.white.withValues(alpha: 0.4), stops: [0, 0.5, 1], angle: 45);
  }

  /// 39. Stamp Press
  Widget animateListStamp({required int index, int intervalMs = 80, int durationMs = 500, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 200.ms)
        .scale(begin: const Offset(2.0, 2.0), end: const Offset(1, 1), curve: Curves.easeInCirc, duration: durationMs.ms)
        .shake(hz: 2, duration: 200.ms, delay: durationMs.ms);
  }

  /// 40. Particle Dissolve (Reverse)
  Widget animateListDissolve({required int index, int intervalMs = 90, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: durationMs.ms)
        .blurXY(begin: 30, end: 0, duration: durationMs.ms)
        .scale(begin: const Offset(0.7, 0.7), end: const Offset(1, 1), curve: Curves.slowMiddle, duration: durationMs.ms);
  }

  /// 41. Slot Machine Reveal
  Widget animateListSlotMachine({required int index, int intervalMs = 60, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .moveY(begin: -100, end: 0, curve: Curves.bounceOut, duration: durationMs.ms)
        .scaleY(begin: 1.5, end: 1, duration: durationMs.ms);
  }

  /// 42. Door Opening 3D
  Widget animateList3DDoor({required int index, int intervalMs = 80, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 1.5,
          end: 0,
          duration: durationMs.ms,
          curve: Curves.easeOutQuart,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(v),
            alignment: Alignment.centerLeft,
            child: c,
          ),
        );
  }

  /// 43. Magnifying Glass
  Widget animateListMagnify({required int index, int intervalMs = 50, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.1, 0.1), end: const Offset(1, 1), curve: Curves.easeOutBack, duration: durationMs.ms);
  }

  /// 44. Diagonal Slice
  Widget animateListDiagonalSlice({required int index, int intervalMs = 50, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .move(begin: const Offset(-50, -50), end: Offset.zero, curve: Curves.easeOutCubic, duration: durationMs.ms);
  }

  /// 45. Newspaper Spin
  Widget animateListNewsSpin({required int index, int intervalMs = 100, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .rotate(begin: 2, end: 0, duration: durationMs.ms, curve: Curves.easeInOutCubic)
        .scale(begin: const Offset(0.2, 0.2), end: const Offset(1, 1), duration: durationMs.ms);
  }

  /// 46. Soft Blur Flare
  Widget animateListBlurFlare({required int index, int intervalMs = 70, int durationMs = 900, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 500.ms)
        .blurXY(begin: 20, end: 0, duration: durationMs.ms)
        .shimmer(color: Colors.white30, duration: durationMs.ms);
  }

  /// 47. Vertical Venetian
  Widget animateListVenetian({required int index, int intervalMs = 60, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 300.ms)
        .scaleY(begin: 0, end: 1, curve: Curves.easeInOutSine, duration: durationMs.ms);
  }

  /// 48. Swing Drop
  Widget animateListSwingDrop({required int index, int intervalMs = 90, int durationMs = 1200, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .moveY(begin: -50, end: 0, duration: 400.ms)
        .rotate(begin: 0.1, end: 0, curve: Curves.elasticOut, duration: durationMs.ms, alignment: Alignment.topCenter);
  }

  /// 49. Horizontal Squeeze
  Widget animateListSqueeze({required int index, int intervalMs = 50, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn()
        .scaleX(begin: 0, end: 1, curve: Curves.easeOutBack, duration: durationMs.ms);
  }

  /// 50. Glitch Jitter
  Widget animateListCyberJitter({required int index, int intervalMs = 40, int durationMs = 500, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 200.ms)
        .shakeX(amount: 5, hz: 10, duration: durationMs.ms)
        .moveX(begin: 20, end: 0);
  }

  /// 51. Ghost Bloom
  Widget animateListGhostBloom({required int index, int intervalMs = 100, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: durationMs.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutCirc, duration: durationMs.ms)
        .saturate(begin: 0, end: 1, duration: durationMs.ms);
  }

  /// 52. Perspective Skew Slide
  Widget animateList3DSkew({required int index, int intervalMs = 50, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 0.5,
          end: 0,
          duration: durationMs.ms,
          builder: (_, v, c) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setEntry(0, 1, v)
              ..setTranslationRaw(v * 100, 0, 0),
            child: c,
          ),
        );
  }

  /// 53. Jelly Bounce
  Widget animateListJellyBounce({required int index, int intervalMs = 60, int durationMs = 1000, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .scale(begin: const Offset(0.5, 1.5), end: const Offset(1, 1), curve: Curves.elasticOut, duration: durationMs.ms)
        .fadeIn(duration: 300.ms);
  }

  /// 54. Color Wave
  Widget animateListColorWave({required int index, int intervalMs = 80, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .desaturate(begin: 1, end: 0, duration: durationMs.ms)
        .slideY(begin: 0.1, end: 0);
  }

  /// 55. Final Spotlight Reveal
  Widget animateListSpotlightReveal({required int index, int intervalMs = 120, int durationMs = 1000, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 500.ms)
        .shimmer(duration: durationMs.ms, color: Colors.white24, angle: 45)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: durationMs.ms);
  }

  /// 56. Reverse Color Wave
  Widget animateListColorWaveReverse({required int index, int intervalMs = 80, int durationMs = 800, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .desaturate(begin: 0, end: 1, duration: durationMs.ms)
        .slideY(begin: -0.1, end: 0);
  }

  /// 57. Sepia Nostalgia
  Widget animateListSepiaTone({required int index, int intervalMs = 70, int durationMs = 700, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn(duration: 400.ms)
        .custom(
          begin: 0,
          end: 1,
          duration: durationMs.ms,
          builder: (context, value, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.matrix([
                (1 - value) + (value * 0.393),
                value * 0.769,
                value * 0.189,
                0,
                0,
                value * 0.349,
                (1 - value) + (value * 0.686),
                value * 0.168,
                0,
                0,
                value * 0.272,
                value * 0.534,
                (1 - value) + (value * 0.131),
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ]),
              child: child,
            );
          },
        )
        .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1), curve: Curves.easeOut);
  }

  /// 58. Border Glow (Rounded)
  Widget animateListBorderGlow({
    required int index,
    int intervalMs = 90,
    int durationMs = 1000,
    Color? color,
    double borderRadius = 12.0,
    bool animate = true,
  }) {
    if (!animate) return this;
    final int delay = _getDelay(index, intervalMs);
    final Color borderColor = color ?? Colors.cyanAccent;

    return this
        .animate(delay: delay.ms)
        .fadeIn(duration: 400.ms)
        .shimmer(duration: durationMs.ms, color: borderColor.withValues(alpha: 0.3), angle: 45)
        .custom(
          begin: 0,
          end: 1,
          duration: (durationMs / 2).toInt().ms,
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: borderColor.withValues(alpha: value * 0.4),
                    blurRadius: value * 12,
                    spreadRadius: value * 1,
                  ),
                ],
              ),
              child: child,
            );
          },
        )
        .then(delay: 0.ms)
        .custom(
          begin: 1,
          end: 0,
          duration: (durationMs / 2).toInt().ms,
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: borderColor.withValues(alpha: value * 0.4),
                    blurRadius: value * 12,
                    spreadRadius: value * 1,
                  ),
                ],
              ),
              child: child,
            );
          },
        );
  }

  /// 59. Exposure Pop
  Widget animateListExposurePop({required int index, int intervalMs = 60, int durationMs = 600, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn()
        .custom(
          begin: 2.0,
          end: 1.0,
          duration: durationMs.ms,
          builder: (_, v, c) =>
              ColorFiltered(colorFilter: ColorFilter.matrix([v, 0, 0, 0, 0, 0, v, 0, 0, 0, 0, 0, v, 0, 0, 0, 0, 0, 1, 0]), child: c),
        );
  }

  /// 60. Ghost Invert
  Widget animateListInvertReveal({required int index, int intervalMs = 50, int durationMs = 500, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(delay: _getDelay(index, intervalMs).ms)
        .fadeIn()
        .custom(
          begin: 1.0,
          end: 0.0,
          duration: durationMs.ms,
          builder: (_, v, c) => ColorFiltered(
            colorFilter: ColorFilter.matrix([
              -1 * v + (1 - v),
              0,
              0,
              0,
              255 * v,
              0,
              -1 * v + (1 - v),
              0,
              0,
              255 * v,
              0,
              0,
              -1 * v + (1 - v),
              0,
              255 * v,
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

  // ===========================================================================
  // SECTION 2: SHIMMER, GLOW & SWEEP VARIATIONS (Method 61-70)
  // ===========================================================================

  /// 61. Golden Metallic Sweep
  Widget animateGoldSweep({bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2500.ms, color: const Color(0xFFFFD700).withValues(alpha: 0.3), stops: const [0, 0.5, 1], angle: 45)
        .shimmer(delay: 1250.ms, duration: 2500.ms, color: Colors.white.withValues(alpha: 0.2), angle: 45);
  }

  /// 62. Radar Scan
  Widget animateRadarScan({Color color = Colors.blueAccent, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat())
        .custom(
          duration: 2000.ms,
          builder: (context, value, child) => Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: (1 - value).clamp(0, 1)),
                    width: value * 20,
                  ),
                ),
                width: value * 200,
                height: value * 200,
              ),
              child,
            ],
          ),
        );
  }

  /// 63. Neon Flow
  Widget animateNeonFlow({Color color = Colors.cyanAccent, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: color.withValues(alpha: 0.4), angle: 0)
        .shimmer(duration: 1500.ms, color: color.withValues(alpha: 0.2), angle: 90);
  }

  /// 64. Liquid Fill Shimmer
  Widget animateLiquidFill({Color color = Colors.greenAccent, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .custom(
          duration: 3000.ms,
          builder: (context, value, child) => ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [color, Colors.transparent],
              stops: [value, value + 0.1],
            ).createShader(rect),
            blendMode: BlendMode.srcATop,
            child: child,
          ),
        );
  }

  /// 65. Ghost Pulse Glow
  Widget animateGhostGlow({Color color = Colors.redAccent, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .custom(
          duration: 1500.ms,
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2 * value),
                  blurRadius: 20 * value,
                  spreadRadius: 5 * value,
                ),
              ],
            ),
            child: child,
          ),
        );
  }

  /// 66. Glass Shine (Fast)
  Widget animateLaserSweep({bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(period: 1000.ms))
        .shimmer(duration: 600.ms, color: Colors.white.withValues(alpha: 0.8), stops: const [0.4, 0.5, 0.6], angle: 60);
  }

  /// 67. Multi-Color Aurora
  Widget animateAurora({bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(duration: 4000.ms, color: Colors.purpleAccent.withValues(alpha: 0.1))
        .shimmer(duration: 3000.ms, color: Colors.blueAccent.withValues(alpha: 0.1))
        .shimmer(duration: 5000.ms, color: Colors.cyanAccent.withValues(alpha: 0.1));
  }

  /// 68. Exposure Blink
  Widget animateExposureBlink({bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .custom(
          duration: 800.ms,
          builder: (_, v, c) => ColorFiltered(
            colorFilter: ColorFilter.matrix([1 + v, 0, 0, 0, 0, 0, 1 + v, 0, 0, 0, 0, 0, 1 + v, 0, 0, 0, 0, 0, 1, 0]),
            child: c,
          ),
        );
  }

  /// 69. Inner Shadow Pulse
  Widget animateInsetPulse({bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .custom(
          duration: 1200.ms,
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05 * value),
                  blurRadius: 10 * value,
                  spreadRadius: -5 * value,
                  offset: Offset(2 * value, 2 * value),
                ),
              ],
            ),
            child: child,
          ),
        );
  }

  /// 70. Smooth Glow
  Widget animateSmoothGlow({Color color = Colors.blueAccent, bool animate = true}) {
    if (!animate) return this;
    return this
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .custom(
          duration: 1500.ms,
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2 * value),
                  blurRadius: 15 * value,
                  spreadRadius: 2 * value,
                ),
              ],
            ),
            child: child,
          ),
        );
  }
}
