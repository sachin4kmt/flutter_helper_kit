import 'package:flutter/material.dart';

import '../../sharp_corners/sharp.dart';
import '../flutter_tag.dart';
import 'animation/flip_transition.dart';
import 'utils/flutter_calculation_utils.dart';
import 'utils/flutter_drawing_utils.dart';

class FlutterTag extends StatefulWidget {
  const FlutterTag({
    super.key,
    this.tagContent,
    this.child,
    this.tagStyle = const FlutterTagStyle(),
    this.tagAnimation = const FlutterTagAnimation.slide(),
    this.position,
    this.showTag = true,
    this.ignorePointer = false,
    this.stackFit = StackFit.loose,
    this.onTap,
  });

  final Widget? child;
  final FlutterTagStyle tagStyle;
  final FlutterTagAnimation tagAnimation;
  final FlutterTagPosition? position;
  final Widget? tagContent;
  final bool ignorePointer;
  final StackFit stackFit;
  final bool showTag;
  final Function()? onTap;

  @override
  FlutterTagState createState() => FlutterTagState();
}

class FlutterTagState extends State<FlutterTag> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _appearanceController;
  late final Animation<double> _animation;
  late bool enableLoopAnimation;

  @override
  void initState() {
    super.initState();
    enableLoopAnimation =
        widget.tagAnimation.animationDuration.inMilliseconds > 0;

    _animationController = AnimationController(
      duration: widget.tagAnimation.animationDuration,
      reverseDuration: widget.tagAnimation.animationDuration,
      vsync: this,
    );

    _appearanceController = AnimationController(
      duration: widget.tagAnimation.disappearanceFadeAnimationDuration,
      reverseDuration: widget.tagAnimation.disappearanceFadeAnimationDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.tagAnimation.curve,
    );

    if (widget.showTag && widget.tagAnimation.toAnimate) {
      _animationController.forward();
      _appearanceController.forward();

      if (widget.tagAnimation.loopAnimation && enableLoopAnimation) {
        _animationController.repeat(
          period: _animationController.duration,
          reverse: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child == null) {
      return widget.ignorePointer
          ? IgnorePointer(child: _buildTag())
          : GestureDetector(onTap: widget.onTap, child: _buildTag());
    } else {
      return Stack(
        fit: widget.stackFit,
        clipBehavior: Clip.none,
        children: [
          widget.onTap == null
              ? widget.child!
              : Padding(
                  padding:
                      FlutterCalculationUtils.calculatePadding(widget.position),
                  child: widget.child!,
                ),
          FlutterTagPositioned(
            position: widget.onTap == null
                ? widget.position
                : FlutterCalculationUtils.calculatePosition(widget.position),
            child: widget.ignorePointer
                ? IgnorePointer(child: _buildTag())
                : GestureDetector(onTap: widget.onTap, child: _buildTag()),
          ),
        ],
      );
    }
  }

  double _getOpacity() {
    if (!widget.tagAnimation.toAnimate) {
      return widget.showTag ? 1.0 : 0.0;
    } else if (!widget
        .tagAnimation.appearanceDisappearanceFadeAnimationEnabled) {
      return 1.0;
    }
    return _appearanceController.value;
  }

  Widget _buildTag() {
    final border = widget.tagStyle.shape == FlutterTagShape.circle
        ? CircleBorder(
            side: widget.tagStyle.borderGradient == null
                ? widget.tagStyle.borderSide
                : BorderSide.none,
          )
        : SharpRectangleBorder(
            side: widget.tagStyle.borderGradient == null
                ? widget.tagStyle.borderSide
                : BorderSide.none,
            borderRadius: widget.tagStyle.borderRadius,
          );
    final isCustomShape = widget.tagStyle.shape == FlutterTagShape.cloud ||
        widget.tagStyle.shape == FlutterTagShape.star ||
        widget.tagStyle.shape == FlutterTagShape.diamond ||
        widget.tagStyle.shape == FlutterTagShape.pentagon ||
        widget.tagStyle.shape == FlutterTagShape.hexagon;

    final gradientBorder = widget.tagStyle.borderGradient != null
        ? FlutterTagBorderGradient(
            gradient: widget.tagStyle.borderGradient!.gradient(),
            width: widget.tagStyle.borderSide.width,
          )
        : null;

    Widget tagView() {
      return AnimatedBuilder(
        animation: CurvedAnimation(
            parent: _appearanceController, curve: Curves.linear),
        builder: (context, child) {
          return Opacity(
            opacity: _getOpacity(),
            child: isCustomShape
                ? CustomPaint(
                    painter: FlutterDrawingUtils.drawTagShape(
                      shape: widget.tagStyle.shape,
                      color: widget.tagStyle.tagColor,
                      tagGradient: widget.tagStyle.tagGradient,
                      borderGradient: widget.tagStyle.borderGradient,
                      borderSide: widget.tagStyle.borderSide,
                    ),
                    child: Padding(
                      padding: widget.tagStyle.padding,
                      child: widget.tagContent,
                    ),
                  )
                : Material(
                    shape: border,
                    elevation: widget.tagStyle.elevation,
                    type: MaterialType.transparency,
                    child: AnimatedContainer(
                      curve: widget.tagAnimation.colorChangeAnimationCurve,
                      duration: widget.tagAnimation.toAnimate
                          ? widget.tagAnimation.colorChangeAnimationDuration
                          : Duration.zero,
                      decoration: widget.tagStyle.shape ==
                              FlutterTagShape.circle
                          ? BoxDecoration(
                              color: widget.tagStyle.tagColor,
                              border: gradientBorder,
                              gradient: widget.tagStyle.tagGradient?.gradient(),
                              shape: BoxShape.circle,
                            )
                          : BoxDecoration(
                              color: widget.tagStyle.tagColor,
                              gradient: widget.tagStyle.tagGradient?.gradient(),
                              shape: BoxShape.rectangle,
                              borderRadius: widget.tagStyle.borderRadius,
                              border: gradientBorder,
                            ),
                      child: Padding(
                        padding: widget.tagStyle.padding,
                        child: widget.tagContent,
                      ),
                    ),
                  ),
          );
        },
      );
    }

    if (widget.tagAnimation.toAnimate) {
      switch (widget.tagAnimation.animationType) {
        case FlutterTagAnimationType.slide:
          return SlideTransition(
            position: widget.tagAnimation.slideTransitionPositionTween!
                .toTween()
                .animate(_animation),
            child: tagView(),
          );
        case FlutterTagAnimationType.scale:
          return ScaleTransition(scale: _animation, child: tagView());
        case FlutterTagAnimationType.fade:
          return FadeTransition(opacity: _animation, child: tagView());
        case FlutterTagAnimationType.size:
          return SizeTransition(
            sizeFactor: _animation,
            axis: widget.tagAnimation.sizeTransitionAxis ?? Axis.horizontal,
            axisAlignment:
                widget.tagAnimation.sizeTransitionAxisAlignment ?? 1.0,
            child: tagView(),
          );
        case FlutterTagAnimationType.rotation:
          return RotationTransition(turns: _animation, child: tagView());
        case FlutterTagAnimationType.flip:
          return FlipTransition(
              animation: _animation,
              alignment: Alignment.center,
              axis: widget.tagAnimation.sizeTransitionAxis ?? Axis.horizontal,
              child: tagView());

        /*default:
          return tagView();*/
      }
    }

    return tagView();
  }

  @override
  void didUpdateWidget(FlutterTag oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tagAnimation.toAnimate) {
      if (widget.tagStyle.tagColor != oldWidget.tagStyle.tagColor &&
          widget.showTag) {
        _animationController.reset();
        _animationController.forward();
      }

      if (widget.tagAnimation.loopAnimation && enableLoopAnimation) {
        if (_animationController.isAnimating) return;
        _animationController.repeat(
          period: _animationController.duration,
          reverse: true,
        );
        return;
      }

      _handleTextUpdate(oldWidget);
      _handleIconUpdate(oldWidget);
      _handleLoopAnimationChange(oldWidget);
      _handleShowTagChange(oldWidget);
    }
  }

  void _handleTextUpdate(FlutterTag oldWidget) {
    if (widget.tagContent is Text && oldWidget.tagContent is Text) {
      final newText = widget.tagContent as Text;
      final oldText = oldWidget.tagContent as Text;
      if (newText.data != oldText.data &&
          widget.showTag &&
          widget.tagAnimation.toAnimate) {
        _animationController.reset();
        _animationController.forward();
        if (widget.tagAnimation.loopAnimation && enableLoopAnimation) {
          _animationController.repeat(
            period: _animationController.duration,
            reverse: true,
          );
        }
      }
    }
  }

  void _handleIconUpdate(FlutterTag oldWidget) {
    if (widget.tagContent is Icon && oldWidget.tagContent is Icon) {
      final newIcon = widget.tagContent as Icon;
      final oldIcon = oldWidget.tagContent as Icon;
      if (newIcon.icon != oldIcon.icon && widget.showTag) {
        _animationController.reset();
        _animationController.forward();
        if (widget.tagAnimation.loopAnimation && enableLoopAnimation) {
          _animationController.repeat(
            period: _animationController.duration,
            reverse: true,
          );
        }
      }
    }
  }

  void _handleLoopAnimationChange(FlutterTag oldWidget) {
    if (widget.tagAnimation.loopAnimation &&
        !oldWidget.tagAnimation.loopAnimation &&
        enableLoopAnimation) {
      _animationController.repeat(
        period: _animationController.duration,
        reverse: true,
      );
    }
    if (!widget.tagAnimation.loopAnimation &&
        oldWidget.tagAnimation.loopAnimation &&
        enableLoopAnimation) {
      _animationController.forward();
    }
  }

  void _handleShowTagChange(FlutterTag oldWidget) {
    if (widget.showTag && !oldWidget.showTag) {
      _animationController.forward();
      _appearanceController.forward();
    } else if (!widget.showTag && oldWidget.showTag) {
      _animationController.reverse();
      _appearanceController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _appearanceController.dispose();
    super.dispose();
  }
}
