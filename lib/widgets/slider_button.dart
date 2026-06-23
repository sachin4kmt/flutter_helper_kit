//https://github.com/anirudhsharma392/Slider-Button/blob/master/lib/src/slider.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/app_responsive/app_responsive.dart';
import 'package:flutter_helper_kit/core/shimmer_widget.dart';
import 'package:flutter_helper_kit/widgets/sharp_corners/sharp_border_radius.dart';

class SliderButton extends StatefulWidget {
  final Widget? child;
  final double radius;
  final double? height; // Nullable banaya taaki default handle ho sake
  final double? width; // Nullable banaya taaki 1.sw handle ho sake
  final double? buttonSize;
  final double? buttonWidth;
  final Color backgroundColor;
  final Color baseColor;
  final Color highlightedColor;
  final Color buttonColor;
  final Widget? label;
  final Alignment alignLabel;
  final BoxShadow? boxShadow;
  final Widget? icon;
  final Future<bool?> Function() action;
  final bool shimmer;
  final double dismissThresholds;
  final bool disable;
  final Key? buttonKey;
  final bool rightToLeftLocale;
  final bool useGlassEffect;
  final double glassBlurSigma;
  final Color? glassBorderColor;
  final double glassBorderWidth;

  const SliderButton({
    super.key,
    required this.action,
    this.radius = 100,
    this.boxShadow,
    this.child,
    this.shimmer = true,
    this.height, // Default niche handle hoga
    this.buttonSize,
    this.buttonWidth,
    this.width, // Default niche handle hoga
    this.alignLabel = const Alignment(0.6, 0),
    this.backgroundColor = const Color(0xffe0e0e0),
    this.baseColor = Colors.black87,
    this.buttonColor = Colors.white,
    this.highlightedColor = Colors.white,
    this.label,
    this.icon,
    this.dismissThresholds = 0.75,
    this.disable = false,
    this.buttonKey,
    this.rightToLeftLocale = false,
    this.useGlassEffect = false,
    this.glassBlurSigma = 20,
    this.glassBorderColor,
    this.glassBorderWidth = 1.0,
  });

  @override
  State<SliderButton> createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  late bool flag;

  @override
  void initState() {
    super.initState();
    flag = true;
  }

  @override
  Widget build(BuildContext context) {
    // 1. Agar width nahi di, toh screen width se horizontal padding (40) nikal lo
    final double finalWidth = widget.width?.w ?? (1.sw - 40.w);
    // 2. Standard height 60.h agar user ne nahi di
    final double finalHeight = widget.height?.h ?? 60.h;

    return flag == true ? _control(finalWidth, finalHeight) : const SizedBox.shrink();
  }

  Widget _buildTrackContent(double w, double h) {
    // Button size calculation: height ka 85% ya user defined size
    final double bSize = (widget.buttonSize?.h ?? (h * 0.85));

    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        // Label Section
        Align(
          alignment: widget.alignLabel,
          child: widget.shimmer && !widget.disable
              ? ShimmerWidget.fromColors(
                  baseColor: widget.disable ? Colors.grey : widget.baseColor,
                  highlightColor: widget.highlightedColor,
                  child: widget.label ?? const SizedBox.shrink(),
                )
              : widget.label,
        ),

        // Slider Section
        widget.disable ? _buildDisabledButton(w, h, bSize) : _buildDismissibleButton(w, h, bSize),
      ],
    );
  }

  Widget _buildDisabledButton(double w, double h, double bSize) {
    return Tooltip(
      verticalOffset: 50.h,
      message: 'Button is disabled',
      child: Container(
        width: w,
        height: h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: (h - bSize) / 2),
        child: widget.child ?? _defaultButtonIcon(bSize, Colors.grey.shade400),
      ),
    );
  }

  Widget _buildDismissibleButton(double w, double h, double bSize) {
    return Dismissible(
      key: widget.buttonKey ?? UniqueKey(),
      direction: widget.rightToLeftLocale ? DismissDirection.endToStart : DismissDirection.startToEnd,
      dismissThresholds: {widget.rightToLeftLocale ? DismissDirection.endToStart : DismissDirection.startToEnd: widget.dismissThresholds},
      confirmDismiss: (_) async {
        bool result = (await widget.action()) ?? true;
        if (result && mounted) {
          setState(() => flag = false);
        }
        return result;
      },
      child: Container(
        // Drag area ko restricted rakhna zaroori hai
        width: w - (widget.buttonWidth?.w ?? h),
        height: h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: (h - bSize) / 2),
        child: widget.child ?? _defaultButtonIcon(bSize, widget.buttonColor),
      ),
    );
  }

  Widget _defaultButtonIcon(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        boxShadow: widget.boxShadow != null ? [widget.boxShadow!] : null,
        color: color,
        borderRadius: SharpBorderRadius(cornerRadius: widget.radius.r, sharpRatio: 1),
      ),
      child: Center(child: widget.icon),
    );
  }

  Widget _control(double w, double h) {
    final content = _buildTrackContent(w, h);

    final decoration = BoxDecoration(
      color: widget.disable ? Colors.grey.shade700 : widget.backgroundColor,
      borderRadius: SharpBorderRadius(cornerRadius: widget.radius.r, sharpRatio: 1),
      border: (widget.useGlassEffect && widget.glassBorderColor != null)
          ? Border.all(color: widget.glassBorderColor!, width: widget.glassBorderWidth.w)
          : null,
    );

    Widget track = Container(height: h, width: w, decoration: decoration, alignment: Alignment.centerLeft, child: content);

    if (widget.useGlassEffect) {
      return ClipRRect(
        borderRadius: SharpBorderRadius(cornerRadius: widget.radius.r, sharpRatio: 1),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.glassBlurSigma.r, sigmaY: widget.glassBlurSigma.r),
          child: track,
        ),
      );
    }
    return track;
  }
}
