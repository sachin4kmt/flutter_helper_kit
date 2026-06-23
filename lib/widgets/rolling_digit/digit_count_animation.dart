

// Note: Agar aap 'AnimatedDigitWidget' external package use kar rahe hain
// toh uska import yahan aayega.
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';

enum DigitAnimationType {
  simple,
  gear,
  blur,
  ribbon,
  ios,
  flip,
  continuous,
  pop,
  wheel,
  perspective,
  cube,
  typing,
  bounceDown,
  glitch,
  spiral,
  wave,
  shrink,
  flicker,
}

class UniversalDigitCounter extends StatelessWidget {
  final num value;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;
  final DigitAnimationType type;
  final int fractionDigits;
  final bool enableMinIntegerDigits;
  final bool autoScale;
  final BoxDecoration? boxDecoration;
  final String? prefix;
  final String? suffix;
  final bool enableSeparator;
  final String separateSymbol;
  final int separateLength;
  final String decimalSeparator;
  final EdgeInsetsGeometry? padding;

  const UniversalDigitCounter({
    super.key,
    required this.value,
    this.style,
    this.type = DigitAnimationType.simple,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeInOut,
    this.fractionDigits = 0,
    this.enableMinIntegerDigits = true,
    this.autoScale = true,
    this.boxDecoration,
    this.prefix,
    this.suffix,
    this.padding,
    this.enableSeparator = false,
    this.separateSymbol = ',',
    this.separateLength = 3,
    this.decimalSeparator = '.',
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = style ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

    // 1. Formatting Logic
    String formattedValue = _getFormattedValue();

    // 2. Handle Continuous Type
    if (type == DigitAnimationType.continuous) {
      // Yahan aapka external AnimatedDigitWidget call hoga agar project me hai
      return Text('${prefix ?? ''}$formattedValue${suffix ?? ''}', style: defaultStyle);
    }

    // 3. Main UI Build
    Widget content = Container(
      decoration: boxDecoration,
      padding: padding ?? (boxDecoration != null ? REdgeInsets.symmetric(horizontal: 4) : null),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefix != null) Text(prefix!, style: defaultStyle),
          ...formattedValue.split('').map((char) {
            if (RegExp(r'[0-9]').hasMatch(char)) {
              return _buildAnimatedDigit(char, defaultStyle);
            } else {
              return _buildStaticChar(char, defaultStyle);
            }
          }),
          if (suffix != null) Text(suffix!, style: defaultStyle),
        ],
      ),
    );

    return autoScale ? FittedBox(fit: BoxFit.scaleDown, child: content) : content;
  }

  String _getFormattedValue() {
    String valStr = value.toStringAsFixed(fractionDigits);

    // Padding (e.g. 05)
    if (enableMinIntegerDigits && value < 10 && value >= 0 && fractionDigits == 0) {
      valStr = valStr.padLeft(2, '0');
    }

    // Thousands Separator
    if (enableSeparator) {
      List<String> parts = valStr.split('.');
      RegExp reg = RegExp(r'\B(?=(\d{' + separateLength.toString() + r'})+(?!\d))');
      parts[0] = parts[0].replaceAll(reg, separateSymbol);
      valStr = parts.length > 1 ? parts[0] + decimalSeparator + parts[1] : parts[0];
    }
    return valStr;
  }

  Widget _buildStaticChar(String char, TextStyle style) {
    return AnimatedSwitcher(
      duration: duration,
      child: Text(char, key: ValueKey('static_$char'), style: style),
    );
  }

  Widget _buildAnimatedDigit(String char, TextStyle textStyle) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: curve,
        switchOutCurve: curve,
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(alignment: Alignment.center, children: <Widget>[...previousChildren, if (currentChild != null) currentChild]);
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ClipRect(
            child: _getTransition(child, animation, char, currentType: type, currentStyle: textStyle),
          );
        },
        child: Text(
          char,
          key: ValueKey(char),
          style: textStyle.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
        ),
      ),
    );
  }

  Widget _getTransition(
    Widget child,
    Animation<double> animation,
    String char, {
    required DigitAnimationType currentType,
    required TextStyle currentStyle,
  }) {
    switch (currentType) {
      case DigitAnimationType.gear:
        return _gearTransition(child, animation);
      case DigitAnimationType.blur:
        return _blurTransition(child, animation);
      case DigitAnimationType.ribbon:
        return _ribbonTransition(child, animation, char);
      case DigitAnimationType.ios:
        return _iosTransition(child, animation, char);
      case DigitAnimationType.flip:
        return _flipTransition(child, animation);
      case DigitAnimationType.pop:
        return _popTransition(child, animation);
      case DigitAnimationType.wheel:
        return _wheelTransition(child, animation, char);
      case DigitAnimationType.perspective:
        return _perspectiveTransition(child, animation, char);
      case DigitAnimationType.cube:
        return _cubeTransition(child, animation, char);
      case DigitAnimationType.typing:
        return _typingTransition(child, animation);
      case DigitAnimationType.bounceDown:
        return _bounceDownTransition(child, animation, char);
      case DigitAnimationType.glitch:
        return _glitchTransition(child, animation);
      case DigitAnimationType.spiral:
        return _spiralTransition(child, animation);
      case DigitAnimationType.wave:
        return _waveTransition(child, animation, char);
      case DigitAnimationType.shrink:
        return _shrinkTransition(child, animation);
      case DigitAnimationType.flicker:
        return _flickerTransition(child, animation);
      default:
        return FadeTransition(opacity: animation, child: child);
    }
  }

  // --- TRANSITION IMPLEMENTATIONS ---

  Widget _gearTransition(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final rotate = (1 - animation.value) * 1.5;
        final scale = 0.8 + (animation.value * 0.2);
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..scaleByDouble(scale, scale, 1.0, 1.0)
              ..rotateX(rotate),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }

  Widget _wheelTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final double offset = isCurrent ? (1 - animation.value) : -animation.value;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.003)
            ..translateByDouble(0.0, offset * 50.0, 0.0, 1.0)
            ..rotateX(offset * pi / 2),
          alignment: Alignment.center,
          child: Opacity(opacity: animation.value, child: child),
        );
      },
    );
  }

  Widget _perspectiveTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final double scale = isCurrent ? 0.5 + (animation.value * 0.5) : 1.0 + (animation.value);
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..scaleByDouble(scale, scale, 1.0, 1.0),
          alignment: Alignment.center,
          child: Opacity(opacity: animation.value.clamp(0.0, 1.0), child: child),
        );
      },
    );
  }

  Widget _blurTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: (1 - animation.value).abs() * 5, sigmaY: (1 - animation.value).abs() * 5),
        child: child,
      ),
    );
  }

  Widget _ribbonTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return SlideTransition(
      position: Tween<Offset>(
        begin: isCurrent ? const Offset(0, 1.0) : const Offset(0, -1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: isCurrent ? Curves.elasticOut : Curves.easeInOut)),
      child: child,
    );
  }

  Widget _iosTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return SlideTransition(
      position: Tween<Offset>(begin: isCurrent ? const Offset(0, 1) : const Offset(0, -1), end: Offset.zero).animate(animation),
      child: child,
    );
  }

  Widget _flipTransition(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        final rotate = (1 - animation.value) * (pi / 2);
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.006)
            ..rotateX(rotate),
          alignment: Alignment.center,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  Widget _popTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _cubeTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final double rotate = isCurrent ? (1 - animation.value) * (pi / 2) : -animation.value * (pi / 2);
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(rotate),
          alignment: isCurrent ? Alignment.centerLeft : Alignment.centerRight,
          child: Opacity(opacity: animation.value, child: child),
        );
      },
    );
  }

  Widget _typingTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: const Threshold(0.5)),
      child: child,
    );
  }

  Widget _bounceDownTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return SlideTransition(
      position: Tween<Offset>(
        begin: isCurrent ? const Offset(0, -1.5) : const Offset(0, 1.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: isCurrent ? Curves.elasticOut : Curves.easeIn)),
      child: child,
    );
  }

  Widget _glitchTransition(Widget child, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final offset = (1 - animation.value) * 10.0;
        final randomOffset = (Random().nextDouble() - 0.5) * offset;
        return Transform.translate(
          offset: Offset(randomOffset, 0),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
    );
  }

  Widget _spiralTransition(Widget child, Animation<double> animation) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
      child: ScaleTransition(scale: animation, child: child),
    );
  }

  Widget _waveTransition(Widget child, Animation<double> animation, String char) {
    final isCurrent = (child.key == ValueKey(char));
    return SlideTransition(
      position: Tween<Offset>(
        begin: isCurrent ? const Offset(0, 0.5) : const Offset(0, -0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutBack)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _shrinkTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.5, end: 1.0).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _flickerTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.bounceIn),
      child: child,
    );
  }
}
