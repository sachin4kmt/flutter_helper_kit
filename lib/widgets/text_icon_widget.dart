

import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/widget_extension.dart';

import '../extensions/string_extension.dart';
import '../utils/decorations.dart';
import 'marquee_widget.dart';

/// A custom widget that displays a text with optional prefix and suffix widgets.
///
/// This widget is useful for displaying a text along with an optional prefix and suffix widgets.
/// It provides options for customizing the appearance of the text, such as text style,
/// maximum lines, overflow behavior, and more.
///

class TextIcon extends StatelessWidget {
  /// The text to display.
  final String? text;

  /// The style of the text.
  final TextStyle? textStyle;

  /// A widget to display before the text.
  final Widget? prefix;

  /// A widget to display after the text.
  final Widget? suffix;

  /// The spacing between the text and prefix/suffix widgets.
  final int spacing;

  /// The maximum number of lines for the text.
  final int? maxLine;

  /// A callback function that is called when the widget is tapped.
  final Function? onTap;

  /// The padding around the container.
  final EdgeInsets? edgeInsets;

  /// Whether the text should expand to fill the available space.
  final bool expandedText;

  /// Whether to use marquee effect for the text if it overflows.
  final bool useMarquee;

  /// The decoration to apply to the container.
  final BoxDecoration? boxDecoration;

  const TextIcon({
    this.text,
    this.textStyle,
    this.prefix,
    this.suffix,
    this.spacing = 4,
    this.maxLine,
    this.onTap,
    this.edgeInsets,
    this.expandedText = false,
    this.useMarquee = false,
    this.boxDecoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: boxDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          prefix != null
              ? Row(children: [prefix!, SizedBox(width: spacing.toDouble())])
              : const SizedBox(),
          if (expandedText && useMarquee)
            Marquee(child: buildText()).expand()
          else if (useMarquee)
            Marquee(child: buildText())
          else if (expandedText)
              buildText().expand()
            else
              buildText(),
          suffix != null
              ? Row(children: [SizedBox(width: spacing.toDouble()), suffix!])
              : const SizedBox(),
        ],
      ),
    ) .onTap(onTap);
  }

  /// Builds the text widget with specified properties.
  Widget buildText() {
    return Text(
      text.validate(),
      style: textStyle ?? primaryTextStyle(),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}