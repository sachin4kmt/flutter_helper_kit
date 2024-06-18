import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// TrimMode enum
enum TrimMode {
  length,
  line,
}

class ReadMoreText extends StatefulWidget {
  /// Creates a [ReadMoreText] widget.
  ///
  /// The [data] parameter is the text to be displayed.
  ///
  /// The [trimExpandedText] parameter is the text to be displayed for "read less" link.
  ///
  /// The [trimCollapsedText] parameter is the text to be displayed for "read more" link.
  ///
  /// The [colorClickableText] parameter is the color of the clickable text (read more/read less).
  ///
  /// The [trimLength] parameter is the maximum length of the trimmed text.
  ///
  /// The [trimLines] parameter is the maximum number of lines to display before trimming.
  ///
  /// The [trimMode] parameter determines whether to trim by length or by lines.
  ///
  /// The [style] parameter is the text style to apply.
  ///
  /// The [textAlign] parameter is the alignment of the text within its container.
  ///
  /// The [textDirection] parameter is the text direction to use.
  ///
  /// The [locale] parameter is the locale used to select region-specific data.
  ///
  /// The [textScaleFactor] parameter specifies the amount to scale the text.
  ///
  /// The [semanticsLabel] parameter specifies a label for screen readers.
  const ReadMoreText(
      this.data, {
        Key? key,
        this.trimExpandedText = ' read less',
        this.trimCollapsedText = ' ...read more',
        this.colorClickableText,
        this.trimLength = 240,
        this.trimLines = 2,
        this.trimMode = TrimMode.length,
        this.style,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.textScaleFactor,
        this.semanticsLabel,
      }) : super(key: key);

  /// The text to be displayed.
  final String data;

  /// The text to be displayed for "read less" link.
  final String trimExpandedText;

  /// The text to be displayed for "read more" link.
  final String trimCollapsedText;

  /// The color of the clickable text (read more/read less).
  final Color? colorClickableText;

  /// The maximum length of the trimmed text.
  final int trimLength;

  /// The maximum number of lines to display before trimming.
  final int trimLines;

  /// Determines whether to trim by length or by lines.
  final TrimMode trimMode;

  /// The text style to apply.
  final TextStyle? style;

  /// The alignment of the text within its container.
  final TextAlign? textAlign;

  /// The text direction to use.
  final TextDirection? textDirection;

  /// The locale used to select region-specific data.
  final Locale? locale;

  /// The amount to scale the text.
  final TextScaler? textScaleFactor ;

  /// A label for screen readers.
  final String? semanticsLabel;

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;

    if (widget.style == null || widget.style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScalerOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale = widget.locale ?? Localizations.maybeLocaleOf(context);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).colorScheme.secondary;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle!.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int? endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        TextSpan textSpan;
        switch (widget.trimMode) {
          case TrimMode.length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                    (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return SelectableText.rich(textSpan,
            textAlign: textAlign, textDirection: textDirection);
      },
    );

    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}