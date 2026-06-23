part of 'animation.dart';



extension AnimationsBottomSheet on Widget {
  // ===========================================================================
  // BOTTOM SHEET & MODAL SPECIALIZED ANIMATIONS
  // ===========================================================================

  /// 1. Sheet Content Slide: Bottom sheet khulne par content niche se upar aayega.
  /// Isme 'Curve.easeOutBack' use kiya hai jo ek halka sa bounce deta hai.
  Widget animateSheetReveal({int delayMs = 100}) {
    return animate(delay: delayMs.ms).fadeIn(duration: 400.ms).moveY(begin: 50, end: 0, duration: 500.ms, curve: Curves.easeOutBack);
  }

  /// 2. Modal Scale-In: Bottom sheet ke items ke liye pop-in effect.
  Widget animateModalPop({int delayMs = 150}) {
    return animate(delay: delayMs.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), curve: Curves.easeOutCubic).fadeIn();
  }

  /// 3. Bottom Sheet Header Pulse: Header bar ya handle ko dhire se highlight karna.
  Widget animateSheetHandle() {
    return animate(onPlay: (controller) => controller.repeat(reverse: true)).fadeIn(duration: 1000.ms).fadeOut(delay: 500.ms);
  }

  /// 4. Action Button Elastic: Confirm/Pay buttons ke liye organic entrance.
  Widget animateSheetAction({int delayMs = 300}) {
    return animate(
      delay: delayMs.ms,
    ).scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), curve: Curves.elasticOut, duration: 800.ms);
  }
}
