import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

/// Default App Button
class AppButton extends StatefulWidget {
  final Function? onTap;
  final String? text;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Color? disabledColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final Widget? child;
  final double? elevation;
  final double? height;
  final bool enabled;
  final bool? enableScaleAnimation;
  final Color? disabledTextColor;

  const AppButton({
    this.onTap,
    this.text,
    this.width,
    this.color,
    this.textColor,
    this.padding,
    this.margin,
    this.textStyle,
    this.shapeBorder,
    this.child,
    this.elevation,
    this.enabled = true,
    this.height,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.enableScaleAnimation,
    this.disabledTextColor,
    super.key,
  });

  @override
  AppButtonState createState() => AppButtonState();
}

class AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  AnimationController? _controller;

  @override
  void initState() {
    if (widget.enableScaleAnimation.validate(value: true)) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 50,
        ),
        lowerBound: 0.0,
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && widget.enabled) {
      _scale = 1 - _controller!.value;
    }

    if (widget.enableScaleAnimation.validate(value: true)) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: buildButton(),
        ),
      );
    } else {
      return buildButton();
    }
  }

  Widget buildButton() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: MaterialButton(
        minWidth: widget.width,
        padding: widget.padding ??
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        onPressed: widget.enabled
            ? widget.onTap != null
                ? widget.onTap as void Function()?
                : null
            : null,
        color: widget.color ?? Colors.white,
        shape: widget.shapeBorder,
        elevation: widget.elevation,
        animationDuration: const Duration(milliseconds: 300),
        height: widget.height,
        disabledColor: widget.disabledColor,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        splashColor: widget.splashColor,
        disabledTextColor: widget.disabledTextColor,
        child: widget.child ??
            Text(
              widget.text.validate(),
              style: widget.textStyle ??
                  TextStyle(
                    color: widget.textColor ?? textPrimaryColor,
                  ),
            ),
      ),
    );
  }

  final textPrimaryColor = const Color(0xFF2E3033);
}
