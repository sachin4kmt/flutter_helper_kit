import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.gradient,
    this.debug = false,
  });

  /// The text to display
  final String? text;

  /// The style to apply to the text
  final TextStyle? style;

  /// Gradient for the text
  final Gradient? gradient;

  /// Debug mode to print information
  final bool debug;

  /// Other Text widget parameters
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    if (debug) {
      if (kDebugMode) {
        print('GradientText: Rendering with text: $text');
      }
    }

    final textWidget = Text(
      text ?? '',
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );

    if (gradient == null) {
      return Semantics(
        container: true,
        child: textWidget,
      );
    }

    return Semantics(
      container: true,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          if (debug) {
            if (kDebugMode) {
              print(
                  'GradientText: Creating shader with bounds: $bounds and gradient: $gradient');
            }
          }
          return gradient!.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: textWidget,
      ),
    );
  }
}
