part of 'animation.dart';



enum TapEffect {
  scale,         // simple shrink
  fade,          // opacity fade
  scaleFade,     // combo
  bounce,        // bounce out
  elastic,       // bouncy spring
  pushDown,      // slight slide down
  tilt,          // tilt on Y axis
  shake,         // shake via move
  flip,          // 180 rotate
  pulse,         // zoom in-out
  zoomOut,       // zoom out
  swing,         // rotate left-right
  jelly,         // squash/stretch
  hoverLift,     // upward lift
  pop,           // fast scale sequence
  wiggle,        // tiny rotate jitter
  blur,          // fade + zoom
  glow,          // brief opacity boost
  swirl,         // rotate + zoom
  rubberBand,    // horizontal stretch
  dropBounce,    // fall then bounce
  wobble,        // left-right position + rotation
  breathe,       // slow in-out scale
  flipX,         // flip horizontally
  flipY,         // flip vertically
  rotateIn,      // small rotate entry
  shakeY,        // up/down shake
  none,
}




extension TapEffectExt on TapEffect {
  List<Effect> get effects {
    switch (this) {
      case TapEffect.scale:
        return [
          ScaleEffect(
            begin: const Offset(1, 1),
            end: const Offset(0.95, 0.95),
            duration: 120.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.fade:
        return [
          FadeEffect(
            begin: 1.0,
            end: 0.4,
            duration: 120.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.scaleFade:
        return [
          ScaleEffect(
            begin: const Offset(1, 1),
            end: const Offset(0.95, 0.95),
            duration: 120.ms,
            curve: Curves.easeInOut,
          ),
          FadeEffect(
            begin: 1.0,
            end: 0.4,
            duration: 120.ms,
          ),
        ];

      case TapEffect.bounce:
        return [
          ScaleEffect(
            begin: const Offset(1, 1),
            end: const Offset(1.15, 1.15),
            duration: 100.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.elastic:
        return [
          ScaleEffect(
            begin: const Offset(1, 1),
            end: const Offset(0.9, 0.9),
            duration: 200.ms,
            curve: Curves.elasticInOut,
          ),
        ];

      case TapEffect.pushDown:
        return [
          SlideEffect(
            begin: Offset.zero,
            end: const Offset(0, 0.05),
            duration: 120.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.tilt:
        return [
          RotateEffect(
            begin: 0.0,
            end: 0.05,
            duration: 120.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.bottomCenter,
          ),
        ];

      case TapEffect.shake:
        return [
          MoveEffect(
            begin: const Offset(-4, 0),
            end: const Offset(4, 0),
            duration: 60.ms,
            curve: Curves.easeInOut,
          ),
          MoveEffect(
            begin: const Offset(4, 0),
            end: const Offset(-2, 0),
            duration: 60.ms,
            curve: Curves.easeInOut,
          ),
          MoveEffect(
            begin: const Offset(-2, 0),
            end: Offset.zero,
            duration: 60.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.flip:
        return [
          RotateEffect(
            begin: 0.0,
            end: 3.14,
            duration: 300.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
        ];

      case TapEffect.pulse:
        return [
          ScaleEffect(
            begin: const Offset(1, 1),
            end: const Offset(1.1, 1.1),
            duration: 150.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.zoomOut:
        return [
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(0.8, 0.8),
            duration: 120.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.swing:
        return [
          RotateEffect(
            begin: -0.05,
            end: 0.05,
            duration: 80.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
          ),
          RotateEffect(
            begin: 0.05,
            end: -0.03,
            duration: 80.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
          ),
          RotateEffect(
            begin: -0.03,
            end: 0.0,
            duration: 60.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
          ),
        ];

      case TapEffect.jelly:
        return [
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.2, 0.8),
            duration: 80.ms,
            curve: Curves.easeIn,
          ),
          ScaleEffect(
            begin: const Offset(1.2, 0.8),
            end: const Offset(0.9, 1.1),
            duration: 80.ms,
            curve: Curves.easeOut,
          ),
          ScaleEffect(
            begin: const Offset(0.9, 1.1),
            end: const Offset(1.0, 1.0),
            duration: 80.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.hoverLift:
        return [
          MoveEffect(
            begin: const Offset(0, 0),
            end: const Offset(0, -5),
            duration: 120.ms,
            curve: Curves.easeOut,
          ),
          ScaleEffect(
            begin: const Offset(1, 1),
            end: const Offset(1.05, 1.05),
            duration: 120.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.pop:
        return [
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.2, 1.2),
            duration: 70.ms,
            curve: Curves.easeOut,
          ),
          ScaleEffect(
            begin: const Offset(1.2, 1.2),
            end: const Offset(0.95, 0.95),
            duration: 70.ms,
            curve: Curves.easeInOut,
          ),
          ScaleEffect(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
            duration: 70.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.wiggle:
        return [
          RotateEffect(
            begin: -0.04,
            end: 0.04,
            duration: 50.ms,
            curve: Curves.easeInOut,
          ),
          RotateEffect(
            begin: 0.04,
            end: -0.04,
            duration: 50.ms,
            curve: Curves.easeInOut,
          ),
          RotateEffect(
            begin: -0.02,
            end: 0.0,
            duration: 50.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.blur:
        return [
          FadeEffect(
            begin: 1.0,
            end: 0.5,
            duration: 100.ms,
            curve: Curves.easeInOut,
          ),
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.1, 1.1),
            duration: 100.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.glow:
        return [
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.05, 1.05),
            duration: 100.ms,
            curve: Curves.easeOut,
          ),
          FadeEffect(
            begin: 0.9,
            end: 1.0,
            duration: 100.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.swirl:
        return [
          RotateEffect(
            begin: 0.0,
            end: 0.3,
            duration: 120.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.1, 1.1),
            duration: 120.ms,
            curve: Curves.easeOut,
          ),
        ];

      case TapEffect.rubberBand:
        return [
          ScaleEffect(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.25, 0.75),
            duration: 100.ms,
            curve: Curves.easeIn,
          ),
          ScaleEffect(
            begin: const Offset(1.25, 0.75),
            end: const Offset(0.75, 1.25),
            duration: 100.ms,
            curve: Curves.easeOut,
          ),
          ScaleEffect(
            begin: const Offset(0.75, 1.25),
            end: const Offset(1.15, 0.85),
            duration: 100.ms,
            curve: Curves.easeInOut,
          ),
          ScaleEffect(
            begin: const Offset(1.15, 0.85),
            end: const Offset(1.0, 1.0),
            duration: 100.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.dropBounce:
        return [
          MoveEffect(
            begin: const Offset(0, -20),
            end: const Offset(0, 30),
            duration: 140.ms,
            curve: Curves.easeIn,
          ),
          MoveEffect(
            begin: const Offset(0, 30),
            end: Offset.zero,
            duration: 200.ms,
            curve: Curves.bounceOut,
          ),
        ];

      case TapEffect.wobble:
        return [
          MoveEffect(
            begin: const Offset(-0.05, 0),
            end: const Offset(0.05, 0),
            duration: 80.ms,
            curve: Curves.easeInOut,
          ),
          RotateEffect(
            begin: -0.05,
            end: 0.05,
            duration: 80.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
          MoveEffect(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
            duration: 80.ms,
            curve: Curves.easeInOut,
          ),
          RotateEffect(
            begin: 0.05,
            end: 0.0,
            duration: 80.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
        ];

      case TapEffect.breathe:
        return [
          ScaleEffect(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.08, 1.08),
            duration: 300.ms,
            curve: Curves.easeInOut,
          ),
          ScaleEffect(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
            duration: 300.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.flipX:
        return [
          RotateEffect(
            begin: 0,
            end: 3.14,
            duration: 300.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.centerLeft,
          ),
        ];

      case TapEffect.flipY:
        return [
          RotateEffect(
            begin: 0,
            end: 3.14,
            duration: 300.ms,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
          ),
        ];

      case TapEffect.rotateIn:
        return [
          RotateEffect(
            begin: -0.5,
            end: 0.0,
            duration: 200.ms,
            curve: Curves.easeOut,
            alignment: Alignment.center,
          ),
        ];

      case TapEffect.shakeY:
        return [
          MoveEffect(
            begin: const Offset(0, -4),
            end: const Offset(0, 4),
            duration: 60.ms,
            curve: Curves.easeInOut,
          ),
          MoveEffect(
            begin: const Offset(0, 4),
            end: const Offset(0, -2),
            duration: 60.ms,
            curve: Curves.easeInOut,
          ),
          MoveEffect(
            begin: const Offset(0, -2),
            end: Offset.zero,
            duration: 60.ms,
            curve: Curves.easeInOut,
          ),
        ];

      case TapEffect.none:
      return [];
    }
  }
}



class AnimatedGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final TapEffect? effectPreset;

  const AnimatedGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.effectPreset = TapEffect.scale,
  });

  @override
  State<AnimatedGestureDetector> createState() => _AnimatedGestureDetectorState();
}

class _AnimatedGestureDetectorState extends State<AnimatedGestureDetector> {
  bool _tapped = false;

  void _handleTapDown(TapDownDetails _) {
    if(widget.onTap == null) return;

   setState(() => _tapped = true);


    // Optional: trigger haptic for bounce
    if (widget.effectPreset == TapEffect.bounce) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails _) {
    if(widget.onTap == null) return;

 setState(() => _tapped = false); // 💡 this resets
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    if(widget.onTap == null) return;
   setState(() => _tapped = false); // 💡 this also resets
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Animate(
        target: _tapped ? 1 : 0,
        effects: widget.effectPreset?.effects??TapEffect.scale.effects,
        child: widget.child,
      ),
    );
  }
}
